module Mock
  class Config
    def landrush_ip
      @landrush_ip_config ||= LandrushIp::Config.new
    end

    def vm
      VagrantPlugins::Kernel_V2::VMConfig.new
    end
  end
end
