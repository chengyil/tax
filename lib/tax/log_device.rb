require 'logger'
require 'time'

module Tax
  class LogDevice < ::Logger
    def initialize(io, shift_age = 7, shift_size = 1024 * 1024 * 20)
      super
      self.progname = ::Process.pid
    end
  end
end
