class CreateHand < ActiveRecord::Migration[6.0]
  def change
    create_table :hands do |t|
      t.references :player, foreign_key: true
      t.references :game, foreign_key: true
      t.integer :card_codes, array: true, null: false, default: []
      t.boolean :winner, default: false, null: false
    end
  end
end
