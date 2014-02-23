require 'spec_helper'

class Object; include Izzy end

class Person
  include Izzy

  attr_reader :name, :age, :sex

  def initialize(name, age, sex)
    @name = name
    @age  = age
    @sex  = sex
  end

  def older_than_18?;   @age > 18                               end
  def younger_than_18?; @age < 18                               end
  def male?;            @sex.eql? 'm'                           end
  def female?;          @sex.eql? 'f'                           end
  def me?;              @name.eql?('brandon') && @sex.eql?('m') end
  def geek?;            @name.eql? 'brandon'                    end
end

brandon = Person.new('brandon', 23, 'm')
john    = Person.new('john',    42, 'm')
jill    = Person.new('jill',    31, 'f')
alice   = Person.new('alice',   50, 'f')
zeke    = Person.new('zeke',    18, 'm')

people = [brandon, john, jill, alice, zeke]

describe 'Person' do
  context 'Boolean Predicates' do
    describe '#all_of?' do
      it 'returns true if Person matches all of the conditions' do
        expect(brandon.all_of? :older_than_18?, :male?, :geek?).to be_true
      end

      it 'returns false if Person does not match all of the conditions' do
        expect(brandon.all_of? :younger_than_18?, :male?).to be_false
      end
    end

    describe '#any_of?' do
      it 'returns true if Person matches any of the conditions' do
        expect(brandon.any_of? :older_than_18?, :female?, :geek?).to be_true
      end

      it 'returns false if Person matches none of the conditions' do
        expect(brandon.any_of? :younger_than_18?, :female?).to be_false
      end
    end

    describe '#none_of?' do
      it 'returns true if Person matches none of the conditions' do
        expect(brandon.none_of? :younger_than_18?, :female?).to be_true
      end

      it 'returns false if Person matches any of the conditions' do
        expect(brandon.none_of? :older_than_18?, :female?, :geek?).to be_false
      end
    end
  end

  context 'Matchers' do
    describe '#matches_all?' do
      it 'returns true if Person matches all of the conditions' do
        expect(
          brandon.matches_all?(name: /br/, age: (20..30))
        ).to be_true
      end

      it 'returns true for multiple conditionals' do
        expect(
          brandon.matches_all?(
            name: [/br/, /an/],
            age: [(20..30), -> a { a < 30 }]
          )
        ).to be_true
      end

      it 'returns false if Person does not match all conditions' do
        expect(
          brandon.matches_all?(name: /br/, age: (25..30))
        ).to be_false
      end
    end

    describe '#matches_any?' do
      it 'returns true if Person matches all of the conditions' do
        expect(
          brandon.matches_any?(name: /br/, age: (25..30))
        ).to be_true
      end

      it 'returns true for multiple conditionals' do
        expect(
          brandon.matches_any?(
            name: [/br/, /an/],
            age: [(30..40), -> a { a > 30 }]
          )
        ).to be_true
      end


      it 'returns false if Person does not match any conditions' do
        expect(
          brandon.matches_any?(name: /br$/, age: (25..30))
        ).to be_false
      end
    end

    describe '#matches_none?' do
      it 'returns true if Person matches none of the conditions' do
        expect(
          brandon.matches_none?(name: /br$/, age: (25..30))
        ).to be_true
      end

      it 'returns true for multiple conditionals' do
        expect(
          brandon.matches_none?(
            name: [/br$/, /foo/],
            age: [(30..40), -> a { a > 30 }]
          )
        ).to be_true
      end

      it 'returns false if Person matches any of the conditions' do
        expect(
          brandon.matches_none?(name: /br/, age: (25..30))
        ).to be_false
      end
    end
  end

  context 'Enumerable Matchers' do
    describe '#select_where' do 
      it 'returns people whose names start with j' do
        expect(people.select_where(name: /^j/)).to eq([john, jill])
      end

      it 'returns people whose ages are above 30' do
        expect(people.select_where(age: -> a { a > 30 })).to eq([john, jill, alice])
      end

      it 'returns people who are male' do
        expect(people.select_where(sex: 'm')).to eq([brandon, john, zeke])
      end
    end

    describe '#reject_where' do
      it 'returns people whose names do not start with j' do
        expect(people.reject_where(name: /^j/)).not_to eq([john, jill])
      end

      it 'returns people whose ages are not above 30' do
        expect(people.reject_where(age: -> a { a > 30 })).not_to eq([john, jill, alice])
      end

      it 'returns people who are not male' do
        expect(people.reject_where(sex: 'm')).not_to eq([brandon, john, zeke])
      end
    end

    describe '#find_where' do
      it 'returns the first person whose name starts with j' do
        expect(people.find_where(name: /^j/)).to eq(john)
      end

      it 'returns the first person whose age is above 30' do
        expect(people.find_where(age: -> a { a > 30 })).to eq(john)
      end

      it 'returns the first person who is male' do
        expect(people.find_where(sex: 'm')).to eq(brandon)
      end
    end
  end
end
