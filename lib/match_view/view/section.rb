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

    def render(target)
      { field_name => attributes.inject({}) { |accum, el| accum.merge(el.render(target)) } }
    end
  end
end
