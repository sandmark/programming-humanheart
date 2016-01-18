class Dictionary
  attr_reader :random, :pattern

  def initialize
    @random = File.read('dics/random.txt').split("\n").reject(&:empty?)
    @pattern = File.read('dics/pattern.txt').split("\n").map{ |l| to_pattern(l) }.reject(&:nil?)
  end

  private
  def to_pattern(line)
    pattern, phrases = line.split('<>')
    if pattern.nil? or phrases.nil?
      nil
    else
      PatternItem.new(pattern, phrases)
    end
  end
end

class PatternItem
  attr_reader :modify, :pattern, :phrases

  SEPARATOR = /^((-?\d+)##)?(.*)$/

  def initialize(pattern, phrases)
    SEPARATOR =~ pattern
    @modify, @pattern = $2.to_i, $3
    phrases.split('|').each do |phrase|
      SEPARATOR =~ phrase
      @phrases.push({need: $2.to_i, phrase: $3})
    end
  end

  def match(str)
    str.match(@pattern)
  end

  def choice(mood)
    choices = []
    @phrases.each do |p|
      choices.push(p[:phrase]) if suitable?(p[:need], mood)
    end

    (choises.empty?) ? nil : select_random(choices)
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
