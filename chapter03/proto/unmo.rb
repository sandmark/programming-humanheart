require_relative 'responder'

class Unmo
  attr_reader :name

  def initialize(name)
    @name = name
    @responder = RandomResponder.new('Random')
  end

  def dialogue(input)
    @responder.response(input)
  end

  def responder_name
    @responder.name
  end
end
