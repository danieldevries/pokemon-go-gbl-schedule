require_relative 'lib/pokemon_go'

PokemonGo::GoBattleLeague.schedule.tap do |data|
  File.open(Pathname.getwd / 'data' / 'gbl-schedule.json', 'w') do |file|
    file.write data.to_json
  end
end

