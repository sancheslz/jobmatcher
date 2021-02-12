class AddDefaultValueToProfiles < ActiveRecord::Migration[6.0]
  def change
    change_column :profiles, :is_active, :boolean, :default => true
  end
end
