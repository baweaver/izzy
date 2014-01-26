# Izzy

[![Build Status](https://travis-ci.org/baweaver/izzy.png?branch=master)](https://travis-ci.org/baweaver/izzy)
[![Coverage Status](https://coveralls.io/repos/baweaver/izzy/badge.png?branch=master)](https://coveralls.io/r/baweaver/izzy?branch=master)

Monkey patch to object to make for a nicer time of conditionals! Just install the gem and you're ready to go!


Let's take our class, Person:

```ruby
class Person
  def initialize(name, age, sex)
    @name = name
    @age  = age
    @sex  = sex
  end

  def older_than_18?
    @age > 18
  end

  def younger_than_18?
    @age < 18
  end

  def male?
    @sex == 'm'
  end

  def female?
    @sex == 'f'
  end

  def me?
    @name == 'brandon' && @sex == 'm'
  end

  def geek?
    @name == 'brandon'
  end
end
```

So we make our person:
```ruby
brandon = Person.new('brandon', 23, 'm')
```

...and do some comparisons!
```ruby
brandon.all_of?(:older_than_18, :male, :me, :geek) # => true
brandon.none_of?(:younger_than_18, :female) # => true
brandon.any_of?(:male, :female, :geek) # => true
```

Simple to the point, no more mess of && or || checks for the same object.

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
