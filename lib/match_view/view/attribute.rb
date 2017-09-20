module MatchView
  class Attribute
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def render(target)
      { name => target.public_send(name) }
    end
  end
end
