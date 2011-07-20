# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "to_csv"
  s.version     = 0.0.1
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ary Djmal"]
  s.email       = ["arydjmal@gmail.com"]
  s.homepage    = "https://github.com/arydjmal/to_csv"
  s.summary     = %q{Gem to dump to a CSV.}
  s.description = %q{Gem to dump to a CSV.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "fastercsv"
  s.add_development_dependency "actionpack"
  s.add_development_dependency "rails", ">= 3.0.4"
  s.add_development_dependency "capybara", ">= 0.4.0"
end
