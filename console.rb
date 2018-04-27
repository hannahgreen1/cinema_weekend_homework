require('pry')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

Film.delete_all()
Customer.delete_all()

film1 = Film.new({'title' => 'Brave', 'price' => 5})
film1.save()
film2 = Film.new({'title' => 'Avengerss', 'price' => 5})
film2.save()
film2.title = 'Avengers'
film2.update()
film3 = Film.new({'title' => 'Frozen', 'price' => 5})
film3.save()

customer1 = Customer.new({'name' => 'Hannah', 'funds' => 50})
customer1.save()
customer2 = Customer.new({'name' => 'Rachel', 'funds' => 50})
customer2.save()
customer3 = Customer.new({'name' => 'Davina', 'funds' => 50})
customer3.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film1.id})
ticket2.save()


binding.pry
nil
