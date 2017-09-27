require 'generic_view_mapper/version'
require 'generic_view_mapper/view'
require 'generic_view_mapper/entity'
require 'generic_view_mapper/registry'
require 'generic_view_mapper/registry_matcher'
require 'generic_view_mapper/railtie' if defined?(Rails::Railtie)

module GenericViewMapper
  def registry
    @registry ||= clear_registry
  end
  module_function :registry

  def clear_registry
    @registry = Registry.new
  end
  module_function :clear_registry
end
