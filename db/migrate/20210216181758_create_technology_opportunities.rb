class CreateTechnologyOpportunities < ActiveRecord::Migration[6.0]
  def change
    create_table :technology_opportunities do |t|
      t.references :technology, null: false, foreign_key: true
      t.references :opportunity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
