# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'top_stock_movers/version'

Gem::Specification.new do |spec|
  spec.authors       = ["Christian Thomas"]
  spec.email         = ["christian.thomas.2894@gmail.com"]
  spec.description   = %q{Movies playing}
  spec.summary       = %q{Movies playing}
  spec.homepage      = "https://learn.co"

  spec.files         = `git ls-files`.split($\)
  spec.executables   = ["top-stock-movers"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.name          = "top_stock_movers"
  spec.require_paths = ["lib", "lib/top_stock_movers"]
  spec.version       = TopStockMovers::VERSION
  spec.license       = "MIT"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
