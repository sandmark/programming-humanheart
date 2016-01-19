#!/usr/bin/env ruby

require 'natto'

module MeCab
  Parser = Natto::MeCab.new
  Charset = Parser.dicts.first.charset
  Encode = Charset == 'SHIFT-JIS' ? 'SHIFT_JIS' : Charset

  def analyze(text)
    Parser.parse(text.encode(Encode)).encode('UTF-8')
  end

  module_function :analyze
end

if $0 == __FILE__
  while line = readline.chomp
    break if line.empty?
    puts MeCab::analyze(line)
  end
end
