require_relative('../db/sqlrunner.rb')
require_relative('./film.rb')
require_relative('./ticket.rb')
require_relative('./screening.rb')

class Customer

  attr_reader :id, :films_booked
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
    @films_booked = []
  end

  def save
    sql = 'INSERT INTO customers (name, funds)
          VALUES ($1, $2)
          RETURNING id'
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update
    sql = 'UPDATE customers SET (name, funds) =
          ($1, $2) WHERE id = $3'
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = 'SELECT * FROM customers'
    customer_data = SqlRunner.run(sql)
    return Customer.map_items(customer_data)
  end

  def buy_tickets(array_of_films, array_of_screenings)
   array_of_films.each do |film|
     @funds -= film.price
     self.update
     @films_booked << film
   end
   array_of_screenings.each { |screening| screening.book_ticket }
 end

  def delete
    sql = 'DELETE FROM customers WHERE id = $1'
    value = [@id]
    SqlRunner.run(sql, value)
  end

  def self.delete_all
    sql = 'DELETE FROM customers'
    SqlRunner.run(sql)
  end

  def find_films_by_customer
    sql = 'SELECT title FROM films
          INNER JOIN tickets
          ON tickets.film_id = films.id
          INNER JOIN customers
          ON tickets.customer_id = customers.id
          WHERE customers.name = $1';
    values = [@name]
    results = SqlRunner.run(sql, values)
    return results.to_a
  end

  def self.map_items(customer_data)
    result = customer_data.map { |customer| Customer.new(customer) }
    return result
  end
end
