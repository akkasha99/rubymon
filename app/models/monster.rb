class Monster < ApplicationRecord
  belongs_to :user
  belongs_to :type
  belongs_to :team
  validates_presence_of :name, :power, :user_id, :type_id

  validate :on => :create do
    if user && user.monsters.length >= 2
      errors.add(:user, 'You already have 20 monsters.')
    end
  end

  def monster_json()
end
