module MatchView
  module SchemaDefinition
    module DSL
      def attributes
        @attributes ||= []
      end

      def attribute(name)
        attributes << Attribute.new(name)
      end

      def section(name, &block)
        section = Section.new(name)
        section.instance_eval(&block)

        attributes << section
      end
    end

    def self.included(base)
      base.extend(DSL)
    end

    def render(target)
      self.class.attributes.inject({}) do |accum, el|
        accum.merge(el.render(target))
      end
    end
  end
end
