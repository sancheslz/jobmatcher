class CreateCompanyProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :company_profiles do |t|
      t.references :company
      t.references :profile, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
