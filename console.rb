require('pry-byebug')
require_relative('models/ticket')
require_relative('models/customer')
require_relative('models/film')

Film.delete_all
Customer.delete_all

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

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })
ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id
  })
ticket3 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film3.id
  })
ticket4 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film3.id
  })

ticket1.save
ticket2.save
ticket3.save
ticket4.save

# film1.find_customers_by_film
# customer1.find_films_by_customer

# film1.title = 'Happiest Gilmore'
# film1.update

# film1.delete
# customer1.delete
# ticket1.delete

# customer1.name = 'Rory the MC Gregor'
# customer1.update

binding.pry
nil
