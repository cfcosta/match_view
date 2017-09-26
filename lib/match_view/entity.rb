require 'virtus'

module MatchView
  class Entity
    include Virtus.model

    def self.applicable?(_)
      raise NotImplementedError, 'should be implemented by subclasses'
    end
  end
end
