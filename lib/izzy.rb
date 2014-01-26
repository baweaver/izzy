require 'izzy/version'

class Object
  def all_of?(*methods)
    methods.all? { |method| (m = "is_#{method}?".to_sym) && self.respond_to?(m) && self.send(m) }
  end

  def any_of?(*methods)
    methods.any? { |method| (m = "is_#{method}?".to_sym) && self.respond_to?(m) && self.send(m) }
  end

  def none_of?(*methods)
    methods.none? { |method| (m = "is_#{method}?".to_sym) && self.respond_to?(m) && self.send(m) }
  end
end
