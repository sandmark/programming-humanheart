#!/usr/bin/env ruby

require 'natto'

module MeCab
  Parser = Natto::MeCab.new

  def analyze(text)
    Parser.parse(text)
  end

  module_function :analyze
end

if $0 == __FILE__
  while line = readline.chomp
    break if line.empty?
    puts MeCab::analyze(line)
  end
end
