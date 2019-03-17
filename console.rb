require('pry-byebug')
require_relative('models/ticket')
require_relative('models/customer')
require_relative('models/film')

Film.delete_all
Customer.delete_all
Screening.delete_all

film1 = Film.new({
  'title' => 'Happy Gilmore',
  'price' => '20'
  })
film2 = Film.new({
  'title' => 'The Shining',
  'price' => '25'
  })
film3 = Film.new({
  'title' => 'Alien',
  'price' => '30'
  })
film1.save
film2.save
film3.save

customer1 = Customer.new({
  'name' => 'Rory MacGregor',
  'funds' => '200'
  })
customer2 = Customer.new({
  'name' => 'Grant Rutherford',
  'funds' => '1000'
  })
customer3 = Customer.new({
  'name' => 'Charlie Walker',
  'funds' => '400'
  })
customer1.save
customer2.save
customer3.save

screening1 = Screening.new({
  'capacity' => '50',
  'screening_time' => '1300'
  })
screening2 = Screening.new({
  'capacity' => '50',
  'screening_time' => '1400'
  })
screening3 = Screening.new({
  'capacity' => '50',
  'screening_time' => '1500'
  })
screening4 = Screening.new({
  'capacity' => '50',
  'screening_time' => '1600'
  })
screening5 = Screening.new({
  'capacity' => '50',
  'screening_time' => '1700'
  })
screening6 = Screening.new({
  'capacity' => '50',
  'screening_time' => '1700'
  })
screening7 = Screening.new({
  'capacity' => '50',
  'screening_time' => '1800'
  })
screening8 = Screening.new({
  'capacity' => '50',
  'screening_time' => '1900'
  })
screening9 = Screening.new({
  'capacity' => '50',
  'screening_time' => '2000'
  })
screening1.save
screening2.save
screening3.save
screening4.save
screening5.save
screening6.save
screening7.save
screening8.save
screening9.save

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id,
  'screening_id' => screening1.id
  })
ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id,
  'screening_id' => screening2.id
  })
ticket3 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film3.id,
  'screening_id' => screening3.id
  })
ticket4 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film3.id,
  'screening_id' => screening1.id
  })
ticket5 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id,
  'screening_id' => screening1.id
  })
ticket6 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id,
  'screening_id' => screening2.id
  })
ticket7 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film3.id,
  'screening_id' => screening3.id
  })
ticket8 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id,
  'screening_id' => screening1.id
  })

ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save
ticket6.save
ticket7.save
ticket8.save

# film1.find_customers_by_film
# customer1.find_films_by_customer

# film1.title = 'Happiest Gilmore'
# film1.update

# film1.delete
# customer1.delete
# ticket1.delete

# customer1.name = 'Rory the MC Gregor'
# customer1.update

Screening.most_popular_film_showing

customer1.buy_tickets([film1, film2], [screening1, screening2])

binding.pry
nil
