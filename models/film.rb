require_relative("../db/sql_runner")

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
    (title, price)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@title, @price]
    star = SqlRunner.run(sql, values).first
    @id = star['id'].to_i
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE films SET (title, funds) = ($1, $2) WHERE id = $3"
    values = [@title, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.select_all()
    sql = "SELECT * FROM films"
    results = SqlRunner.run(sql)
    self.map_all(results, self)
  end

  def self.map_all(results, class_)
    results.map{|result_hash| class_.new(result_hash)}
  end
end
