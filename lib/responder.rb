# coding: utf-8

class Responder
  attr_reader :name

  def initialize(name, dictionary)
    @name = name
    @dictionary = dictionary
  end

  protected
  def response(input, mood)
    ''
  end
end

class WhatResponder < Responder
  def response(input, mood)
    "#{input}ってなに？"
  end
end

class RandomResponder < Responder
  def response(input, mood)
    select_random(@dictionary.random)
  end
end

class PatternResponder < Responder
  def response(input, mood)
    @dictionary.pattern.each do |item|
      if m = item.match(input)
        resp = item.choice(mood)
        next if resp.nil?
        return resp.gsub(/%match%/, m.to_s)
      end
    end

    select_random(@dictionary.random)
  end
end
