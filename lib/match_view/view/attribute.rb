require 'active_support/inflector'

module GenericViewMapper
  class Attribute
    attr_reader :name, :options

    def initialize(name, options)
      @name = name
      @options = options
    end

    def field_name
      options
        .fetch(:as) { name }
        .to_s
        .camelize(:lower)
        .to_sym
    end

    def send_to(target, view_context)
      name.to_s.split('.').inject(target) do |obj, method|
        if view_context.respond_to?(method)
          view_context.public_send(method)
        else
          obj.public_send(method)
        end
      end
    end

    def render(target, view_context)
      { field_name => send_to(target, view_context) }
    end
  end
end
