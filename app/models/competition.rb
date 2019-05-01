class Competition < ApplicationRecord
  has_many :results, dependent: :destroy
  has_many :athletes, -> { distinct }, through: :results
end
