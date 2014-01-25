class Object
  METHOD_CHECK = -> method { "is_#{method}?".to_sym.tap { |m| self.respond_to?(m) && self.send(m) }}

  def is_all_of(*methods)
    methods.all?(&METHOD_CHECK)
  end

  def is_any_of(*methods)
    methods.any?(&METHOD_CHECK)
  end

  def is_none_of(*methods)
    methods.none?(&METHOD_CHECK)
  end
end
