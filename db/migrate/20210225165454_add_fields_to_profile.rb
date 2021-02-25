class AddFieldsToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :linkedin, :string
    add_column :profiles, :github, :string
  end
end
