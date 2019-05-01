class Athlete < ApplicationRecord
  has_many :results, dependent: :destroy
  has_many :competitions, -> { distinct }, through: :results
end
