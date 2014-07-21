require "gschool_database_connection"

class SqlCommands
  def initialize
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  def create_message(username, message)
    @database_connection.sql("INSERT INTO users (username, message) VALUES ('#{username}', '#{message}')")
  end

  def open_message_array(username)
    @database_connection.sql("SELECT message FROM users WHERE username = #{username}")
  end

end
