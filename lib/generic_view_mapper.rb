require 'generic_view_mapper/version'
require 'generic_view_mapper/view'
require 'generic_view_mapper/entity'
require 'generic_view_mapper/registry'
require 'generic_view_mapper/registry_matcher'

if defined?(Rails::Railtie)
  require 'generic_view_mapper/rails/autoregister'
  require 'generic_view_mapper/railtie'
end

module GenericViewMapper
  extend self

  def registry
    Thread.current[:gvm_registry] ||= Registry.new.tap(&:register_all)
  end

  def render(data)
    matcher = RegistryMapper.new(registry)
    matcher.find_view_for(matcher.find_entity_for(data))
  end
end
