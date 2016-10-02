class Monster < ApplicationRecord
  belongs_to :user
  belongs_to :type
  belongs_to :team
  validates_presence_of :name, :power, :user_id, :type_id
  validate :team_id

  validate :on => :create do
    if user && user.monsters.length >= 2
      errors.add(:user, 'You already have 20 monsters.')
    end
  end

  def monster_data_json(monster)
    {
        :id => monster.id,
        :name => monster.name,
        :power => monster.power,
        :type => monster.type.name,
        :strong_against => monster.type.type_strong_against(monster.type),
        :weak_against => monster.type.type_weak_against(monster.type),
        :team => {:team_id => monster.team.id, :team_name => monster.team.name}
    }
  end

  def sorted_monsters(sort_by)
    monsters = user.monsters
    if monsters.blank?
      []
    else
      monsters.map { |mon| {:id => mon.id, :name => mon.name, :type => mon.type.name} }
    end
  end
end
end
