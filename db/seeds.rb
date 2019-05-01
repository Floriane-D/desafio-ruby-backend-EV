one_hundred_metres_race = Competition.create(
  name: "100m classificatoria 1",
  unit: "s",
  criteria_to_win: :min)

javelin_throw = Competition.create(
  name: "Dardo semifinal",
  unit: "m",
  max_number_of_attempts: 3)
