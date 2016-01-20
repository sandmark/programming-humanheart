# coding: utf-8

class Responder
  attr_reader :name

  def initialize(name, dictionary)
    @name = name
    @dictionary = dictionary
  end

  protected
  def response(input, parts, mood)
    ''
  end
end

class WhatResponder < Responder
  def response(input, parts, mood)
    "#{input}ってなに？"
  end
end

class RandomResponder < Responder
  def response(input, parts, mood)
    select_random(@dictionary.random)
  end
end

class PatternResponder < Responder
  def response(input, parts, mood)
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

class TemplateResponder < Responder
  def response(input, parts, mood)
    keywords = []
    parts.each do |word, part|
      keywords.push(word) if Morph::keyword?(part)
    end
    count = keywords.size
    if count > 0 and templates = @dictionary.template[count]
      template = select_random(templates)
      template.gsub(/%noun%/){keywords.shift}
    else
      select_random(@dictionary.random)
    end
  end
end
