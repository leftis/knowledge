# Proto Model
require 'knowledge_pb'
# Proto Service
require 'knowledge_services_pb'

class KnowledgeComponent < Knowledge::Presentation::Service
  def register(req, _)
    presentation = create_presentation(req.title, req.author)
    response(format_presentation(presentation))
  end

  def list(_req, _)
    ::Presentation.all.map { |r| response(format_presentation(r)) }.each
  end

  def withdraw(req, _)
    Presentation.where(req.to_h).delete
    Knowledge::Empty.new
  end

  private

  def response(hsh)
    Knowledge::Response.new(hsh)
  end

  def create_presentation(title, author)
    ::Presentation.create(title: title, author: author, status: 0)
  end

  def format_presentation(p)
    {
      id: p.id,
      title: p.title,
      status: p.status,
      presented_at: p.presented_at.to_time.to_i
    }
  end
end
