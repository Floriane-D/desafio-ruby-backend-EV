class Competition < ApplicationRecord
  has_many :results, dependent: :destroy
  has_many :athletes, -> { distinct }, through: :results

  validates :name,
    presence: true,
    uniqueness: { case_sensitive: false }

  validates :unit,
    presence: true

  validates :criteria_to_win,
    presence: true,
    inclusion: { in: %w(min max),
    message: "%{value} has to be either min or max" }

  validates :max_number_of_attempts,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }

  def finish
    update finished: true
  end

  def ranking
    results
      .group(:athlete_id)
      .order(value: results_order)
  end

  private

  def results_order
    criteria_to_win == "max" ? "desc" : "asc"
  end
end
