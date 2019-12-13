#!/usr/bin/env ruby
require "pathname"
ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", Pathname.new(__dir__).realpath)
$LOAD_PATH << Gem.dir
require "rubygems"
require "bundler/setup"
$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'tax.rb'

begin
  require 'irb'
  IRB.start
end
