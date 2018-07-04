SpreeDocumento
========

[![Build Status](https://travis-ci.org/tiagoamaro/spree_documento.png?branch=2-1-stable)](https://travis-ci.org/tiagoamaro/spree_documento)
[![Coverage Status](https://coveralls.io/repos/tiagoamaro/spree_documento/badge.png?branch=2-1-stable)](https://coveralls.io/r/tiagoamaro/spree_documento?branch=2-1-stable)
[![Dependency Status](https://gemnasium.com/tiagoamaro/spree_documento.png)](https://gemnasium.com/tiagoamaro/spree_documento)

Spree Extension that adds CPF field in an order

Installation
------------

Add spree_documento to your Gemfile:

```ruby
gem 'spree_documento'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_documento:install
```

Set the preference in an initializer such as config/initializers/spree.rb:

```ruby
Spree.config do |config|
  config.ship_address_has_documento = true # Default is false
end
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_documento/factories'
```

Copyright (c) 2014 Tiago Amaro, released under the MIT License
