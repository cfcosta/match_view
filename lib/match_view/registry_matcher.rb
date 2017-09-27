module GenericViewMapper
  class RegistryMatcher
    attr_reader :registry

    def initialize(registry)
      @registry = registry
    end

    def find_entity_for(data)
      registry[:entities]
        .sort { |a,b| b.last <=> a.last }
        .map { |x| x.first }
        .find { |x| x.applicable?(data) }
    end

    def find_view_for(entity)
      klass = entity.is_a?(Class) ? entity.class : entity

      registry[:views]
        .sort { |a,b| b.last <=> a.last }
        .map { |x| x.first }
        .find { |x| x.applies_to?(klass) }
    end
  end
end
