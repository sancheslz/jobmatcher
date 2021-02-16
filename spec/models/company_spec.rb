require 'rails_helper'

describe "a specification" do

  context "valid?" do

    it "name is required" do
      # Arrange

      # Act
      company = Company.new
      company.valid?

      # Assert
      expect(company.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it "cnpj is required" do
      # Arrange

      # Act
      company = Company.new
      company.valid?

      # Assert
      expect(company.errors[:cnpj]).to include(I18n.t('errors.messages.blank'))
    end

    it "website is required" do
      # Arrange

      # Act
      company = Company.new
      company.valid?

      # Assert
      expect(company.errors[:website]).to include(I18n.t('errors.messages.blank'))
    end

    it "cnpj is unique" do
      # Arrange
      Company.create!(
        name: 'Campus Code',
        cnpj: '1234',
        website: 'www.campuscode.com.br'
      )

      # Act
      company = Company.new(
        name: 'Rebase',
        cnpj: '1234',
        website: 'www.rebase.com.br'
      )
      company.valid?

      # Assert
      expect(company.errors[:cnpj]).to include(I18n.t('errors.messages.taken'))
    end
    
  end

  context "#active?" do

    it "returns is_active attribute" do
      # Arrange
      
      # Act
      company = Company.new(
        name: 'Rebase',
        cnpj: '1234',
        website: 'www.rebase.com.br'
      )

      # Assert
      expect(company.active?).to eq(company.is_active)

    end
        
  end
  

  context "#change_state!" do
    it "description" do
      
      # Arrange
      company = Company.new(
        name: 'Rebase',
        cnpj: '1234',
        website: 'www.rebase.com.br'
      )
  
      # Act
      initial_state = company.active?
      company.change_state!
  
      # Assert
      expect(company.active?).not_to eq(initial_state)
      
    end
    
  end
  
end
