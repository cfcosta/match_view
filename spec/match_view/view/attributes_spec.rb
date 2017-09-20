require_relative '../../spec_helper'
require 'match_view/view'

RSpec.describe MatchView::Attribute do
  Given(:attribute) { described_class.new(:name) }
  Given(:object) { double(name: 'hello') }

  describe '#render' do
    Then { attribute.render(object) == {name: 'hello'} }
  end
end
