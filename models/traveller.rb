class Traveller
  attr_reader :id, :name, :min_price, :max_price, :requirements
  attr_accessor :booking

  def initialize params
    @id = params['id']
    @name = params['name']
    @min_price = params['priceRange']['min']
    @max_price = params['priceRange']['max']
    @requirements = params['requirements']
    @booking = params['booking']
  end
end