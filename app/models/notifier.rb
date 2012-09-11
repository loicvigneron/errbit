require 'singleton'

class Notifier
  include Singleton

  attr_accessor :notifiers

  def err_notification(notice)
    notifiers.each do | notifier |
      notifier.err_notification(notice)
    end
  end

  private
    def initialize
      @notifiers = []
      Errbit::Config.notifiers.each do | notifier |
        notifier_name   = notifier[0]
        notifier_config = Hash[notifier[1]]
        if notifier_config["enabled"]
          notifier = Notifiers.const_get(notifier_name.camelize).new(notifier_config)
          @notifiers.push(notifier)
        end
      end
    end
end

Notifier.instance