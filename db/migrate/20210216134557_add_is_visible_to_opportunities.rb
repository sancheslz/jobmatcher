class AddIsVisibleToOpportunities < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :is_visible, :boolean, :default => false
  end
end
