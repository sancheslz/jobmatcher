class AddCompanyRefToOpportunities < ActiveRecord::Migration[6.0]
  def change
    add_reference :opportunities, :company, null: false, foreign_key: true
  end
end
