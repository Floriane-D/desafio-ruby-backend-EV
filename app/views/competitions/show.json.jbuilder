json.extract! @competition, :id, :name, :unit, :finished, :criteria_to_win, :max_number_of_attempts

json.ranking @competition.ranking do |result|
  json.extract! result, :id, :athlete, :value
end
