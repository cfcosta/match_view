module GenericViewMapper
  class RegistryMatcher
    attr_reader :registry

    def initialize(registry)
      @registry = registry
    end

    def find_entity_for(data)
      get_list_for(:entities)
        .find { |x| x.applicable?(data) }
    end

    def find_view_for(entity)
      get_list_for(:views)
        .find { |x| x.applies_to?(entity) }
    end

    private def get_list_for(key)
      registry[key]
        .sort { |a,b| b.last <=> a.last }
        .map { |x| x.first }
    end
  end
end
