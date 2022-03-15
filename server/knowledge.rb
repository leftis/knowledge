require 'services/knowledge_service'

class KnowledgeService < Knowledge::Presentation::Service
  def register(_req, _unused_call)
    Knowledge::Response.new(title: 'test', status: 1, presented_at: 628232400)
  end
end
