module LonelyPlanet
  def self.read_json file_name
    JSON.parse(File.read(DATA_DIR + '/' + file_name))
  end
end