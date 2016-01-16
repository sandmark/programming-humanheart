#!/usr/bin/env ruby
# coding: utf-8

require_relative 'unmo'

if $0 == __FILE__
  def prompt(unmo)
    "#{unmo.name}:#{unmo.responder_name}> "
  end

  puts ('Unmo System prototype : proto')
  proto = Unmo.new('proto')

  loop do
    print '> '
    input = readline.chomp
    break if input.empty?

    response = proto.dialogue(input)
    puts prompt(proto) + response
  end
end
