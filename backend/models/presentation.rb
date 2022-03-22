require 'date'
require 'pry'
class Presentation < Sequel::Model
  def before_create
    self.presented_at ||= Presentation.next_available_date
  end

  def self.next_available_date
    last_slot = order(:presented_at).last&.presented_at
    return last_slot + 7 if last_slot

    today = Date.today
    return today + 10 if [6, 0].include? today.wday

    today + 7
  end
end
