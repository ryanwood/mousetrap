# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mousetrap}
  s.version = "0.5.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jon Larkowski", "Sandro Turriate", "Wolfram Arnold", "Corey Grusden"]
  s.date = %q{2010-05-04}
  s.description = %q{CheddarGetter API Client in Ruby}
  s.email = %q{jonlarkowski@gmail.com}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "MIT-LICENSE",
     "README.textile",
     "Rakefile",
     "VERSION",
     "lib/mousetrap.rb",
     "lib/mousetrap/customer.rb",
     "lib/mousetrap/invoice.rb",
     "lib/mousetrap/plan.rb",
     "lib/mousetrap/resource.rb",
     "lib/mousetrap/subscription.rb",
     "mousetrap.gemspec",
     "script/authenticate.rb",
     "script/cheddar_getter.example.yml",
     "script/console",
     "spec/factories.rb",
     "spec/integration/settings.example.yml",
     "spec/integration/smoke_test.rb",
     "spec/integration/spike.rb",
     "spec/mousetrap/customer_spec.rb",
     "spec/mousetrap/plan_spec.rb",
     "spec/mousetrap/resource_spec.rb",
     "spec/mousetrap/subscription_spec.rb",
     "spec/mousetrap_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/support/fixtures.rb",
     "spec/support/random_data.rb"
  ]
  s.homepage = %q{http://github.com/hashrocket/mousetrap}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{CheddarGetter API Client in Ruby}
  s.test_files = [
    "spec/factories.rb",
     "spec/integration/smoke_test.rb",
     "spec/integration/spike.rb",
     "spec/mousetrap/customer_spec.rb",
     "spec/mousetrap/plan_spec.rb",
     "spec/mousetrap/resource_spec.rb",
     "spec/mousetrap/subscription_spec.rb",
     "spec/mousetrap_spec.rb",
     "spec/spec_helper.rb",
     "spec/support/fixtures.rb",
     "spec/support/random_data.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.4.2"])
      s.add_development_dependency(%q<activesupport>, [">= 2.3.3"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<factory_girl>, [">= 1.2.3"])
    else
      s.add_dependency(%q<httparty>, [">= 0.4.2"])
      s.add_dependency(%q<activesupport>, [">= 2.3.3"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<factory_girl>, [">= 1.2.3"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.4.2"])
    s.add_dependency(%q<activesupport>, [">= 2.3.3"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<factory_girl>, [">= 1.2.3"])
  end
end

