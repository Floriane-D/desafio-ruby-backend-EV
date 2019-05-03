json.extract! @competition, :id, :name, :unit, :finished, :criteria_to_win, :max_number_of_attempts

json.ranking @competition.ranking do |result|
  json.athlete_name result.athlete.name
  json.athlete_id result.athlete.id
  json.extract! result, :value
end
