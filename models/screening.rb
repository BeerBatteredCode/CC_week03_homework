require_relative('../db/sqlrunner.rb')
require_relative('./film.rb')
require_relative('./ticket.rb')
require_relative('./customer.rb')

class Screening

  attr_reader :id
  attr_accessor :capacity, :screening_time

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @capacity = options['capacity'].to_i
    @screening_time = options['screening_time']
  end

  def save
    sql = 'INSERT INTO screenings (capacity, screening_time)
          VALUES ($1, $2)
          RETURNING id'
    values = [@capacity, @screening_time]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def update
    sql = 'UPDATE screenings SET (capacity, screening_time) =
          ($1, $2) WHERE id = $3'
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.most_popular_film_showing
    sql = 'SELECT films.title, screening_time, count(screening_time)
          AS amount
          FROM screenings
          INNER JOIN tickets
          ON tickets.screening_id = screenings.id
          INNER JOIN films
          ON tickets.film_id = films.id
          GROUP BY screening_time, films.title
          ORDER BY amount DESC
          LIMIT 1'
    result = SqlRunner.run(sql)
    return result.to_a
  end

  def self.delete_all
    sql = 'DELETE FROM screenings'
    SqlRunner.run(sql)
  end

  def book_ticket
    @capacity -=1
    self.update
  end

  def self.map_items(screening_data)
    result = screening_data.map { |screening| Screening.new(screening) }
    return result
  end

end
