Dir.glob(File.dirname(__FILE__) + '/../lib/*.rb') {|file| require file}
Dir.glob(File.dirname(__FILE__) + '/../lib/cli/*.rb') {|file| require file}