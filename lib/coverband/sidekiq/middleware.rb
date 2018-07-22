module Coverband
  module Sidekiq
    module Middleware
      class Server
        def call(_worker, _job, _queue)
          Coverband::Base.instance.start
          yield
          Coverband::Base.instance.stop
          Coverband::Base.instance.save
        end
      end
    end

    def self.configure_middleware!
      ::Sidekiq.configure_server do |config|
        config.server_middleware do |chain|
          chain.add Coverband::Sidekiq::Middleware::Server
        end
      end
    end
  end
end
