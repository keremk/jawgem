# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jawgem/version'

Gem::Specification.new do |spec|
  spec.name          = "jawgem"
  spec.version       = Jawgem::VERSION
  spec.authors       = ["Kerem Karatal"]
  spec.email         = ["kkaratal@gmail.com"]
  spec.description   = %q{Client library for Jawbone API.}
  spec.summary       = %q{Client library for Jawbone API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "4.0.0"
  spec.add_dependency "oauth2", "~> 0.9"
  
  spec.add_development_dependency "rspec", "~> 2.13"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
