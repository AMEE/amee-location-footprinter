# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

module FootprintsHelper

  # TODO make distance formatting methods here to avoid excessively long figures

  def distance_between_points(checkin1, checkin2)

    distance = Haversine.distance(checkin1.lat.to_f, checkin1.lon.to_f, checkin2.lat.to_f, checkin2.lon.to_f)
    distance
  end

  # Looks at the distance passed in, and makes the relevant call
  # to the AMEE abstraction layer.
  #
  # @param [Float] Distance of the journey we're trying to measure for
end
