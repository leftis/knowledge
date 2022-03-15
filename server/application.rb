#!/usr/bin/env ruby

lib_dir = File.join(__dir__, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require_relative 'server'
require_relative 'knowledge'

Server.new('0.0.0.0', '50051', [KnowledgeService])