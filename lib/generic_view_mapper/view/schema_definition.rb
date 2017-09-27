module GenericViewMapper
  module SchemaDefinition
    module DSL
      def attributes
        @attributes ||= if is_a?(Class) && superclass.respond_to?(:attributes)
                          superclass.attributes.clone
                        else
                          []
                        end
      end

      def attributes=(value)
        @attributes = value
      end

      def attribute(name, options = {})
        attributes << Attribute.new(name, options)
      end

      def section(name, &block)
        section = Section.new(name)

        if (old_section = attributes.find { |x| x.name == name })
          attributes.delete(old_section)
          section.attributes += old_section.attributes
        end

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
