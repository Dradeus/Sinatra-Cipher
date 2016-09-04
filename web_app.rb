require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
	erb :index
end

post '/' do
	message = encoder(params[:text],params[:key])
	erb :index, :locals => {:message => message}
end

def encoder(message, key)
	ray = message.scan /\w/
	ray.map! do |ch|
		if ch.ord.between?(64,91)
			((((ch.ord + key.to_i)-65) % 26) + 65).chr
		elsif ch.ord.between?(96,123)
			((((ch.ord + key.to_i)-97) % 26) + 97).chr
		else
			ch
		end
	end
	ray.join
end