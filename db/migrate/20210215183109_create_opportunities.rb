class CreateOpportunities < ActiveRecord::Migration[6.0]
  def change
    create_table :opportunities do |t|
      t.string :title
      t.text :description
      t.text :requirement
      t.date :expiration_date
      t.integer :position_quantity
      t.decimal :salary
      t.boolean :remote
      t.integer :level

      t.timestamps
    end
  end
end
