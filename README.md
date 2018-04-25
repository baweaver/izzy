# Izzy (DEPRECATED)

Izzy has been deprecated in favor of Qo: https://github.com/baweaver/qo

Qo achieves much of the same functionality and more without the need to monkeypatch, and is in many ways the spiritual successor to Izzy. Four years makes a lot of difference!

----------------------

[![Build Status](https://travis-ci.org/baweaver/izzy.png?branch=master)](https://travis-ci.org/baweaver/izzy)
[![Code Climate](https://codeclimate.com/github/baweaver/izzy.png)](https://codeclimate.com/github/baweaver/izzy)
[![Coverage Status](https://coveralls.io/repos/baweaver/izzy/badge.png?branch=master)](https://coveralls.io/r/baweaver/izzy?branch=master)

## Izzy Module

To demo Izzy, let's make a Person:

```ruby
brandon = Person.new('brandon', 23, 'm')
```

### Matchers

Let's do some matching against it:
```ruby
brandon.matches_all?  name: /^br/, age: (20..30) # => true
brandon.matches_any?  name: /br$/, age: (20..30) # => true
brandon.matches_none? name: /br&/, age: (30..40) # => true
```

#### Type Checking

Perhaps you want to type check:
```ruby
brandon.matches_all? name: String, age: Integer
```

#### Lambdas

Need a bit more power? We have Lambdas for that!

```ruby
longer_than_3 = -> n { n.length > 3 }
is_odd = -> a { a.odd? }

brandon.matches_all? name: longer_than_3, age: is_odd # => true
```

### Multi Matchers

....or let's push it further for some interesting results:

```ruby
longer_than_5 = -> n { n.length > 5 }
greater_than_20 = -> a { a > 20 }

brandon.matches_all?(
  name: [/br/, /an/, longer_than_5],
  age: [(20..30), greater_than_20]
)

# => true

```

#### Boolean Matchers

...and do some comparisons on boolean methods!
```ruby
brandon.all_of?  :older_than_18?, :male?, :me?, :geek? # => true
brandon.none_of? :younger_than_18?, :female?           # => true
brandon.any_of?  :male?, :female?, :geek?              # => true
```

## Izzy Array Module

IzzyArray allows you a few more tricks on top of that!
```ruby
class Array; include IzzyArray end

[0,0,0].all_are :zero?       # => true
[0,nil,'foo'].any_are :zero? # => true
[0,0,0].none_are :nil?       # => true
```

Combine with rails :present?, :empty?, and various other methods and you have some interesting results! This one will get some more power with experimentation.

## Izzy Enumerable

Let's get ourselves a collection to use:
```ruby
class Object; include Izzy end

brandon = Person.new('brandon', 23, 'm')
john    = Person.new('john',    42, 'm')
jill    = Person.new('jill',    31, 'f')
alice   = Person.new('alice',   50, 'f')
zeke    = Person.new('zeke',    18, 'm')

people = [brandon, john, jill, alice, zeke]
```

### Select Where

Select all objects where params match:
```ruby
people.select_where name: /^j/
# => [john, jill]

people.select_where(
  age: [
    (20..35),
    -> a { a.odd? }
  ]
)
# => [brandon]
```

### Reject Where

Reject all objects where params match:
```ruby
people.reject_where name: /^j/
# => [brandon, alice, zeke]

people.reject_where(
  age: [
    (20..35),
    -> a { a.odd? }
  ]
)
# => [john, jill, alice, zeke]
```

### Find Where

Finds the first object where params match:
```ruby
people.find_where name: /^j/, gender: 'm'
# => john
```

## Installation

Add this line to your application's Gemfile:

    gem 'izzy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install izzy

## Usage

It patches object, just use it with any method that matches the pattern is_foo? and you're good to go!

## Contributing

1. Fork it ( http://github.com/baweaver/izzy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
