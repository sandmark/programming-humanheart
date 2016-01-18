#!/usr/bin/env ruby
# coding: utf-8

require_relative 'lib/unmo'

def prompt(unmo)
  "#{unmo.name}:#{unmo.responder_name}> "
end

def select_random(ary)
  ary[rand(ary.size)]
end

def save(ai, log)
  ai.save
  File.open('log.txt', 'a') do |f|
  f.puts(log)
  f.puts
  end
end

puts ('Unmo System prototype : proto')
proto = Unmo.new('proto')
log = ["Unmo System : #{proto.name} Log -- #{Time.now}"]

while true
  print '> '
  input = readline.chomp
  break if input.empty?

  response = proto.dialogue(input)
  puts prompt(proto) + response
end

save(proto, log)
