
require 'sinatra'
require 'byebug'
require 'shotgun'
require 'yaml/store'
require 'csv'
require 'date'
require 'pill_chart'
require_relative 'models/demand.rb'
require_relative 'models/persistance_manager.rb'
require_relative 'models/type_of_demand.rb'
require_relative 'models/category.rb'
require_relative 'models/category_manager.rb'
require_relative 'models/statistics.rb'
require_relative 'models/counter.rb'
CSV_FILE = 'public/css/atencion-ciudadana-2019.csv'

get '/' do
    @title = 'AMD system'
    persistance_manager = PersistanceManager.new()
    if persistance_manager.get_all_demands.empty?
        CSV.foreach(CSV_FILE, headers: true) do |row1|
            demand = Demand.new(row1[0],row1[1],row1[2],row1[3],row1[4],row1[5],row1[6],row1[7],row1[8],row1[9],row1[10],row1[11],row1[12],row1[13])
            persistance_manager.add_demand(demand)
        end        
    end

    category_options = CategoryManager.new()
    if category_options.get_all_categorys.empty?
        categorys = ['ALUMBRADO - REPARACION DE LUMINARIA', 'FISCALIZACION ACTIVIDADES COMERCIALES - HABILITACIONES Y PERMISOS','CALLES Y VEREDAS - REPARACION DE VEREDA', 'SUGERENCIAS Y LIBRO DE QUEJAS - FELICITACIONES/ AGRADECIMIENTO POR TRAMITE', 'LIMPIEZA Y RECOLECCION - RESIDUOS VOLUMINOSOS', 'TRANSITO - DENUNCIA VIAL', 'CALLES Y VEREDAS - OTROS', 'ARBOLADO Y ESPACIOS VERDES - PODA DE ARBOL Y DESPEJE DE LUMINARIA', 'SEGURIDAD - PRESENCIA POLICIAL', 'PLUVIALES - ALCANTARILLAS / SUMIDEROS', 'FISCALIZACION ACTIVIDADES COMERCIALES - HIGIENE Y SEGURIDAD ALIMENTARIA', 'TRANSITO - CRUCE PELIGROSO O CALLE CON INCONVENIENTES VIALES', 'ARBOLADO Y ESPACIOS VERDES - PROBLEMA CON INTERVENCIONES DE ARBOLADO', 'MEDIOS DE TRANSPORTE - SUBTES', 'ARBOLADO Y ESPACIOS VERDES - PLANTACION DE ARBOL', 'CALLES Y VEREDAS - REPARACION DE BACHES', 'TRANSITO - SEMAFOROS', 'FISCALIZACION ACTIVIDADES COMERCIALES - DEFENSA AL CONSUMIDOR', 'LIMPIEZA Y RECOLECCION - LIMPIEZA DE VIA PUBLICA', 'ALUMBRADO - MAYOR ILUMINACION EN CALLE', 'LIMPIEZA Y RECOLECCION - CESTOS Y CONTENEDORES', 'TRANSITO - VEHICULOS ABANDONADOS', 'ORDENAMIENTO DEL ESPACIO PUBLICO - OCUPACION INDEBIDA', 'ALUMBRADO - REPARACION DE EQUIPAMIENTO DE ALUMBRADO', 'CALLES Y VEREDAS - MARCAS VIALES Y SEÑALES EN CALLE', 'TRANSITO - REPARACION DE SEÑAL DE TRANSITO', 'TRAMITES Y SERVICIOS - SERVICIOS DEL GCBA', 'CALLES Y VEREDAS - MOBILIARIO URBANO']
        categorys.each do |category| 
            new_category = Category.new(category)
            category_options.add_category(new_category)
        end
    end

    erb :index
end

get '/tp_statement' do
    erb :tp_statement
end

get '/about_me' do
    erb :about_me
end 

get '/demand/new' do
    @type = Type.new.type_of_demand
    category = CategoryManager.new
    @category = category.get_all_categorys
    persistance_manager = PersistanceManager.new()
    @new_contact_id = persistance_manager.get_all_demands.sort_by {|demand| demand.contact_id.to_i}.last.contact_id.to_i + 1
    @time = Time.now
    erb :new_demand
