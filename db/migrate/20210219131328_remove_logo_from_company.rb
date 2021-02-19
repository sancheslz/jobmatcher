class RemoveLogoFromCompany < ActiveRecord::Migration[6.0]
  def change
    remove_column :companies, :logo, :string
  end
end
