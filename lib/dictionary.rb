# coding: utf-8

class Dictionary
  attr_reader :random, :pattern

  def initialize
    @random = File.read('dics/random.txt', encoding: Encoding::UTF_8).split("\n").reject(&:empty?)
    @pattern = File.read('dics/pattern.txt', encoding: Encoding::UTF_8).split("\n").map{ |l| to_pattern(l) }.reject(&:nil?)
  end

  def study(input, parts)
    study_random(input)
    study_pattern(input, parts)
  end

  def save
    File.open('dics/random.txt', 'w') do |f|
      f.puts(@random)
    end

    File.open('dics/pattern.txt', 'w') do |f|
      @pattern.each{ |item| f.puts(item.make_line) }
    end
  end

  private
  def to_pattern(line)
    pattern, phrases = line.split(/\t/)
    if pattern.nil? or phrases.nil?
      nil
    else
      PatternItem.new(pattern, phrases)
    end
  end

  def study_random(input)
    @random.push(input) unless @random.include?(input)
  end

  def study_pattern(input, parts)
    parts.each do |word, part|
      next unless Morph::keyword?(part)
      duped = @pattern.find{ |item| item.pattern == word }
      if duped
        duped.add_phrase(input)
      else
        @pattern.push(PatternItem.new(word, input))
      end
    end
  end
end

class PatternItem
  attr_reader :modify, :pattern, :phrases

  SEPARATOR = /^((-?\d+)##)?(.*)$/

  def initialize(pattern, phrases)
    @phrases = []
    SEPARATOR =~ pattern
    @modify, @pattern = $2.to_i, $3
    phrases.split('|').each do |phrase|
      SEPARATOR =~ phrase
      @phrases.push({need: $2.to_i, phrase: $3})
    end
  end

  def add_phrase(phrase)
    unless @phrases.find{ |p| p[:phrase] == phrase }
      @phrases.push({need: 0, phrase: phrase})
    end
  end

  def make_line
    pattern = @modify.to_s + "##" + @pattern
    phrases = @phrases.map{ |p| p[:need].to_s + "##" + p[:phrase] }
    "#{pattern}\t#{phrases.join('|')}"
  end

  def match(str)
    str.match(@pattern)
  end

  def choice(mood)
    choices = []
    @phrases.each do |p|
      choices.push(p[:phrase]) if suitable?(p[:need], mood)
    end

    (choices.empty?) ? nil : select_random(choices)
  end

  def suitable?(need, mood)
    return true if need == 0
    if need > 0
      mood > need
    else
      mood < need
    end
  end
end
