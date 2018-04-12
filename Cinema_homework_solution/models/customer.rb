require_relative("../db/sql_runner")
require_relative("film.rb")

class User

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options["funds"]
  end

  def save()
    sql = "INSERT INTO users
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@name, @fund]
    user = SqlRunner.run( sql, values ).first
    @id = user['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM users"
    values = []
    users = SqlRunner.run(sql, values)
    result = User.map_users(users)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM users"
    values = []
    SqlRunner.run(sql, values)
  end

def films()
  sql = "SELECT films.* FROM films INNER JOIN visits ON
  films.id =visits.film_id WHERE visits.user_id = $1"
  values = [@id]
  films = SqlRunner.run(sql, values)
  return films.map{|film_hash|
  Location.new(film_hash)}
end

# to DRY calling map a lot
def self.map_users(user_data)
  return user_data.map {|user_hash|
  User.new(user_hash)}
end




end
