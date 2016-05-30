begin
  require 'vagrant'
rescue LoadError
  raise 'Landrush IP must be run within Vagrant'
end

require 'landrush-ip/plugin'
require 'landrush-ip/errors'

require 'pathname'

module LandrushIp
  def self.source_root
    @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
  end

  I18n.load_path << File.expand_path('locales/en.yml', source_root)
  I18n.reload!
end
