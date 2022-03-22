class Server
  attr_accessor :grpc_instance

  def initialize(host = '0.0.0.0', port = '50051', services = [])
    @grpc_instance = GRPC::RpcServer.new

    register_host(host, port)
    register_services(services)
    termination_que

    grpc_instance
  end

  def termination_que
    grpc_instance.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
  end

  def register_services(services)
    services.each { |s| grpc_instance.handle(s) }
  end

  def register_host(host, port)
    grpc_instance.add_http2_port("#{host}:#{port}", :this_port_is_insecure)
  end
end
