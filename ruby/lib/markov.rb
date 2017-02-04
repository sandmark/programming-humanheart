#!/usr/bin/env ruby
# coding: utf-8

require_relative 'morph'
require_relative 'utils'

class Markov
  ENDMARK = '%END%'
  CHAIN_MAX = 30

  def initialize
    @dic = {}
    @starts = {}
  end

  def add_sentence(parts)
    unless parts.size < 3
      parts = parts.dup
      prefix1, prefix2 = parts.shift[0], parts.shift[0]
      add_start(prefix1)

      parts.each do |suffix, part|
        add_suffix(prefix1, prefix2, suffix)
        prefix1, prefix2 = prefix2, suffix
      end
      add_suffix(prefix1, prefix2, ENDMARK)
    end
  end

  def generate(keyword)
    if @dic.empty?
      nil
    else
      words = []
      prefix1 = (@dic[keyword]) ? keyword : select_start
      prefix2 = select_random(@dic[prefix1].keys)
      words.push(prefix1, prefix2)
      CHAIN_MAX.times do
        suffix = select_random(@dic[prefix1][prefix2])
        break if suffix == ENDMARK
        words.push(suffix)
        prefix1, prefix2 = prefix2, suffix
      end
      words.join
    end
  end

  def load(f)
    @dic = Marshal::load(f)
    @starts = Marshal::load(f)
  end

  def save(f)
    Marshal::dump(@dic, f)
    Marshal::dump(@starts, f)
  end

  private
  def add_suffix(prefix1, prefix2, suffix)
    @dic[prefix1] = {} unless @dic[prefix1]
    @dic[prefix1][prefix2] = [] unless @dic[prefix1][prefix2]
    @dic[prefix1][prefix2].push(suffix)
  end

  def add_start(prefix1)
    @starts[prefix1] = 0 unless @starts[prefix1]
    @starts[prefix1] += 1
  end

  def select_start
    select_random(@starts.keys)
  end
end

if $0 == __FILE__
  markov = Markov.new
  File.read(ARGV[0]).encode('UTF-8').each_line do |line|
    texts = line.chomp.split(/[。?？!！ 　「」『』【】（）]+/)
    texts.each do |text|
      unless text.empty?
        markov.add_sentence(Morph::analyze(text))
        print '.'
      end
    end
  end

  puts

  loop do
    print('> ')
    line = $stdin.readline.chomp
    unless line.empty?
      parts = Morph::analyze(line)
      keyword, p = parts.find{ |w, part| Morph::keyword?(part) }
      puts(markov.generate(keyword))
    end
  end
end
