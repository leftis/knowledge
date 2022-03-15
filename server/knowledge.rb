require 'services/knowledge_service'
require 'pry'
require_relative 'database'

class KnowledgeService < Knowledge::Presentation::Service
  def register(req, _)
    if (presentation = Presentation.create(title: req.title, author: req.author))
      Knowledge::Response.new(presentation.to_hash)
    end
  end

  def list(_req, _)
    Presentation.all.map { |r| Knowledge::Response.new(r.to_hash) }.each
  end
end
