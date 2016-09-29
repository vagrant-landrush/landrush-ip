module Mock
  class Communicator
    attr_reader :commands, :responses

    def initialize
      @commands  = Hash.new([])
      @responses = Hash.new('')
    end

    def stub_command(command, response)
      responses[command] = response
    end

    def sudo(command, _opts = nil)
      commands[:sudo] << command
      responses[command]
    end

    def execute(command)
      commands[:execute] << command
      responses[command].split("\n").each do |line|
        yield(:stdout, "#{line}\n")
      end
    end

    def test(command)
      commands[:test] << command
      true
    end

    def upload(_source, _dest)
      true
    end

    def ready?
      true
    end
  end
end
