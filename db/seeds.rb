require 'faker'

puts 'Creating 2 competitions...'

one_hundred_metres_race = Competition.create(
  name: "100m classificatoria 1",
  unit: "s",
  criteria_to_win: :min)

javelin_throw = Competition.create(
  name: "Dardo semifinal",
  unit: "m",
  max_number_of_attempts: 3)

puts 'Creating 5 athletes...'
5.times do
  athlete = Athlete.new(name: Faker::Name.name)
  athlete.save!
end

puts 'Creating 5 results for the 100m race...'
athletes_for_race = (1..5).to_a
5.times do
  result = Result.new(
    competition_id: 1,
    athlete_id: athletes_for_race.sample,
    value: Faker::Number.between(7, 15)
  )
  result.save!
  athletes_for_race.delete(result.athlete_id)
end

puts 'Creating 15 results for the Javelin throw (3 attempts per athlete)...'
athletes_for_javelin = (1..5).to_a * 3
15.times do
  result = Result.new(
    competition_id: 2,
    athlete_id: athletes_for_javelin.sample,
    value: Faker::Number.between(70, 100)
  )
  result.save!
  athletes_for_javelin.slice!(athletes_for_javelin.index(result.athlete_id))
end

puts 'Finished!'
