require_relative('../db/sqlrunner.rb')
require_relative('./film.rb')
require_relative('./ticket.rb')
require_relative('./customer.rb')

class Screening

  attr_reader :id
  attr_accessor :capacity, :screening_time

  def initialize
    @id = options['id']
    @capacity = options['capacity']
    @screening_time = options ['screening_time']
  end

  def self.map_items(screening_data)
    result = screening_data.map { |screening| Screening.new(screening) }
    return result
  end
  
end
