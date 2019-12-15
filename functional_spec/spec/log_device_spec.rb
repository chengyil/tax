require 'spec_helper.rb'
RSpec.describe Tax::LogDevice do
  subject { described_class.new(STDOUT) }
  context 'log like interface' do
    %w(debug info warn error fatal).each do |method|
      it "response to #{method}" do
        expect(subject).to respond_to(method)
      end
    end
  end
end