end

post '/demand/new' do
	period = Time.now.year*100 + Time.now.month
    entry_time = Time.now.strftime("%H:%M:%S")
    entry_date = Time.now.strftime("%d/%m/%Y")
	category = params[:category]
	provision_type = params[:type]
	cgpc_address = params[:commune]
	distrit_address = params[:distrit]
	street_address = params[:address]
	address_number = params[:address_number]
	channel = params[:channel]
	gender = params[:gender]
	contact_id_state = "Abierto"
	contact_id_close_date = params[:close_date]
    
    persistance_manager = PersistanceManager.new()
    new_contact_id = persistance_manager.get_all_demands.sort_by {|demand| demand.contact_id.to_i}.last.contact_id.to_i + 1
    @demand = Demand.new(new_contact_id.to_s, period.to_s, category, provision_type, entry_date, entry_time, cgpc_address, distrit_address, street_address, address_number, channel, gender, contact_id_state, contact_id_close_date)
    persistance_manager.add_demand(@demand)

    erb :demand_details
end


get '/demand/list' do
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands
    @demands = demands.sort_by {|demand| demand.contact_id.to_i}.reverse
     
    erb :demands
end

get '/demand/:contact_id' do

    persistance_manager = PersistanceManager.new()
    @demand = persistance_manager.get_demand(params[:contact_id])
    erb :demand_details
end

get '/demand/modify/:contact_id' do
    persistance_manager = PersistanceManager.new()
    @current_demand = persistance_manager.get_demand(params[:contact_id])
    @type = Type.new.type_of_demand
    category = CategoryManager.new
    @category = category.get_all_categorys

    erb :demand_modify
end

post '/demand/modify/:contact_id' do
    persistance_manager = PersistanceManager.new()
    @demand = persistance_manager.get_demand(params[:contact_id])
    @demand.contact_id_state = params[:status]
    @demand.category = params[:category]
	@demand.provision_type = params[:type]
	@demand.cgpc_address = params[:commune]
	@demand.distrit_address = params[:distrit]
	@demand.street_address = params[:address]
	@demand.number_address = params[:address_number]
	@demand.channel = params[:channel]
    @demand.gender = params[:gender]
    @demand.contact_id_close_date = Time.now.strftime("%d/%m/%Y") if @demand.contact_id_state == "Cerrado"

    persistance_manager.edit_demand(@demand)

    erb :demand_details
end

get '/demand/cancel/:contact_id' do
    persistance_manager = PersistanceManager.new()
    @demand = persistance_manager.get_demand(params[:contact_id])
    @demand.contact_id_state = 'Cancelado'
    @demand.contact_id_close_date = Time.now.strftime("%d/%m/%Y")
    persistance_manager.edit_demand(@demand)
    erb :demand_details
end

get '/new_category' do
    erb :new_category
end

post '/new_category' do
    @errors = []
    @errors << 'Category Name length must be at least 255 characters long.' if params['new_category'].size > 255
    if @errors.empty?
        category = CategoryManager.new
        new_category = Category.new(params['new_category'].upcase)
        category.add_category(new_category)
        @category = category.get_all_categorys
        erb :category_list
    else
        erb :new_category
    end
end

get '/information' do
    erb :information_list
end

get '/information/question_1' do
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands
    @result = Counter.new.demands_by_commune(demands).max_by {|key,value| value}.first
    erb :information_result
end

get '/information/question_2' do
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands
    @result = Counter.new.demands_by_date(demands).max_by {|key,value| value}.first
    erb :information_result
end

get '/information/question_3' do
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands 
    demands_closed = Counter.new.demands_closed(demands)
    @errors = []
    @errors << 'There are no closed demands.' if demands_closed.empty?
    if @errors.empty?
        period_more_closed = Counter.new.demands_by_period(demands_closed).max_by {|key,value| value}
        @result = Date::MONTHNAMES[period_more_closed[0].to_i%100]
        erb :information_result
    else
        erb :information_result
    end
end

