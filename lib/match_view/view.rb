require_relative 'view/schema_definition'
require_relative 'view/attribute'
require_relative 'view/section'

module MatchView
  class View
    include SchemaDefinition
    attr_reader :target

    def initialize(target)
      @target = target
    end

    def as_json(*)
      render(target, self)
    end
  end
end
