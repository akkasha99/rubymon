class CreateTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :types do |t|
      t.string :name
      t.integer :strong_against
      t.integer :weak_against
      t.timestamps
    end
  end
end
