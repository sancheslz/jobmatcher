class AddFieldsToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :facebook, :string
    add_column :companies, :linkedin, :string
    add_column :companies, :instagram, :string
    add_column :companies, :youtube, :string
  end
end
