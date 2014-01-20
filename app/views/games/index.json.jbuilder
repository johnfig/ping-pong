json.array!(@games) do |game|
  json.extract! game, :id, :winner_id, :loser_id
  json.url game_url(game, format: :json)
end
