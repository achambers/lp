LP_ENV = LP_ENV ||= :production

APP_ROOT = File.dirname(__FILE__) + '/..'

module LonelyPlanet
  class << self
    def root(*args)
      File.expand_path(File.join(APP_ROOT, *args))
    end
  end
end

require 'bundler/setup'
Bundler.require(:default, LP_ENV)

Dir.glob(File.dirname(__FILE__) + '/../lib/*') {|file| require file}