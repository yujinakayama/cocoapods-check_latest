# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-check_latest'
  spec.version       = '0.0.1' # http://semver.org/
  spec.authors       = ['Yuji Nakayama']
  spec.email         = ['nkymyj@gmail.com']
  spec.description   = 'A CocoaPods plugin that checks if the latest version of a pod is up to date'
  spec.summary       = 'A CocoaPods plugin that checks if the latest version of a pod is up to date'
  spec.homepage      = 'https://github.com/yujinakayama/cocoapods-check_latest'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'cocoapods', '~> 0.28'

  spec.add_development_dependency 'bundler',       '~> 1.3'
  spec.add_development_dependency 'rspec',         '~> 2.99'
  spec.add_development_dependency 'rake',          '~> 10.1'
  spec.add_development_dependency 'simplecov',     '~> 0.8'
  spec.add_development_dependency 'rubocop',       '~> 0.23'
  spec.add_development_dependency 'guard-rspec',   '~> 4.2'
  spec.add_development_dependency 'guard-rubocop', '~> 1.0'
  spec.add_development_dependency 'guard-shell',   '~> 0.5'
  spec.add_development_dependency 'ruby_gntp',     '~> 0.3'
end
