RSpec.describe GenericViewMapper::View do
  Given(:json_source) { load_fixture('view.json') }
  Given(:yaml_source) { load_fixture('view.yml') }

  Given(:object) do
    double(id: 123, active: true, full_name: 'name', foo: 'bar')
  end

  Given(:expected) do
    { summary: { id: 123, isActive: true, name: 'name' }, foo: 'bar' }
  end

  describe 'json import' do
    Given(:view) { described_class.from_json(json_source).new(object) }
    Then { view.as_json == expected }
  end

  describe 'yaml import' do
    Given(:view) { described_class.from_yaml(yaml_source).new(object) }
    Then { view.as_json == expected }
  end
end
