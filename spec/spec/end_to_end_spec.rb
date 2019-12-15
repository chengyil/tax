require 'spec_helper'

RSpec.describe 'Tax' do
  let(:pty) { PTY.spawn('app.rb') }

  context '6.500.000 monthly salary, married with 1 child should have a tax payable of 750.000 IDR' do
    let(:commands) do
      [
        "1\n",
        "6500000\n",
        "2\n",
        "1\n",
      ]
    end

    let(:expected) do
      [
        /What is your monthly income?/,
        /What is your marital status?/,
        /How many dependant do you have?/,
        "Total income : 78000000\nAssessable income : 15000000\nPayable Tax : 750000\n"

      ]
    end

    it "interactive input" do
      pty = PTY.spawn("app.rb")
      print 'Testing interactive input: '
      commands.each_with_index do |cmd, index|
        print cmd
        run_command(pty, cmd)
        p output = fetch_stdout(pty)
        p expected[index]
        expect(output).to match(expected[index])
      end
    end
  end

  context '25.000.000 monthly salary, single should have a tax payable of 31.900.000 IDR' do
    let(:commands) do
      [
        "1\n",
        "25000000\n",
        "1\n",
      ]
    end

    let(:expected) do
      [
        /What is your monthly income?/,
        /What is your marital status?/,
        "Total income : 300000000\nAssessable income : 246000000\nPayable Tax : 31900000\n"
      ]
    end

    it "interactive input" do
      pty = PTY.spawn("app.rb")
      print 'Testing interactive input: '
      commands.each_with_index do |cmd, index|
        print cmd
        run_command(pty, cmd)
        p output = fetch_stdout(pty)
        p expected[index]
        expect(output).to match(expected[index])
      end
    end
  end
end
