class CreatePlayer < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.integer :winning_hands, null: false, default: 0
    end
  end
end
