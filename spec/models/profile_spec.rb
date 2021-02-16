require 'rails_helper'

describe Profile do
  
  context "valid?" do

    it "name is required" do
      # Arrange

      # Act
      profile = Profile.new
      profile.valid?

      # Assert
      expect(profile.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it "cpf is required" do
      # Arrange

      # Act
      profile = Profile.new
      profile.valid?

      # Assert
      expect(profile.errors[:cpf]).to include(I18n.t('errors.messages.blank'))
    end

    it "cpf is unique" do
      # Arrange
      Profile.create!(
        name: 'Bob Smith',
        cpf: '123'
      )

      # Act
      profile = Profile.new(
        cpf: '123'
      )
      profile.valid?

      # Assert
      expect(profile.errors[:cpf]).to include(I18n.t('errors.messages.taken'))
    end

    it "active as default" do
      # Arrange
      
      # Act
      profile = Profile.create!(
        name: 'Bob Smith',
        cpf: '123'
      )

      # Assert
      expect(profile.reload.is_active).to eq(true)
    end
    
  end

  context "#active?" do

    it "returns is_active attribute" do
      # Arrange

      # Act
      profile = Profile.create!(
        name: 'Bob Smith',
        cpf: '123'
      )

      # Assert
      expect(profile.reload.active?).to eq(profile.is_active)
    end
    
    
  end  

end
