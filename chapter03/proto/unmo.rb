require_relative 'responder'
require_relative 'dictionary'

class Unmo
  attr_reader :name

  def initialize(name)
    @name = name
    @dictionary = Dictionary.new

    @resp_what    = WhatResponder.new('What', @dictionary)
    @resp_random  = RandomResponder.new('Random', @dictionary)
    @resp_pattern = PatternResponder.new('Pattern', @dictionary)
    @responder = @resp_pattern
  end

  def dialogue(input)
    case rand(100)
    when 0..59
      @responder = @resp_pattern
    when 60..89
      @responder = @resp_random
    else
      @responder = @resp_what
    end
    @responder.response(input)
  end

  def responder_name
    @responder.name
  end
end
