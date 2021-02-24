class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.references :submission, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true
      t.text :comment
      t.date :start_at
      t.decimal :salary

      t.timestamps
    end
  end
end
