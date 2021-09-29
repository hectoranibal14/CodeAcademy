
class Statistics
    attr_reader :graphs

    def graphic(demands)
        graphs = {}
		percentages = bar_data(demands)

		colors = {
			'background' => '#d5dfef', # the background colour
			'foreground' => '#0760ef', # the pill color when it's a simple pill (not a state pill)
		}
    
		demands.each_key do |k|
			value = demands[k]
			value ||= 0
			graphs[k] = PillChart::SimplePillChart.new(10, 100, percentages[k], 100, :simple, colors)
		end
		graphs
	end
    
    def bar_data(demands)
		total_quantity = demands.values.inject(0) { |sum, x| sum + x }
		percentages = {}
		demands.each_key do |k|
			value = demands[k]
			value ||= 0
			percentages[k] = value * 100 / total_quantity
		end
		percentages
	end
    
end
