require 'izzy/version'

module Izzy
  def all_of?(*methods)
    methods.all? { |m| respond_to?(m) && send(m) }
  end

  def any_of?(*methods)
    methods.any? { |m| respond_to?(m) && send(m) }
  end

  def none_of?(*methods)
    methods.none? { |m| respond_to?(m) && send(m) }
  end
end
