require 'yaml/store'

class PersistanceManager

    def initialize
        @demand_file = YAML::Store.new 'demands.yml'
        @demand_file.transaction do
            @demand_file['demands_list'] ||= []
        end 
    end

    def add_demand(demand)
        @demand_file.transaction do
            @demand_file['demands_list'] << demand
        end
    end

    def get_all_demands
        @demand_file.transaction { @demand_file['demands_list'] }
    end

    def get_demand(demand_contact_id)
        demand = @demand_file.transaction do
            @demand_file['demands_list'].select{ |data| data.contact_id == demand_contact_id}
        end
        demand.first
    end

    def delete_demand(demand_contact_id)
        @demand_file.transaction do
          @demand_file['demands_list'].delete_if{ |data| data.contact_id == demand_contact_id }
        end
    end

    def edit_demand(new_demand)
        old_demand = get_demand(new_demand.contact_id)
        @demand_file.transaction do
          @demand_file['demands_list'].delete_if {|data| data.contact_id == old_demand.contact_id}
          @demand_file['demands_list'] << new_demand
        end
    end

end