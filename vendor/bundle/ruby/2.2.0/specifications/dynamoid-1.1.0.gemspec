# -*- encoding: utf-8 -*-
# stub: dynamoid 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "dynamoid"
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Josh Symonds", "Logan Bowers", "Craig Heneveld", "Anatha Kumaran", "Jason Dew", "Luis Arias", "Stefan Neculai", "Philip White", "Peeyush Kumar"]
  s.date = "2015-12-30"
  s.description = "Dynamoid is an ORM for Amazon's DynamoDB that supports offline development, associations, querying, and everything else you'd expect from an ActiveRecord-style replacement."
  s.extra_rdoc_files = ["LICENSE.txt", "README.markdown"]
  s.files = ["LICENSE.txt", "README.markdown"]
  s.homepage = "http://github.com/Dynamoid/Dynamoid"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Dynamoid is an ORM for Amazon's DynamoDB"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, ["~> 4"])
      s.add_runtime_dependency(%q<aws-sdk-resources>, ["~> 2"])
      s.add_runtime_dependency(%q<concurrent-ruby>, [">= 1.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<github-markup>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
    else
      s.add_dependency(%q<activemodel>, ["~> 4"])
      s.add_dependency(%q<aws-sdk-resources>, ["~> 2"])
      s.add_dependency(%q<concurrent-ruby>, [">= 1.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<github-markup>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<coveralls>, [">= 0"])
    end
  else
    s.add_dependency(%q<activemodel>, ["~> 4"])
    s.add_dependency(%q<aws-sdk-resources>, ["~> 2"])
    s.add_dependency(%q<concurrent-ruby>, [">= 1.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<github-markup>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<coveralls>, [">= 0"])
  end
end
