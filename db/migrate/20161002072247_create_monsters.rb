class CreateMonsters < ActiveRecord::Migration[5.0]
  def change
    create_table :monsters do |t|
      t.references :user, foreign_key: true
      t.references :type, foreign_key: true
      t.references :team, foreign_key: true
      t.string :name
      t.string :power
      t.timestamps
    end
  end
end
