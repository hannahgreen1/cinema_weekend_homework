require('pry')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

Film.delete_all()
Customer.delete_all()

movie1 = Film.new({'title' => 'Brave', 'price' => 5})
film1.save()
film2 = Film.new({'title' => 'Avengers', 'price' => 5})
film2.save()
# film2.title = 'The Room'
# film2.update()
film3 = Film.new({'title' => 'Frozen', 'price' => 5})
film3.save()

customer1 = Customer.new({'name' => 'Hannah', 'funds' => 50})
customer1.save()
customer2 = Customer.new({'name' => 'Rachel', 'funds' => 50})
customer2.save()
# customer2.update()
customer3 = Customer.new({'name' => 'Davina', 'funds' => 50})
customer3.save()


binding.pry
nil
