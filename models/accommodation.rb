class Accommodation
  attr_reader :id, :name, :price, :attributes, :total_capacity
  attr_accessor :guests, :free_capacity

  def initialize params
    @id = params['id']
    @name = params['name']
    @price = params['price']
    @attributes = params['attributes']
    @total_capacity = params['capacity']['total']
    @free_capacity = params['capacity']['free']
    @guests = params['guests']
  end
end