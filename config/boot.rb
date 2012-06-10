PROJECT_ROOT = File.dirname(__FILE__) + '/..'
Dir.glob(PROJECT_ROOT + '/lib/*.rb') {|file| require file}
Dir.glob(PROJECT_ROOT + '/lib/cli/*.rb') {|file| require file}
Dir.glob(PROJECT_ROOT + '/models/*.rb') {|file| require file}

DATA_DIR = PROJECT_ROOT + '/data' unless defined?(DATA_DIR)