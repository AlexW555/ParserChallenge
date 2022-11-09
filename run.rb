#! /usr/bin/env ruby

require 'json'
require_relative 'parser'

parser = Parser.new(filename: ARGV[0])
output = parser.parse

puts JSON.pretty_generate(output)
