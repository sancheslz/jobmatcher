class AddRoleToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :role, :integer
  end
end
