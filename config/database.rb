case LP_ENV
  when :test then DataMapper.setup(:default, 'sqlite3::memory:')
  else DataMapper.setup(:default, 'sqlite3://' + LonelyPlanet.root('db', 'lonely_planet.db'))
end