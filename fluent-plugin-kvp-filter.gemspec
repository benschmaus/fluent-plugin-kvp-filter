# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "fluent-plugin-kvp-filter"
  gem.description   = "Fluent filter plugin for parsing key/value fields in records"
  gem.homepage      = "https://github.com/matt-deboer/fluent-plugin-kvp-filter"
  gem.summary       = gem.description
  gem.version       = %x[git describe --tags --always | sed 's/-[0-9]-.*/.pre/']
  gem.authors       = ["Matt DeBoer"]
  gem.email         = ["matt.deboer@gmail.com"]
  gem.has_rdoc      = false
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency "fluentd", '>= 0.14.0'
  gem.add_dependency "logfmt"
  gem.add_development_dependency "rake"
  gem.add_development_dependency 'test-unit'
end

