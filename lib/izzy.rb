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
    matchers.all? &matcher_check
  end

  def matches_any?(matchers = {})
    matchers.any? &matcher_check
  end

  def matches_none?(matchers = {})
    matchers.none? &matcher_check
  end

  private

  def method_check
    -> method { (m = "#{method}?".to_sym) && self.respond_to?(m) && self.send(m) }
  end

  def matcher_check
    -> m { (m, val = *m) && self.respond_to?(m) && val === self.send(m) }
  end
end
