# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

# Setting our constant here gives us an object to run arbitrary calculations on as we build our list of API calls.

Calculations = AMEE::DataAbstraction::CalculationSet.new {

all_calculations {
  # metadatum {
  #   label :atrbitrary_key
  # }
  # metadatum {
  #   label :name
  # }
  # metadatum {
  #   label :entered_by_id
  # }
  # metadatum {
  #   label :category
  #   fixed "Travel"
  # }
  start_and_end_dates

  correcting(:co2) { name "Carbon Dioxide"}
  correcting(:co2e) { name "Equivalent Carbon Dioxide"}
}

# # walking will always return zero, so it's not clear if we should even worry about this
# #  walking 
# calculation{
# if we should use it, it should be added here
# }  

# car
calculation{
  name 'Car'
  label :car
  path "/transport/defra/vehicle"
  drill {
     label :type
     path 'type'
     fixed 'car'
  }
  drill {
     label :fuel
     path 'fuel'
     fixed 'unknown'
  }
  drill {
     label :size
     path 'size'
     fixed 'average'
  }
  profile {
    label :amount
    name 'Distance'
    path 'distance'
    type :float
    validation :numeric
    default_unit :km
  }
  output {
    label :co2e
    name 'Equivalent Carbon Dioxide'
    path :default
    type :float
  }
}

# domestic flight
calculation{
  name 'Domestic Flight'
  label :domestic_flight
  path "/transport/defra/passenger/flight"
  drill {
     label :type
     path 'type'
     fixed 'domestic'
  }
  drill {
     label :passengerClass
     path 'passengerClass'
     fixed 'average'
  }
  profile {
    label :amount
    name 'Journeys'
    path 'journeys'
    type :integer
    validation :numeric
  }
  output {
    label :co2e
    name 'Equivalent Carbon Dioxide'
    path :default
    type :float
  }
}

# short haul flight
calculation{
  name 'Short Haul Flight'
  label :short_haul_flight
  path "/transport/defra/passenger/flight"
  drill {
     label :type
     path 'type'
     fixed 'short-haul international'
  }
  drill {
     label :passengerClass
     path 'passengerClass'
     fixed 'average'
  }
  profile {
    label :amount
    name 'Journeys'
    path 'journeys'
    type :integer
    validation :numeric
  }
  output {
    label :co2e
    name 'Equivalent Carbon Dioxide'
    path :default
    type :float
  }
}

# long haul flight
calculation{
  name 'Long Haul Flight'
  label :long_haul_flight
  path "/transport/defra/passenger/flight"
  drill {
     label :type
     path 'type'
     fixed 'long-haul international'
  }
  drill {
     label :passengerClass
     path 'passengerClass'
     fixed 'average'
  }
  profile {
    label :amount
    name 'Journeys'
    path 'journeys'
    type :integer
    validation :numeric
  }
  output {
    label :co2e
    name 'Equivalent Carbon Dioxide'
    path :default
    type :float
  }
}

# route (used to find correct distance between two points. )
calculation{
  
  name 'Route'
  label :route
  path "/transport/defra/route"
  profile {
    label :lat1
    name 'Lat1'
    path 'lat1'
    type :float
    validation :numeric
  }
  profile {
    label :lat2
    name 'Lat2'
    path 'lat2'
    type :float
    validation :numeric
  }
  profile {
    label :long1
    name 'long1'
    path 'long1'
    type :float
    validation :numeric
  }
  profile {
    label :long2
    name 'long2'
    path 'long2'
    type :float
    validation :numeric
  }
  output {
    label :distance
    name 'Distance in km'
    path :default
    type :float
  }
  output {
    label :lifeCycleCO2e
    name 'Full Direct and Indirect CO2e emissions'
    path :default
    type :float
  } 
 } 
}