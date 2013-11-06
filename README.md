SpreeCpf
========

[![Build Status](https://travis-ci.org/tiagoamaro/spree_cpf.png?branch=master)](https://travis-ci.org/tiagoamaro/spree_cpf)
[![Code Climate](https://codeclimate.com/github/tiagoamaro/spree_cpf.png)](https://codeclimate.com/github/tiagoamaro/spree_cpf)
[![Coverage Status](https://coveralls.io/repos/tiagoamaro/spree_cpf/badge.png)](https://coveralls.io/r/tiagoamaro/spree_cpf)
[![Dependency Status](https://gemnasium.com/tiagoamaro/spree_cpf.png)](https://gemnasium.com/tiagoamaro/spree_cpf)

Spree Extension that adds CPF field in an order

Installation
------------

Add spree_cpf to your Gemfile:

```ruby
gem 'spree_cpf'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_cpf:install
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
require 'spree_cpf/factories'
```

Copyright (c) 2013 Tiago Amaro, released under the MIT License
