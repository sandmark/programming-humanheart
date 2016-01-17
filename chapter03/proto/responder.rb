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
    @phrases = File.read('dics/random.txt').split("\n").reject(&:empty?)
  end

  def response(input)
    select_random(@phrases)
  end

  def select_random(ary)
    ary[rand(ary.size)]
  end
end
