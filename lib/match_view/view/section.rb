module MatchView
  class Section
    include SchemaDefinition::DSL

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def render(target)
      { name => attributes.inject({}) { |accum, el| accum.merge(el.render(target)) } }
    end
  end
end
