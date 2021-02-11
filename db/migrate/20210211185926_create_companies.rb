class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :cnpj, :unique => true
      t.string :address
      t.string :number
      t.string :complement
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :website
      t.string :founded

      t.timestamps
    end
  end
end
