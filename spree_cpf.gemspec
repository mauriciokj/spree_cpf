# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_cpf'
  s.version     = '2.1.2'
  s.summary     = 'Spree extension that adds CPF to address field'
  s.description = 'Spree extension that adds CPF to address field'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Tiago Amaro'
  s.email     = 'tiagocis@gmail.com'
  s.homepage  = 'https://github.com/tiagoamaro/spree_cpf'
  s.license   = 'MIT'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.1'

  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'poltergeist', '~> 1.4.1'
  s.add_development_dependency 'pry', '~> 0.9.12.2'
  s.add_development_dependency 'fuubar', '~> 1.2.1'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'sqlite3'
end
