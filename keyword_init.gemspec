# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'keyword_init/version'

Gem::Specification.new do |spec|
  spec.name                  = "keyword_init"
  spec.version               = KeywordInit::VERSION
  spec.authors               = ["Eduardo Turiño"]
  spec.email                 = ["eturino@eturino.com"]
  spec.summary               = %q{Gem that provides a keyword argument based initialize method to a class, executing the setter of all the recognised keywords.}
  # spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage              = ""
  spec.license               = "MIT"
  spec.files                 = `git ls-files -z`.split("\x0")
  spec.executables           = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files            = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths         = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "pry-rescue"
  spec.add_development_dependency "pry-stack_explorer"
  spec.add_development_dependency "pry-doc"

end
