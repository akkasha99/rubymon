class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, :allow_blank => false, :uniqueness => true, :presence => true
  has_many :monsters

  def user_data_json(user)
    {
        :id => user.id,
        :email => user.email,
        :session_token => user.session_token,
        :facebook_id => user.facebook_id.present? ? resource.facebook_id : ""
    }
  end

  def user_monsters(user)
    monsters = user.monsters
    if monsters.blank?
      []
    else
      monsters.map { |mon| {:id => mon.id, :name => mon.name, :type => mon.type.name} }
    end
  end

end
