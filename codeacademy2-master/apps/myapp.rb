require 'sinatra'
require 'byebug'

get '/' do
   'Hello world 2'
end

get '/hello/:name' do
    #byebug
	# matches "GET /hello/foo" and "GET /hello/bar"
	# params['name'] is 'foo' or 'bar'
	 @name = params['name']
	 erb :hello
end

#byebug commands
#n enter -> siguiente linea
#s enter -> si tenes un metodo, entra a inspeccionar el metodo
#c enter -> continua hasta el siguiente byebug
