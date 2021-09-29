require 'sinatra'
require 'byebug'
require 'shotgun'
require 'yaml/store'
require_relative 'models/cuenta.rb'

get '/' do
    @title = 'Cuentas Corrientes'
    erb :index
end

get '/cuentas/nueva' do
    erb :nueva_cuenta
end

post '/cuentas/nueva' do
    cuentas = get_cuentas_from_disc
    @numero_cuenta = params['numero_cuenta']
    @errors = []
    @errors << 'Numero de cuenta existente.' if cuentas.any? {|dato| dato.id_cuenta == @numero_cuenta}
    if @errors.empty?
        nueva_cuenta = Cuenta_corriente.new(@numero_cuenta)
        cuentas.push (nueva_cuenta)
        save_cuentas_to_disc (cuentas)
        erb :cuenta_creada
    else
        erb :nueva_cuenta
    end
end

get '/cuentas/lista' do
    @lista_cuentas = []
    lista = get_cuentas_from_disc
    @errors = []
    @errors << 'No existen cuentas disponibles.' if lista.empty?
    #lista.each {|dato| @lista_cuentas.push(dato.id_cuenta)} if !lista.empty?
    if @errors.empty?
        lista.each {|dato| @lista_cuentas.push(dato.id_cuenta)}
        save_cuentas_to_disc (lista)
        erb :listado_cuentas
    else
        erb :listado_cuentas
    end
end

def get_cuentas_from_disc
	cuentas_store = YAML::Store.new 'cuentas.yml'
	cuentas = cuentas_store.transaction {cuentas_store['cuentas']}
	cuentas ||= []
	cuentas
end

def save_cuentas_to_disc(cuentas)
    cuentas_store = YAML::Store.new 'cuentas.yml'
    cuentas_store.transaction do
        cuentas_store['cuentas'] = cuentas
    end
end
