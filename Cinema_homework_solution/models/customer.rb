require_relative("../db/sql_runner")
require_relative("film.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options["funds"]
  end

  def save()
    sql = "INSERT INTO customers
    (
      name, funds
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@name, @fund]
    customer = SqlRunner.run( sql, values ).first
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = Customer.map_customers(customers)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

def films()
  sql = "SELECT films.* FROM films INNER JOIN tickets ON
  films.id =tickets.film_id WHERE tickets.customer_id = $1"
  values = [@id]
  films = SqlRunner.run(sql, values)
  return films.map{|film_hash|
  Film.new(film_hash)}
end


def self.map_customers(customer_data)
  return customer_data.map {|customer_hash|
  Customer.new(customer_hash)}
end




end
