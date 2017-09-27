module MockEntities
  class SimpleEntity < GenericViewMapper::Entity
  end

  class SimpleView < GenericViewMapper::View
  end
end

RSpec.describe GenericViewMapper::Registry do
  Given(:registry) { described_class.new }

  describe '#register' do
    When { registry.register(MockEntities::SimpleEntity) }
    Then { registry[:entities] == [[MockEntities::SimpleEntity, 3]] }
  end

  describe '#registered?' do
    When { registry.register(MockEntities::SimpleEntity) }

    Then { registry.registered?(MockEntities::SimpleEntity) }
    And { !registry.registered?(Object) }
  end

  describe '#register_all' do
    When { registry.register_all }

    Then { registry[:entities].include? [MockEntities::SimpleEntity, 3] }
    And { registry[:views].include? [MockEntities::SimpleView, 2] }
  end
end
