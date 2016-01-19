# coding: utf-8
require_relative 'mecab'

module Morph
  def analyze(text)
    MeCab::analyze(text).split(/\n/).map{ |line| line.split(/\t/) }
  end

  def keyword?(part)
    /名詞,(一般|固有名詞|サ変接続|形容動詞語幹|代名詞)/ =~ part
  end

  module_function :analyze, :keyword?
end
