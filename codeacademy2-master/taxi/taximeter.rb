class Taximeter
  attr_reader :base_fare, :km_cost, :minute_cost
  
  def initialize(base_fare, km_cost, minute_cost)
    @base_fare = base_fare
    @km_cost = km_cost
    @minute_cost = minute_cost
  end

  def calculate_trip_cost(trip_distance_in_kms, trip_duration_in_mins)
    base_fare + (trip_distance_in_kms * km_cost) + (trip_duration_in_mins * minute_cost)
  end
end