get '/information/question_4' do
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands 
    open_demands = Counter.new.demands_open(demands)
    @errors = []
    @errors << 'There are no open demands.' if open_demands.empty?
    
    if @errors.empty?
        @result = open_demands.each_with_object(Hash.new(0)) {|object, hash| hash[object.cgpc_address] = Date.parse object.entry_date}.min_by {|key,value| value}.first
        erb :information_result
    else
        erb :information_result
    end
end

get '/information/question_5' do
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands
    
    female_gender = Counter.new.demands_by_gender(demands,"femenino")
    male_gender = Counter.new.demands_by_gender(demands,"masculino")
    other_gender = Counter.new.demands_by_gender(demands,"otro")
    @errors1 = []
    @errors2 = []
    @errors3 = []
    @errors1 << 'There are no open demands by Female gender.' if female_gender.empty?
    @errors2 << 'There are no open demands by Male gender.' if male_gender.empty?
    @errors3 << 'There are no open demands by Other gender.' if other_gender.empty?
    
    if @errors1.empty?
        @female_category = Counter.new.demands_by_category(female_gender).max_by {|key,value| value}.first
    end
    if @errors2.empty?
        @male_category = Counter.new.demands_by_category(male_gender).max_by {|key,value| value}.first
    end
    if @errors3.empty?
        @other_category = Counter.new.demands_by_category(other_gender).max_by {|key,value| value}.first
    end
    erb :information_result_by_gender
end

get '/information/month' do
    @months = [1,2,3,4,5,6,7,8,9,10,11,12]
    erb :information_query_month
end

post '/information/month' do
    month = params[:month]
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands
    @demands = demands.select {|demand| Date.parse(demand.entry_date).month == month.to_i && demand.contact_id_state=="Cerrado"}.select {|demand| Date.parse(demand.contact_id_close_date).month == month.to_i}
    erb :information_monthly_demands
end

get '/statistics' do
    erb :statistics_options
end

get '/statistics/option_1' do
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands
    @demands = Counter.new.demands_by_commune(demands)
    @graphs = Statistics.new.graphic(@demands)
    erb :statistics_graphic_result
end

get '/statistics/option_2' do
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands
    @result = Counter.new.demands_by_commune(demands).sort_by {|key,value| value}.reverse.first(5)
    erb :statistics_result
end

get '/statistics/option_3' do
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands
    closed = Counter.new.demands_closed(demands)
    @result = []
    if !closed.empty?
        @result = Counter.new.demands_closed(demands).each_with_object(Hash.new(0)) {|object, hash| hash[object.contact_id] = (Date.parse(object.contact_id_close_date) - Date.parse(object.entry_date)).to_i}.sort_by {|key,value| value}.reverse.first(5)
    
        erb :statistics_result
    else
        erb :statistics_result
    end
end

get '/statistics/option_4' do
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands
    @result = Counter.new.demands_by_category(demands).sort_by {|key,value| value}.reverse.first(5)
    erb :statistics_result
end

get '/statistics/option_5' do
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands
    @demands = Counter.new.demands_by_weekdays(demands)
    @graphs = Statistics.new.graphic(@demands)
    erb :statistics_graphic_result
end

get '/statistics/option_6' do
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands
    @demands = Counter.new.demands_by_category(demands)
    @graphs = Statistics.new.graphic(@demands)
    erb :statistics_graphic_result
end

get '/statistics/option_7' do
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands
    @demands = Counter.new.demands_by_channel(demands)
    @graphs = Statistics.new.graphic(@demands)
    erb :statistics_graphic_result
end

get '/statistics/option_8' do
    persistance_manager = PersistanceManager.new()
    demands = persistance_manager.get_all_demands
    demands_closed = Counter.new.demands_closed(demands)
    @result = []
    if !demands_closed.empty?
        days_by_commune = Counter.new.demands_closed(demands).each_with_object(Hash.new(0)) {|object, hash| hash[object.cgpc_address] += ((Date.parse(object.contact_id_close_date) - Date.parse(object.entry_date)).to_i)}
        quantity_by_commune = Counter.new.demands_by_commune(demands_closed)
        @result = days_by_commune.merge(quantity_by_commune){|key,value1,value2| value1/value2}.sort_by {|key,value| value}.reverse.first(5)
        erb :statistics_result
    else
        erb :statistics_result
    end
end