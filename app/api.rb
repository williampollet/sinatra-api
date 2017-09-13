require 'bundler/setup'
require 'sinatra/base'
require 'json'

class JSONparser
	def initialize(filename: 'data.json')
		@data = JSON.parse(IO.read(filename))
	end

	def movies
		@data['movies']
	end

	def directors
		@data['directors']
	end
end

class Api < Sinatra::Base
	get '/hello' do
		'Hello world!'
	end

	get '/movies' do
		content_type :json
		data.movies.to_json
	end

	get '/movies/:id' do
		content_type :json
		movies = data.movies
		movies.select{|movie| movie['id'] == params[:id].to_i}.first.to_json
	end


	private

	def data
		@data ||= JSONparser.new(filename: 'data.json')
		@data
	end
end
