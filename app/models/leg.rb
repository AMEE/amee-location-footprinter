# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

class Leg < ActiveRecord::Base

  belongs_to :start_checkin, :class_name => "Checkin"
  belongs_to :end_checkin, :class_name => "Checkin"

  belongs_to :user
  validates :co2, :distance, :start_checkin, :end_checkin, :mode_of_transport, :presence => true

  after_update do | leg |
      d "\n"
    d "#{leg.id} has just been updated."
    if leg.changed.include? "mode_of_transport"
      d "\n"
      d {leg }
      leg.recalculate_distance!
      d "\n"
      d "recalculatiing that carbon!"
      d "\n"
      d "\n"
      leg.co2 = Checkin.carbon_for leg.mode_of_transport, leg.distance
      d {leg }
      d "\n"
    end
  end

  # Convenience function to check if a journey leg was on a given day
  # used to help choose from a week of journey legs
  # @param String day_name "Saturday"
  def day_is? day_name
    self.timestamp.strftime("%A")  == day_name
  end

  # update the distance, to allow for updating of distance
  # between checkins
  def recalculate_distance!
    self.distance = Checkin.distance_between_points(start_checkin, end_checkin).to_km
  end

  private

end
