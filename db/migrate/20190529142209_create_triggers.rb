class CreateTriggers < ActiveRecord::Migration[5.2]
  def change
    create_table :triggers do |t|
      t.references :order, null: false, index: true
      t.decimal    :price, null: false, default: 0,  precision: 32, scale: 16
      t.integer    :state, null: false, default: 0,  index: true
      t.string     :type,  null: false, index: true, limit: 10
      t.timestamps
    end
  end
end
