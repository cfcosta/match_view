require_relative 'view/schema_definition'
require_relative 'view/import'
require_relative 'view/attribute'
require_relative 'view/section'

require 'descendants_tracker'

module GenericViewMapper
  class View
    extend DescendantsTracker
    include SchemaDefinition
    include Import

    def self.applies_to(*classes)
      @applies_to ||= classes
    end

    def self.applies_to?(object)
      klass = object.is_a?(Class) ? object : object.class
      @applies_to.include?(klass)
    end

    attr_reader :target

    def initialize(target)
      @target = target
    end

    def as_json(*)
      render(target, self)
    end
  end
end
