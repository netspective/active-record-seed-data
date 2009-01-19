# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{seed_data}
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Shahid N. Shah"]
  s.date = %q{2009-01-18}
  s.description = %q{Create seed data rake tasks and use the new Model.create_or_update_seed() method to manage default data.}
  s.email = %q{shahid@shah.org}
  s.files = ["VERSION.yml", "lib/seed_data.rb", "test/seed_data_test.rb", "test/test_helper.rb", "test/database.yml", "test/schema.rb", "test/debug.log", "test/seed_data.sqlite3.db"]
  s.homepage = %q{http://github.com/shah/seed_data}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Adds methods to ActiveRecord to manage seed data that should be loaded into the database.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
