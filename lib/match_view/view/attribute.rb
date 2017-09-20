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

    def render(target)
      { field_name => target.public_send(name) }
    end
  end
end
