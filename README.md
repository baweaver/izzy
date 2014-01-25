# Izzy

Monkey patch to object to make for a nicer time of conditionals!

Let's take our class, Person:

```ruby
class Person
  def initialize(name, age, sex)
    @name = name
    @age  = age
    @sex  = sex
  end

  def is_older_than_18?
    @age > 18
  end

  def is_younger_than_18?
    @age < 18
  end

  def is_male?
    @sex == 'm'
  end

  def is_female?
    @sex == 'f'
  end

  def is_me?
    @name == 'brandon' && @sex == 'm'
  end

  def is_geek?
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
brandon.is_all_of(:older_than_18, :male, :me, :geek) # => true
brandon.is_none_of(:younger_than_18, :female) # => true
brandon.is_any_of(:male, :female, :geek) # => true
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

1. Fork it ( http://github.com/<my-github-username>/izzy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
