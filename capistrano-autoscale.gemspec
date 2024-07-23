# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/autoscale/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-autoscale"
  spec.version       = Capistrano::Autoscale::VERSION
  spec.authors       = ["Damien Glancy"]
  spec.email         = ["support@clinchtalent.com"]

  spec.summary       = %q{Capistrano plugin for deploying to AWS AutoScale groups.}
  spec.description   = %q{Deploys to all instances in a AWS AutoScale group.}
  spec.homepage      = "https://github.com/ClinchIO/capistrano-autoscale"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.5.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.24.1"
  spec.add_development_dependency "webmock", "~> 3"

  spec.add_dependency 'aws-sdk-core', '~> 3'
  spec.add_dependency 'aws-sdk-ec2', '~> 1'
  spec.add_dependency 'aws-sdk-autoscaling', '~> 1'
  spec.add_runtime_dependency 'capistrano', '~> 3.0', '> 3.0.0'
end
