class Type < ApplicationRecord
  has_many :monsters, :dependent => :destroy

  def type_strong_against(type)
    Type.find(type.strong_against).name
  end

  def type_weak_against(type)
    Type.find(type.weak_against).name
  end
end
