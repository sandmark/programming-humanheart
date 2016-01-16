# coding: utf-8

class Responder
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def response(input)
    ''
  end
end

class WhatResponder < Responder
  def response(input)
    "#{input}ってなに？"
  end
end

class RandomResponder < Responder
  def initialize(name)
    super
    @responses = ['今日はさむいね', 'チョコたべたい', 'きのう１０円ひろった']
  end

  def response(input)
    @responses[rand(@responses.size)]
  end
end
