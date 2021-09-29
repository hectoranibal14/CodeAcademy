require 'sinatra'
require 'byebug'

get '/' do
    @title = 'Comparador re polenta'
    erb :index
end

get '/ingresar' do
    erb :ingreso
end

post '/ingresar' do

    @numero1 = params['firstnumber'].to_i
    @numero2 = params['secondnumber'].to_i

    @resultado = 0
    @resultado = if (@numero1 == @numero2)
        @numero1 * @numero2
    elsif (@numero1 > @numero2)
        @numero1 - @numero2
    else
        @numero1 + @numero2
    end

    erb :resultado
end