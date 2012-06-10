module LonelyPlanet
  def self.to_travellers file_name
    data = read_json file_name
    data.collect {|x| Traveller.new(x)}
  end

  def self.to_accommodations file_name
    data = read_json file_name
    data.collect {|x| Accommodation.new(x)}
  end

  def self.to_hash data
    data.collect {|entry| entry.to_json}
  end

  private

  def self.read_json file_name
    JSON.parse(File.read(DATA_DIR + '/' + file_name))
  end
end