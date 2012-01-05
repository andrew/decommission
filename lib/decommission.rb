require "decommission/version"
require 'bundler'
require 'colorize'

class Decommission
  def self.detect(path = Dir.pwd)
    folders = Dir.glob('*')
    max_length = folders.max_by(&:length).length
    any_rails_apps = false
    folders.each do |folder|
      if rails_app?(folder)
        any_rails_apps = true
        if gemfile_present?(folder)
          version = detect_bundled_version(folder)
          puts "#{folder.ljust(max_length)} #{version}".green
        else
          version = detect_env_version(folder)
          puts "#{folder.ljust(max_length)} #{version}".red
        end
      end
    end
    puts "No rails apps found, run this in your code directory".red unless any_rails_apps
  end

  def self.rails_app?(folder)
    env_path = File.join(folder, 'config', 'environment.rb')
    File.exists?(env_path)
  end

  def self.gemfile_present?(folder)
    gemfile_path = File.join(folder, 'Gemfile')
    File.exists?(gemfile_path)
  end

  def self.detect_bundled_version(folder)
    Dir.chdir folder do
      deps = Bundler::Definition.build('Gemfile', 'Gemfile.lock', {}).dependencies
      rails = deps.select{|s| s.name == 'rails' }.first
      rails.requirement
    end
  end

  def self.detect_env_version(folder)
    env_path = File.join(folder, 'config', 'environment.rb')
    env = open env_path

    env.each_line do |line|
      match = line.match(/RAILS_GEM_VERSION = ['"](.+)['"]/)
      return "= #{match[1]}" if match
    end
    return 'unknown (pre 3.0)'
  end
end
