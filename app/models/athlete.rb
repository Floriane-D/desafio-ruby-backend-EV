class Athlete < ApplicationRecord
  has_many :results, dependent: :destroy
  has_many :competitions, -> { distinct }, through: :results

  validates :name,
    presence: true,
    uniqueness: { case_sensitive: false }
end
