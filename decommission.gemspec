# -*- encoding: utf-8 -*-
require File.expand_path('../lib/decommission/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrew Nesbitt"]
  gem.email         = ["andrewnez@gmail.com"]
  gem.description   = %q{Quickly discover which versions of rails all your apps are running}
  gem.summary       = %q{Detect old rails apps}
  gem.homepage      = ""
  gem.license       = 'MIT'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "decommission"
  gem.require_paths = ["lib"]
  gem.version       = Decommission::VERSION
  
  gem.add_runtime_dependency("bundler")
  gem.add_runtime_dependency("colorize")
end
