require_relative '../tweet'
require 'yaml'
require 'shoulda-matchers'

def fake_stdin(*args)
  begin
    $stdin = StringIO.new
    $stdin.puts(args.shift) until args.empty?
    $stdin.rewind
    yield
  ensure
    $stdin = STDIN
  end
end
