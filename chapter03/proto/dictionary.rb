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
      {pattern: pattern, phrases: phrases}
    end
  end
end
