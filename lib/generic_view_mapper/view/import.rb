require 'yaml'

require 'multi_json'
require 'active_support/core_ext/hash/keys'

module GenericViewMapper
  module Import
    def self.included(base)
      base.extend DSL
    end

    module DSL
      def json(source)
        import(MultiJson.decode(source, symbolize_keys: true))
      end

      def from_json(source)
        Class.new(self) { json(source) }
      end

      def yaml(source)
        import(YAML.safe_load(source).deep_symbolize_keys)
      end

      def from_yaml(source)
        Class.new(self) { yaml(source) }
      end

      def import(hash)
        hash.each do |(k, v)|
          case v
          when Hash
            attribute(v[:name], v)
          when Array
            section(k) { v.each { |f| attribute(f[:name], f) } }
          end
        end
      end
    end
  end
end
