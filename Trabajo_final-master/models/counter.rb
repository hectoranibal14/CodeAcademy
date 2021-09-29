class Counter
	def demands_by_channel(demands)
		demands = demands.each_with_object(Hash.new(0)) {|object, hash| hash[object.channel] += 1}
    end

    def demands_by_category(demands)
        demands = demands.each_with_object(Hash.new(0)) {|object, hash| hash[object.category] += 1}
    end

    def demands_by_weekdays(demands)
        demands = demands.each_with_object(Hash.new(0)) {|object, hash| hash[Date.parse(object.entry_date).strftime("%A")] += 1}
    end

    def demands_by_commune(demands)
        demands = demands.each_with_object(Hash.new(0)) {|object, hash| hash[object.cgpc_address] += 1}
    end

    def demands_by_date(demands)
        demands = demands.each_with_object(Hash.new(0)) {|object, hash| hash[object.entry_date] += 1 }
    end

    def demands_by_period(demands)
        demands = demands.each_with_object(Hash.new(0)) {|object, hash| hash[object.period] += 1 }
    end

    def demands_closed(demands)
        demands = demands.select {|demand| demand.contact_id_state == "Cerrado"}
    end

    def demands_open(demands)
        demands_open = demands.select {|demand| demand.contact_id_state == "Abierto"}
    end

    def demands_by_gender(demands,gender)
        demands = demands.select {|demand| demand.gender == gender}
    end
end