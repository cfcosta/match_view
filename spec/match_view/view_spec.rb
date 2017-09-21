require_relative '../spec_helper'
require 'match_view/view'

module MockViews
  class Zero < MatchView::View
  end

  class OneAttribute < MatchView::View
    attribute :name
  end

  class TwoAttributes < MatchView::View
    attribute :name
    attribute :description
  end

  class EmptySection < MatchView::View
    section(:summary) {}
  end

  class SectionWithAttribute < MatchView::View
    section(:summary) { attribute :name }
  end

  class NestedEmptySection < MatchView::View
    section(:summary) { section(:identity) {} }
  end

  class NestedSectionWithAttribute < MatchView::View
    section(:summary) { section(:identity) { attribute :name } }
  end

  class AliasedAttribute < MatchView::View
    attribute :name, as: :fullname
  end

  class AttributeNameTransformation < MatchView::View
    attribute :full_name
  end

  class SectionNameTransformation < MatchView::View
    section(:full_summary) {}
  end

  class DeepObjectIntrospection < MatchView::View
    attribute 'name.last', as: :last_name
  end

  class MethodOverwrite < MatchView::View
    attribute :full_name

    def full_name
      [target.first, target.last].join(' ')
    end
  end

  class Subclassed < OneAttribute
    attribute :surname
  end

  class SubclassedSections < SectionWithAttribute
    section :summary do
      attribute :surname
    end
  end
end

RSpec.describe MatchView::View do
  describe '#as_json' do
    context 'empty entity' do
      Given(:view) { MockViews::Zero.new({}) }
      Then { view.as_json == {} }
    end

    context 'one attribute' do
      Given(:object) { double(name: 'hello') }
      Given(:view) { MockViews::OneAttribute.new(object) }
      Then { view.as_json == { name: 'hello' } }
    end

    context 'two attributes' do
      Given(:object) { double(name: 'hello', description: 'world') }
      Given(:view) { MockViews::TwoAttributes.new(object) }
      Then { view.as_json == { name: 'hello', description: 'world' } }
    end

    context 'empty section' do
      Given(:object) { double }
      Given(:view) { MockViews::EmptySection.new(object) }
      Then { view.as_json == { summary: {} } }
    end

    context 'section with attribute' do
      Given(:object) { double(name: 'hello') }
      Given(:view) { MockViews::SectionWithAttribute.new(object) }
      Then { view.as_json == { summary: { name: 'hello' } } }
    end

    context 'nested empty section' do
      Given(:object) { double(name: 'hello') }
      Given(:view) { MockViews::NestedSectionWithAttribute.new(object) }
      Then { view.as_json == { summary: { identity: { name: 'hello' } } } }
    end

    context 'aliased attribute' do
      Given(:object) { double(name: 'hello') }
      Given(:view) { MockViews::AliasedAttribute.new(object) }
      Then { view.as_json == { fullname: 'hello' } }
    end

    context 'attribute name transformation' do
      Given(:object) { double(full_name: 'hello') }
      Given(:view) { MockViews::AttributeNameTransformation.new(object) }
      Then { view.as_json == { fullName: 'hello' } }
    end

    context 'section name transformation' do
      Given(:object) { double }
      Given(:view) { MockViews::SectionNameTransformation.new(object) }
      Then { view.as_json == { fullSummary: {} } }
    end

    context 'deep object introspection' do
      Given(:object) { double(name: double(last: 'world')) }
      Given(:view) { MockViews::DeepObjectIntrospection.new(object) }
      Then { view.as_json == { lastName: 'world' } }
    end

    context 'method overwrite' do
      Given(:object) { double(first: 'hello', last: 'world') }
      Given(:view) { MockViews::MethodOverwrite.new(object) }
      Then { view.as_json == { fullName: 'hello world' } }
    end

    context 'subclassed' do
      Given(:object) { double(name: 'hello', surname: 'world') }
      Given(:view) { MockViews::Subclassed.new(object) }
      Then { view.as_json == { name: 'hello', surname: 'world' } }
    end

    context 'subclassed sections' do
      Given(:object) { double(name: 'hello', surname: 'world') }
      Given(:view) { MockViews::SubclassedSections.new(object) }
      Then { view.as_json == { summary: { name: 'hello', surname: 'world' } } }
    end
  end
end
