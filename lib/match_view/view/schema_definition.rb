module MatchView
  module SchemaDefinition
    module DSL
      def attributes
        @attributes ||= []
      end

      def attribute(name, options = {})
        attributes << Attribute.new(name, options)
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

    def render(target, view_context)
      self.class.attributes.inject({}) do |accum, el|
        accum.merge(el.render(target, view_context))
      end
    end
  end
end
