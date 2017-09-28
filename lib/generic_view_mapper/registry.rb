require 'active_support/inflector'

module GenericViewMapper
  class Registry
    attr_reader :data

    TRACKED_CLASSES = [
      Entity,
      View
    ].freeze

    def initialize
      @data = Hash.new { |h,k| h[k] = [] }
    end

    def [](val)
      @data[val]
    end

    def reload
      data.clear
      register_all
    end

    def register(*classes)
      classes.each do |klass|
        name = class_name_for(klass)
        @data[name] << [klass, ancestors_count_for(klass)]
      end
    end

    def registered?(klass)
      @data.any? { |(_,k)| k.map(&:first).include?(klass) }
    end

    def register_all
      TRACKED_CLASSES.each do |klass|
        klass.descendants.each { |k| register(k) }
      end
    end

    private

    def class_name_for(klass)
      klass
        .ancestors
        .find { |x| TRACKED_CLASSES.include?(x) }
        .name
        .underscore
        .split('/')
        .last
        .pluralize
        .to_sym
    end

    def ancestors_count_for(klass)
      klass
        .ancestors
        .reverse
        .drop_while { |x| !TRACKED_CLASSES.include?(x) }
        .count
    end
  end
end
