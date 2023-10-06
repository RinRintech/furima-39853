class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.references :buy,                null: false, foreign_key: true
      t.string     :postal_code,        null: false
      t.integer    :prefecture_id,      null: false
      t.string     :city,               null: false
      t.string     :street,             null: false
      t.string     :block,              null: false
      t.string     :building,           null: false
      t.string     :tel,                null: false
      t.timestamps
    end
  end
end
