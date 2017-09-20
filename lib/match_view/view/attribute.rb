require 'active_support/inflector'

module MatchView
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

    def send_to(target)
      name
        .to_s
        .split('.')
        .inject(target) { |obj, method| obj.public_send(method) }
    end

    def render(target)
      { field_name => send_to(target) }
    end
  end
end
