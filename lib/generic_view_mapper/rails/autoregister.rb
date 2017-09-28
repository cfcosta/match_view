module GenericViewMapper
  module AutoReload
    def extended(base)
      super(base)
      GenericViewMapper.registry.reload
    end
  end

  class View
    extend AutoReload
  end

  class Entity
    extend AutoReload
  end
end
