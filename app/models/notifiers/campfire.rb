require 'tinder'

class Notifiers::Campfire

  attr_accessor :room, :campfire

  def err_notification(notice)
    hostname    = notice.server_environment["hostname"]
    environment = notice.server_environment["environment-name"]
    message     = notice.message
    room.speak("#{hostname} [ENV: #{environment}] : #{message}")
  end


  def initialize(config)
    token       = config["token"]
    room_name   = config["room_name"]
    subdomain   = config["subdomain"]
    @campfire   = Tinder::Campfire.new(subdomain, :token => token)
    @room       = campfire.find_room_by_name(room_name)
  end
end


