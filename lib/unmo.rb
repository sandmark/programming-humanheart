# coding: utf-8

require_relative 'responder'
require_relative 'dictionary'

class Unmo
  attr_reader :name

  def initialize(name)
    @name = name
    @dictionary = Dictionary.new
    @emotion = Emotion.new(@dictionary)

    @resp_what    = WhatResponder.new('What', @dictionary)
    @resp_random  = RandomResponder.new('Random', @dictionary)
    @resp_pattern = PatternResponder.new('Pattern', @dictionary)
    @responder = @resp_pattern
  end

  def dialogue(input)
    input.encode!('UTF-8')
    @emotion.update(input)

    case rand(100)
    when 0..59
      @responder = @resp_pattern
    when 60..89
      @responder = @resp_random
    else
      @responder = @resp_what
    end

    resp = @responder.response(input, @emotion.mood)
    @dictionary.study(input)
    resp
  end

  def responder_name
    @responder.name
  end

  def mood
    @emotion.mood
  end

  def save
    @dictionary.save
  end
end

class Emotion
  attr_reader :mood

  MOOD_MIN = -15
  MOOD_MAX = 15
  MOOD_RECOVERY = 0.5

  def initialize(dictionary)
    @dictionary = dictionary
    @mood = 0
  end

  def update(input)
    @dictionary.pattern.each do |item|
      if item.match(input)
        adjust_mood(item.modify)
        break
      end
    end

    if @mood < 0
      @mood += MOOD_RECOVERY
    elsif @mood > 0
      @mood -= MOOD_RECOVERY
    end
  end

  def adjust_mood(val)
    @mood += val
    if @mood > MOOD_MAX
      @mood = MOOD_MAX
    elsif @mood < MOOD_MIN
      @mood = MOOD_MIN
    end
  end
end
