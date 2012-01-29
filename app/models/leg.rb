# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

class Leg < ActiveRecord::Base

  belongs_to :start_checkin, :class_name => "Checkin"
  belongs_to :end_checkin, :class_name => "Checkin"

  belongs_to :user
  validates :co2, :distance, :start_checkin, :end_checkin, :mode_of_transport, :presence => true
end
