require 'services/knowledge_service'
require 'pry'
require_relative 'database'

class KnowledgeService < Knowledge::Presentation::Service
  def register(req, _)
    response(create_presentation(req.title, req.author).to_hash)
  end

  def list(_req, _)
    Presentation.all.map { |r| response(r.to_hash) }.each
  end

  private

  def response(hsh)
    Knowledge::Response.new(hsh)
  end

  def create_presentation(title, author)
    Presentation.create(title: title, author: author)
  end
end
