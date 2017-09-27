module MockEntities
  class Simple < GenericViewMapper::Entity
    attribute :foo, String
    attribute :bar, String

    def bar
      super + '1'
    end
  end
end

RSpec.describe GenericViewMapper::Entity do
  describe '.applicable?' do
    Then do
      expect { described_class.applicable?(nil) }
        .to raise_error(NotImplementedError)
    end
  end

  describe 'attributes' do
    Given(:entity) { MockEntities::Simple.new(attributes) }
    Given(:attributes) { { foo: 'bar', bar: 'baz' } }

    describe 'getters' do
      Then { entity.foo == 'bar' }
    end

    describe 'setters' do
      When { entity.foo = 'baz' }
      Then { entity.foo == 'baz' }
    end

    describe 'type coercion' do
      When { entity.foo = 123 }
      Then { entity.foo == '123' }
    end

    describe 'method overwrite' do
      Then { entity.bar == 'baz1' }
    end
  end
end
