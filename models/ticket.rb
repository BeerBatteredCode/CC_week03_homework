require_relative('../db/sqlrunner.rb')
require_relative('./film.rb')
require_relative('./customer.rb')
require_relative('./screening.rb')

class Ticket

  attr_reader :id, :customer_id, :film_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save
    sql = 'INSERT INTO tickets (customer_id, film_id, screening_id)
          VALUES ($1, $2, $3)
          RETURNING id'
    values = [@customer_id, @film_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def update
    sql = 'UPDATE tickets SET (customer_id, film_id) =
          ($1, $2) WHERE id = $3'
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = 'SELECT * FROM tickets'
    ticket_data = SqlRunner.run(sql)
    return Ticket.map_items(ticket_data)
  end

  def delete
    sql = 'DELETE FROM tickets WHERE id = $1'
    value = [@id]
    SqlRunner.run(sql, value)
  end

  def self.delete_all
    sql = 'DELETE FROM tickets'
    SqlRunner.run(sql)
  end

  def self.map_items(ticket_data)
    result = ticket_data.map { |ticket| Ticket.new(ticket) }
    return result
  end

  def find_customer_by_id
    sql = 'SELECT FROM tickets
          INNER JOIN films
          WHERE customer_id = $1'
    values = [@customer_id]
    SqlRunner.run(sql, values)
  end
end
