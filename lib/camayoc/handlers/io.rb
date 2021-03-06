module Camayoc
  module Handlers

    # Write to a raw IO stream with optional thread-safe locking before writing
    # to the stream. By default, each stat message is written on a single line
    # using puts. See the options in Camayoc::Handlers:Logger for options.
    class IO < Logger

      include ThreadSafety

      def initialize(io=$stdout,options={},&block)
        super(io,{:method=>:puts}.merge(options),&block)
        self.thread_safe = Camayoc.thread_safe?
      end

      protected
        def write(event)
          synchronize do
            super(event)
          end
        end

    end
  end
end
