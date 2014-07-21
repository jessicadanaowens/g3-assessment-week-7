require 'sinatra/base'
require 'gschool_database_connection'
# require_relative './lib/sql_commands'
require './lib/country_list'

class Application < Sinatra::Application

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV['RACK_ENV'])
    # @sql = SqlCommands.new
  end

  get '/' do
    erb :index
  end

  post '/message' do
    create_message(params[:Username], params[:Message])
    user_name = params[:Username]
    redirect "/?user_name=#{user_name}"
  end

  get '/continents' do
    all_continents = CountryList.new.continents
    erb :continents, locals: { continents: all_continents }
  end

  get '/continents/:continent_name' do
    list_of_countries = CountryList.new.countries_for_continent(params[:continent_name])
    erb :countries, locals: { countries: list_of_countries, continent: params[:continent_name] }
  end

  private

  def create_message(username, message)
    @database_connection.sql("INSERT INTO users (username, message) VALUES ('#{username}', '#{message}')")
  end

  def open_message_array(username)
    @database_connection.sql("SELECT message FROM users WHERE username = '#{username}'")
  end

  def open_all_messages_array
    @database_connection.sql("SELECT message FROM users")
  end

end