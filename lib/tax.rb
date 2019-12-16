# frozen_string_literal: true

require 'forwardable'
require_relative 'tax/log_device.rb'
require_relative 'tax/config.rb'
require_relative 'tax/error.rb'
require_relative 'tax/idr.rb'
require_relative 'tax/person.rb'
require_relative 'tax/entry.rb'
require_relative 'tax/relief.rb'
require_relative 'tax/assessment.rb'
require_relative 'tax/cli.rb'
require_relative 'tax/console.rb'

module Tax
  module ClassMethods
    def config
      @config ||= Tax::Configuration.new
    end

    def logger
      @logger ||= Tax::LogDevice.new(config.log_path)
    end
  end
  extend ClassMethods

  module GlobalMethods
    def to_idr
      return self if Tax::IDR === self
      Tax::IDR.new(self)
    end
  end

  Object.include GlobalMethods
end
