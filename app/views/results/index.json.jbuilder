json.array! @results do |result|
  json.extract! result, :id, :value, :athlete, :competition
end
