class Demand
    attr_accessor :contact_id, :period, :category, :provision_type, :entry_time, :entry_date, :cgpc_address, :distrit_address, :street_address, :number_address, :channel, :gender, :contact_id_state, :contact_id_close_date
    
	def initialize(contact_id, period, category, provision_type, entry_date, entry_time, cgpc_address, distrit_address, street_address, number_address, channel, gender, contact_id_state, contact_id_close_date)
        @contact_id = contact_id
        @period = period
        @category = category
        @provision_type = provision_type
        @entry_time = entry_time
        @entry_date = entry_date
        @cgpc_address = cgpc_address
        @distrit_address = distrit_address
        @street_address = street_address
        @number_address = number_address
        @channel = channel
        @gender = gender
        @contact_id_state = contact_id_state
        @contact_id_close_date = contact_id_close_date
    end
end


