require 'izzy/version'

module Izzy
  def all_of?(*methods)
    methods.all? &method_check
  end

  def any_of?(*methods)
    methods.any? &method_check
  end

  def none_of?(*methods)
    methods.none? &method_check
  end

  def matches_all?(matchers = {})
    matchers.all? &matcher_check(:all?)
  end

  def matches_any?(matchers = {})
    matchers.any? &matcher_check(:any?)
  end

  def matches_none?(matchers = {})
    matchers.none? &matcher_check(:any?)
  end

  private

  def method_check
    -> m { self.respond_to?(m) && self.send(m) }
  end

  def matcher_check(type = :all?)
    -> matcher { 
      m, val = *matcher
      values = val.is_a?(Array) ? val : Array[val]
      values.send(type) { |v| self.respond_to?(m) && v === self.send(m) }
    }
  end
end
