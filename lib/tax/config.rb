require 'pathname'
module Tax
  class Configuration
    attr_reader :config
    extend Forwardable
    def_delegators :@config, :merge!, :merge, :[], :[]=

    def initialize(param={})
      @config = {}
      config.merge(param)
    end

    def log_path
      @log_path ||= root_path.join('log','tax.log')
    end
    def root_path
      @root_path ||= Pathname.new(__dir__).parent.parent
    end
  end
end
