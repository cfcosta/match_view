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

  def matcher
    Thread.current[:gvm_matcher] ||= RegistryMatcher.new(registry)
  end

  def render(*datas)
    processed = datas.map do |data|
      entity = data.is_a?(Hash) ? matcher.find_entity_for(data) : data
      matcher.find_view_for(entity).new(entity)
    end

    processed.size == 1 ? processed.first : processed
  end
end
