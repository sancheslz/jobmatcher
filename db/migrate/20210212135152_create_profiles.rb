class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :cpf
      t.text :bio
      t.string :address
      t.string :number
      t.string :complement
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :postal_code
      t.boolean :is_active

      t.timestamps
    end
  end
end
