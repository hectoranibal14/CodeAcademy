require 'sinatra'
require 'byebug'
require_relative 'models/contador.rb'

get '/' do
    @title = 'Incrementar-decrementar'
    erb :ingreso
end

post '/incrementa' do
    @resultado = (Contador.new(params['valorIngresado'].to_i)).incrementar
    erb :resultado
end

post '/decrementa' do
    @resultado = (Contador.new(params['valorIngresado'].to_i)).decrementar
    erb :resultado
end

post '/incrementarEnX' do
    @resultado = (Contador.new(params['valorIngresado'].to_i)).incrementarEnX(params['segundoNumero'].to_i)
    erb :resultado
end

post '/decrementarEnX' do
    @resultado = (Contador.new(params['valorIngresado'].to_i)).decrementarEnX(params['segundoNumero'].to_i)
    erb :resultado
end