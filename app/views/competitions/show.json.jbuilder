json.extract! @competition, :id, :name, :unit, :finished, :criteria_to_win, :max_number_of_attempts
json.results @competition.results do |result|
  json.extract! result, :id, :value
end
