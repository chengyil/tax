require 'forwardable'
require_relative 'tax/log_device.rb'
require_relative 'tax/error.rb'
require_relative 'tax/cli.rb'
require_relative 'tax/config.rb'
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
end
