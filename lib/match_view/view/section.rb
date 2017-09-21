module MatchView
  class Section
    include SchemaDefinition::DSL

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def field_name
      name
        .to_s
        .camelize(:lower)
        .to_sym
    end

    def render(target, view_context)
      {
        field_name => attributes.inject({}) do |accum, el|
          accum.merge(el.render(target, view_context))
        end
      }
    end
  end
end
