#!/usr/bin/env ruby

Dir.glob('./**/*.rb') { |f| $LOAD_PATH.unshift(File.dirname(f)) }

require 'grpc'
require 'sequel'
require 'server'
require 'database'
require 'knowledge_component'

Server.new('0.0.0.0', '50051', [KnowledgeComponent])
