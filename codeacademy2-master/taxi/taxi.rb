require_relative 'taximeter.rb'

class Taxi
  attr_reader :max_passenger_capacity, :taximeter, :max_luggage_capacity, :current_passengers, :current_luggage
  BASE_FARE   = 40
  KM_COST     = 5
  MINUTE_COST = 1
  
  # This is a comment, initialize is a method
  def initialize(maximum_passenger_capacity, max_luggage_capacity)
    # Arguments can have the same name or not than variables
    @max_passenger_capacity = maximum_passenger_capacity
    @max_luggage_capacity = max_luggage_capacity
    @taximeter = Taximeter.new(BASE_FARE, KM_COST, MINUTE_COST)
    @current_luggage = 0
    @current_passengers = 0
  end

  def add_luggage(number_of_bags)
    if @current_luggage + number_of_bags <= max_luggage_capacity
      @current_luggage += number_of_bags
    else
      # Excepcion CASERA
      puts "Too many bags, try adding less bags or they won't fit in the trunk"
    end
  end

  def remove_luggage(number_of_bags)
	#You can do it. Keep in mind that you can't remove more bags than current_luggage.
	  if (@current_luggage >= number_of_bags)
		  @current_luggage -= number_of_bags
    else
      pust "no se puede"
	  end
  end


  def add_passenger(number_of_passengers)
    # You can do it.
    if (@current_passengers + number_of_passengers <= @max_passenger_capacity)
		  @current_passengers += number_of_passengers
    else
      puts "no se puede agregar más"
	  end
  end


  def remove_passenger(number_of_passengers)
    # You can do it. Keep in mind that you can't remove more passengers than current_passengers.
    if (@current_passengers >= number_of_passengers)
		  @current_passengers -= number_of_passengers
    else
      puts "no se puede"
  	end
  end


  def calculate_trip_cost(trip_distance_in_kms, trip_duration_in_mins)
    @taximeter.calculate_trip_cost(trip_distance_in_kms, trip_duration_in_mins)
  end
  
end