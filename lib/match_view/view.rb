require_relative 'view/schema_definition'
require_relative 'view/import'
require_relative 'view/attribute'
require_relative 'view/section'

require 'descendants_tracker'

module MatchView
  class View
    extend DescendantsTracker
    include SchemaDefinition
    include Import

    attr_reader :target

    def initialize(target)
      @target = target
    end

    def as_json(*)
      render(target, self)
    end
  end
end
