require 'izzy/version'

module Izzy
  def all_of?(*methods)
    methods.all? { |method| (m = "#{method}?".to_sym) && self.respond_to?(m) && self.send(m) }
  end

  def any_of?(*methods)
    methods.any? { |method| (m = "#{method}?".to_sym) && self.respond_to?(m) && self.send(m) }
  end

  def none_of?(*methods)
    methods.none? { |method| (m = "#{method}?".to_sym) && self.respond_to?(m) && self.send(m) }
  end
end
