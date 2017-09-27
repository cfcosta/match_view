module MockRegistryClasses
  class Foo < GenericViewMapper::Entity
    def self.applicable?(data)
      data[:foo]
    end
  end

  class Bar < Foo
    def self.applicable?(data)
      super and data[:bar]
    end
  end

  class FooView < GenericViewMapper::View
    applies_to MockRegistryClasses::Foo, MockRegistryClasses::Bar
  end

  class BarView < FooView
    applies_to MockRegistryClasses::Bar
  end
end

RSpec.describe GenericViewMapper::RegistryMatcher do
  Given(:registry) { GenericViewMapper::Registry.new }
  Given(:matcher) { described_class.new(registry) }

  When do
    registry.register(
      MockRegistryClasses::Foo,
      MockRegistryClasses::Bar,
      MockRegistryClasses::FooView,
      MockRegistryClasses::BarView
    )
  end

  describe '#find_entity_for' do
    Given(:data) { { foo: 'bar' } }

    Then { matcher.find_entity_for(data) == MockRegistryClasses::Foo }
    Then { matcher.find_entity_for(data.merge(bar: 'baz')) == MockRegistryClasses::Bar }
  end

  describe '#find_view_for' do
    Given(:entity_1) { MockRegistryClasses::Foo.new }
    Given(:entity_2) { MockRegistryClasses::Bar.new }

    Then { matcher.find_view_for(entity_1) == MockRegistryClasses::FooView }
    Then { matcher.find_view_for(entity_2) == MockRegistryClasses::BarView }
  end
end
