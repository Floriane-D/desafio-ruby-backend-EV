class Result < ApplicationRecord
  belongs_to :athlete
  belongs_to :competition

  validates :value,
    presence: true,
    numericality: { greater_than: 0 }

  validate :competition_is_still_running
  validate :athlete_still_has_attempts

  scope :from_athlete, -> (athlete) { where(athlete: athlete) }

  protected

  def competition_is_still_running
    if competition.try(:finished?)
      error_message = "You cannot add a new result because the competition is finished"
      self.errors.add(:competition, error_message)
    end
  end

  def athlete_still_has_attempts
    if competition && athlete
      number_of_attempts = competition.results.from_athlete(athlete).count
      max_attempts = competition.max_number_of_attempts

      if number_of_attempts >= max_attempts
        error_message = "The athlete already reached the maximum number of attempts for this competition"
        self.errors.add(:athlete, error_message)
      end
    end
  end
end
