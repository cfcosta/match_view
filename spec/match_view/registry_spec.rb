module MockEntities
  class SimpleEntity < MatchView::Entity
  end

  class SimpleView < MatchView::View
  end
end

RSpec.describe MatchView::Registry do
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
