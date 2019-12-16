module Tax
  module Relief
    module ClassMethods
      def qualified_relief(param)
        all.select do |klass|
          klass.qualified?(param)
        end.map do |klass|
          klass.new(param)
        end
      end

      def load_reliefs
        Dir.glob('relief/*.rb', base: __dir__).each do |file|
          require_relative file
        end
      end

      def all
        @reliefs ||= []
      end

      def included(base_klass)
        all << base_klass
      end
    end

    extend ClassMethods

    load_reliefs
  end
end
