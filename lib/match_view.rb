require 'match_view/version'
require 'match_view/view'
require 'match_view/entity'
require 'match_view/registry'
require 'match_view/railtie' if defined?(Rails::Railtie)

module MatchView
  def registry
    @registry ||= clear_registry
  end
  module_function :registry

  def clear_registry
    @registry = Registry.new
  end
  module_function :clear_registry
end
