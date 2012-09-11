require 'tinder'

class Notifiers::Campfire

  attr_accessor :room, :campfire

  def err_notification(notice)
    room.play("noooo")
    room.speak("#{notice.host}[#{notice.server_environment}] : #{notice.message}")
  end


  def initialize(config)
    token       = config["token"]
    room_name   = config["room_name"]
    subdomain   = config["subdomain"]
    @campfire   = Tinder::Campfire.new(subdomain, :token => token)
    @room       = campfire.find_room_by_name(room_name)
  end
end


