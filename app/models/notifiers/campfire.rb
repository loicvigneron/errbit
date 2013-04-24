require 'tinder'

class Notifiers::Campfire

  attr_accessor :room, :campfire

  def err_notification(notice)
    hostname    = notice.server_environment["hostname"]
    environment = notice.server_environment["environment-name"]
    message     = notice.message
    app         = notice.app
    room.speak("#{app.name}(#{environment}): #{message} http://errbit.djengo.me/apps/#{app.id}/errs/#{notice.problem.id}")
  end


  def initialize(config)
    token       = config["token"]
    room_name   = config["room_name"]
    subdomain   = config["subdomain"]
    @campfire   = Tinder::Campfire.new(subdomain, :token => token)
    @room       = campfire.find_room_by_name(room_name)
  end
end


