require_relative("../db/sql_runner")
require_relative("ticket")

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
    (name, funds)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def film()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE tickets.customer_id = $1"
    values = [@id]
    film_hashes = SqlRunner.run(sql, values)
    films = film_hashes.map { |film_hashes| Film.new(film_hashes) }
    return films
  end

  def buy_ticket
    film_array = self.film()
    film_array.each do |film| @funds -= film.price
    self.update()
    new_ticket = Ticket.new({ 'customer_id' => @id, 'film_id' => film.id})
    new_ticket.save
    end
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.select_all()
    sql = "SELECT * FROM customers"
    results = SqlRunner.run(sql)
    self.map_all(results, self)
  end

  def self.map_all(results, class_)
    results.map{|result_hash| class_.new(result_hash)}
  end

  def tickets()
    sql = "SELECT tickets.*
    FROM tickets
    WHERE tickets.customer_id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    return tickets.count
  end

end
