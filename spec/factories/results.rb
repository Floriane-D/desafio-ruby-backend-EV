FactoryBot.define do
  factory :result_from_competition_with_only_one_attempt, class: Result do
    association :competition, factory: :competition_with_only_one_attempt
    athlete
    value 10.49
  end

  factory :result_from_competition_with_several_attempts, class: Result do
    association :competition, factory: :competition_with_several_attempts
    athlete
    value 90.57
  end
end
