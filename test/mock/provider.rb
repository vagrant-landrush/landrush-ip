module Mock
  class Provider
    def initialize(*)
    end

    def _initialize(*)
    end

    def ssh_info
    end

    def state
      @state ||= Vagrant::MachineState.new('mock-state', 'mock-state', 'mock-state')
    end
  end
end
