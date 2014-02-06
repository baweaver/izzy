require 'spec_helper'

class Array
  include IzzyArray
end

describe 'IzzyArray' do
  describe '#all_are' do
    it 'returns true if all objects match the method' do
      [0,0,0,0].all_are :zero?
    end

    it 'returns false if any objects do not match the method' do
      [0,1,'foo', nil].all_are :zero?
    end
  end

  describe '#any_are' do
    it 'returns true if any objects match the method' do
      [0,1,'foo', nil].any_are :zero?
    end

    it 'returns false if no objects match the method' do
      [nil, nil, nil].any_are :zero?
    end
  end

  describe '#none_are' do
    it 'returns true if no objects match the method' do
      [nil, nil, nil].none_are :zero?
    end

    it 'returns false if any objects match the method' do
      [nil, nil, nil].none_are :nil?
    end
  end
end