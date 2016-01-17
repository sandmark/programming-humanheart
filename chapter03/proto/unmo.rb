require_relative 'responder'

class Unmo
  attr_reader :name

  def initialize(name)
    @name = name
    @resp_what = WhatResponder.new('What')
    @resp_random = RandomResponder.new('Random')
    @responder = @resp_random
  end

  def dialogue(input)
    @responder = rand(2) == 0 ? @resp_what : @resp_random
    @responder.response(input)
  end

  def responder_name
    @responder.name
  end
end
