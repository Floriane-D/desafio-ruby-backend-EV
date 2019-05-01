FactoryBot.define do
  factory :competition_with_only_one_attempt, class: Competition do
    name '100m classificatoria 1'
    unit 's'
    # criteria_to_win 'min'
  end

  factory :competition_with_several_attempts, class: Competition do
    name 'Dardo semifinal'
    unit 'm'
    max_number_of_attempts 3
  end
end
