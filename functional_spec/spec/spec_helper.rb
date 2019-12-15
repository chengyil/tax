$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "bundler/setup"
require "pty"
require "timeout"
require 'tax'

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def run_command(pty, command)
  stdout, stdin, pid = pty
  stdin.puts command
  sleep(0.3)
  stdout.readline
end

def fetch_stdout(pty)
  stdout, stdin, pid = pty
  res = []
  while true
    begin
      Timeout::timeout 0.5 do
        res << stdout.readline
      end
    rescue EOFError, Errno::EIO, Timeout::Error
      break
    end
  end

  return res.join('').gsub(/\r/,'')
end

