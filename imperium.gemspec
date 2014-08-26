# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imperium/version'

Gem::Specification.new do |spec|
  spec.name          = 'imperium'
  spec.version       = Imperium::VERSION
  spec.authors       = ['d3lavar & waynesayonara']
  spec.email         = ['d3lavar@gmail.com or waynesayonara@gmail.com']
  spec.summary       = %q{Real-time RPG with turn-based fighting system}
  spec.description   = %q{Real-time RPG with turn-based fighting system}
  spec.homepage      = 'https://github.com/waynesayonara/imperium'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'gosu'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'gosu', '~> 0.7.50'
  spec.add_development_dependency 'rspec', '~> 3.0.0'
  spec.add_development_dependency 'tmx', '~> 0.1.4'
end
