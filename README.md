# Izzy

[![Build Status](https://travis-ci.org/baweaver/izzy.png?branch=master)](https://travis-ci.org/baweaver/izzy)
[![Code Climate](https://codeclimate.com/github/baweaver/izzy.png)](https://codeclimate.com/github/baweaver/izzy)
[![Coverage Status](https://coveralls.io/repos/baweaver/izzy/badge.png?branch=master)](https://coveralls.io/r/baweaver/izzy?branch=master)

## Izzy Module

To demo Izzy, let's take our class, Person:

```ruby
class Person
  include Izzy # Make sure to include Izzy!
  attr_reader :name, :age, :sex

  def initialize(name, age, sex)
    @name = name
    @age  = age
    @sex  = sex
  end

  def older_than_18?; @age > 18 end

  def younger_than_18?; @age < 18 end

  def male?; @sex == 'm'; end

  def female?; @sex == 'f' end

  def me?; @name == 'brandon' && @sex == 'm' end

  def geek?; @name == 'brandon' end
end
```

So we make our person:
```ruby
brandon = Person.new('brandon', 23, 'm')
```

...and do some comparisons!
```ruby
brandon.all_of?  :older_than_18?, :male?, :me?, :geek? # => true
brandon.none_of? :younger_than_18?, :female?           # => true
brandon.any_of?  :male?, :female?, :geek?              # => true
```

Maybe boolean comparisons aren't your cup of tea. Izzy has you covered my friend:
```ruby
brandon.matches_all?  name: /^br/, age: (20..30) # => true
brandon.matches_any?  name: /br$/, age: (20..30) # => true
brandon.matches_none? name: /br&/, age: (30..40) # => true
```
Izzy compares on === much like a case statement, allowing you to regex and range away! You can even do type checks while you're at it.

```ruby
brandon.matches_all? name: String, age: Integer
```

Why stop there? Need a bit more power? We have Lambdas for that!

```ruby
longer_than_3 = -> n { n.length > 3 }
is_odd = -> a { a.odd? }

brandon.matches_all? name: longer_than_3, age: is_odd # => true
```

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

Simple to the point, no more mess of && or || checks for the same object. All you have to do is include Izzy in your object and you're ready to go!

## Izzy Array Module

But wait! There's more! IzzyArray allows you a few more tricks on top of that!
```ruby
class Array; include IzzyArray end

[0,0,0].all_are :zero?       # => true
[0,nil,'foo'].any_are :zero? # => true
[0,0,0].none_are :nil?       # => true
```

Combine with rails :present?, :empty?, and various other methods and you have some interesting results! This one will get some more power with experimentation.

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
