require 'rails'

module MatchView
  class Railtie < Rails::Railtie
    initializer 'match_view.setup_registry' do
    end
  end
end
