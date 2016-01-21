# coding: utf-8

class Dictionary
  attr_reader :random, :pattern, :template, :markov

  RANDOM = 'dics/random.txt'
  PATTERN = 'dics/pattern.txt'
  TEMPLATE = 'dics/template.txt'
  MARKOV = 'dics/markov.dat'

  def initialize
    load_random
    load_pattern
    load_template
    load_markov
  end

  def study(input, parts)
    study_random(input)
    study_pattern(input, parts)
    study_template(parts)
    study_markov(parts)
  end

  def save
    File.open(RANDOM, 'w') do |f|
      f.puts(@random)
    end

    File.open(PATTERN, 'w') do |f|
      @pattern.each{ |item| f.puts(item.make_line) }
    end

    File.open(TEMPLATE, 'w') do |f|
      @template.each.with_index do |templates, i|
        next if templates.nil?
        templates.each do |template|
          f.puts("#{i}\t#{template}")
        end
      end
    end

    File.open(MARKOV, 'wb') do |f|
      @markov.save(f)
    end
  end

  private
  def study_markov(parts)
    @markov.add_sentence(parts)
  end

  def load_markov
    @markov = Markov.new
    File.open(MARKOV, 'rb') do |f|
      @markov.load(f)
    end
  rescue => e
    puts(e.message)
  end

  def load_template
    @template = []
    read_file(TEMPLATE).each_line do |line|
      count, template = line.split(/\t/)
      next if count.nil? or pattern.nil?
      count = count.to_i
      @template[count] = [] unless @template[count]
      @template[count].push(template)
    end
  rescue Errno::ENOENT
    @template = []
  end

  def load_random
    @random = read_file(RANDOM).split(/\n/).reject(&:empty?)
  rescue Errno::ENOENT
    @random = ['こんにちは']
  end

  def load_pattern
    @pattern = read_file(PATTERN).split(/\n/).map{ |l| to_pattern(l) }.reject(&:nil?)
  rescue Errno::ENOENT
    @pattern = []
  end

  def read_file(file)
    File.read(file, encoding: Encoding::UTF_8)
  end

  def to_pattern(line)
    pattern, phrases = line.split(/\t/)
    if pattern.nil? or phrases.nil?
      nil
    else
      PatternItem.new(pattern, phrases)
    end
  end

  def study_template(parts)
    template = ''
    count = 0
    parts.each do |word, part|
      if Morph::keyword?(part)
        word = '%noun%'
        count += 1
      end
      template += word
    end
    return unless count > 0

    @template[count] = [] unless @template[count]
    unless @template[count].include?(template)
      @template[count].push(template)
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
