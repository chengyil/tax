require 'yaml'
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

    def lib_path 
      @lib_path ||= root_path.join('lib')
    end

    def config_path 
      @config_path ||= root_path.join('config')
    end

    def tax_rates
      @tax_rates ||= YAML.load(config_path.join('tax_rates.yml').read)
    end
  end
end
