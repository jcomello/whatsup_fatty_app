class Insult < ActiveRecord::Base

  validates :eating_what, :phrase, presence: true, length: { maximum: 120 }
end
