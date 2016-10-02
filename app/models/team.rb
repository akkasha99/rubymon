class Team < ApplicationRecord
  belongs_to :user
  has_many :monsters

  validates_presence_of :user_id
  validate :on => :create do
    if user && user.monsters.length >= 2
      errors.add(:user, 'You already have 3 teams monsters.')
    end
  end
end
