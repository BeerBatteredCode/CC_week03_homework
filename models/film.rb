require_relative('../db/sqlrunner.rb')
require_relative('./customer.rb')
require_relative('./ticket.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save
    sql = 'INSERT INTO films (title, price)
          VALUES ($1, $2)
          RETURNING id'
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def update
    sql = 'UPDATE films SET (title, price) =
          ($1, $2) WHERE id = $3'
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = 'SELECT * FROM films'
    films_data = SqlRunner.run(sql)
    return Film.map_items(films_data)
  end

  def delete
    sql = 'DELETE FROM films WHERE id = $1'
    value = [@id]
    SqlRunner.run(sql, value)
  end

  def self.delete_all
    sql = 'DELETE FROM films'
    SqlRunner.run(sql)
  end

  def find_customers_by_film
    sql = 'SELECT name FROM customers
          INNER JOIN tickets
          ON tickets.customer_id = customers.id
          INNER JOIN films
          ON tickets.film_id = films.id
          WHERE films.title = $1';
    values = [@title]
    results = SqlRunner.run(sql, values)
    return results.to_a
  end

  def self.map_items(film_data)
    result = film_data.map { |film| Film.new(film) }
    return result
  end
end
