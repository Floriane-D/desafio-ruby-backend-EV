json.array! @competitions do |competition|
  json.extract! competition, :id, :name, :unit, :finished, :criteria_to_win, :max_number_of_attempts
  json.url competition_url(competition, format: :json)
end
