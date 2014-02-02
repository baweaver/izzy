require 'spec_helper'

class Person
  include Izzy

  attr_reader :name, :age, :sex

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
    @sex.eql? 'm'
  end

  def female?
    @sex.eql? 'f'
  end

  def me?
    @name.eql?('brandon') && @sex.eql?('m')
  end

  def geek?
    @name.eql? 'brandon'
  end
end

describe 'Person' do
  before(:all) { @person = Person.new('brandon', 23, 'm') }

  describe '#all_of?' do
    it 'returns true if Person matches all of the conditions' do
      expect(@person.all_of? :older_than_18?, :male?, :geek?).to be_true
    end

    it 'returns false if Person does not match all of the conditions' do
      expect(@person.all_of? :younger_than_18, :male?).to be_false
    end
  end

  describe '#any_of?' do
    it 'returns true if Person matches any of the conditions' do
      expect(@person.any_of? :older_than_18?, :female?, :geek?).to be_true
    end

    it 'returns false if Person matches none of the conditions' do
      expect(@person.any_of? :younger_than_18, :female?).to be_false
    end
  end

  describe '#none_of?' do
    it 'returns true if Person matches none of the conditions' do
      expect(@person.none_of? :younger_than_18, :female?).to be_true
    end

    it 'returns false if Person matches any of the conditions' do
      expect(@person.none_of? :older_than_18?, :female?, :geek?).to be_false
    end
  end

  describe '#matches_all?' do
    it 'returns true if Person matches all of the conditions' do
      expect(
        @person.matches_all?(name: /br/, age: (20..30))
      ).to be_true
    end

    it 'returns true for multiple conditionals' do
      expect(
        @person.matches_all?(
          name: [/br/, /an/],
          age: [(20..30), -> a { a < 30 }]
        )
      ).to be_true
    end

    it 'returns false if Person does not match all conditions' do
      expect(
        @person.matches_all?(name: /br/, age: (25..30))
      ).to be_false
    end
  end

  describe '#matches_any?' do
    it 'returns true if Person matches all of the conditions' do
      expect(
        @person.matches_any?(name: /br/, age: (25..30))
      ).to be_true
    end

    it 'returns true for multiple conditionals' do
      expect(
        @person.matches_any?(
          name: [/br/, /an/],
          age: [(30..40), -> a { a > 30 }]
        )
      ).to be_true
    end


    it 'returns false if Person does not match any conditions' do
      expect(
        @person.matches_any?(name: /br$/, age: (25..30))
      ).to be_false
    end
  end

  describe '#matches_none?' do
    it 'returns true if Person matches none of the conditions' do
      expect(
        @person.matches_none?(name: /br$/, age: (25..30))
      ).to be_true
    end

    it 'returns true for multiple conditionals' do
      expect(
        @person.matches_none?(
          name: [/br$/, /foo/],
          age: [(30..40), -> a { a > 30 }]
        )
      ).to be_true
    end

    it 'returns false if Person matches any of the conditions' do
      expect(
        @person.matches_none?(name: /br/, age: (25..30))
      ).to be_false
    end
  end
end
