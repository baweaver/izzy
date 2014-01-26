require 'spec_helper'

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
    @sex.eql? 'm'
  end

  def is_female?
    @sex.eql? 'f'
  end

  def is_me?
    @name.eql?('brandon') && @sex.eql?('m')
  end

  def is_geek?
    @name.eql? 'brandon'
  end
end

describe 'Person' do
  before(:all) { @person = Person.new('brandon', 23, 'm') }

  describe '#all_of?' do
    it 'returns true if Person matches all of the conditions' do
      expect(@person.all_of? :older_than_18, :male, :geek).to be_true
    end

    it 'returns false if Person does not match all of the conditions' do
      expect(@person.all_of? :younger_than_18, :male).to be_false
    end
  end

  describe '#any_of?' do
    it 'returns true if Person matches any of the conditions' do
      expect(@person.any_of? :older_than_18, :female, :geek).to be_true
    end

    it 'returns false if Person matches none of the conditions' do
      expect(@person.any_of? :younger_than_18, :female).to be_false
    end
  end

  describe '#none_of?' do
    it 'returns true if Person matches none of the conditions' do
      expect(@person.none_of? :younger_than_18, :female).to be_true
    end

    it 'returns false if Person matches any of the conditions' do
      expect(@person.none_of? :older_than_18, :female, :geek).to be_false
    end
  end
end
