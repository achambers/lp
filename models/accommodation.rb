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
    if params['guests']
      @guests = params['guests']
    else
      @guests = []
    end
  end

  def guests?
    !guests.nil? && guests.length > 0
  end

  def to_json
    params = {}
    params['id'] = @id
    params['name'] = @name
    params['price'] = @price
    params['attributes'] = @attributes
    params['capacity'] = {}
    params['capacity']['total'] = @total_capacity
    params['capacity']['free'] = @free_capacity
    params['guests'] = @guests
    params
  end

  def add_guest traveller
    @guests << traveller.id
    @free_capacity -= 1
  end
end