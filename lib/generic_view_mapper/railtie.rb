require 'rails'

module MatchView
  class Railtie < Rails::Railtie
    initializer 'generic_view_mapper.setup_registry' do
      GenericViewMapper.registry.reload
    end
  end
end
