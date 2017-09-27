require 'virtus'
require 'descendants_tracker'

module GenericViewMapper
  class Entity
    include Virtus.model
    extend DescendantsTracker

    def self.applicable?(_)
      raise NotImplementedError, 'should be implemented by subclasses'
    end
  end
end
