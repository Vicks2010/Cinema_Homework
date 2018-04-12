require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run( sql, values ).first
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new( film ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

#Write method that returns all the users for a film
def users()
  sql = "SELECT users.* FROM users INNER JOIN visits
  ON users.id = visits.user_id WHERE visits.film_id = $1"
  values = [@id]
  users = SqlRunner.run(sql, values)
  return users.map {|user_hash| User.new(user_hash)}
end

def self.map_films(film_data)
  return film_data.map {film_hash|
  Locattion.new(film_hash)}
end

end
