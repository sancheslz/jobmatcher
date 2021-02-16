require 'rails_helper'

describe "Technology" do

  context "valid?" do
    it "name is required" do
      # Arrange

      # Act
      technology = Technology.new
      technology.valid?

      # Assert
      expect(technology.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it "name is unique" do
      # Arrange
      Technology.create!(
        name: 'Ruby'
      )

      # Act
      technology = Technology.new(
        name: 'Ruby'
      )
      technology.valid?

      # Assert
      expect(technology.errors[:name]).to include(I18n.t('errors.messages.taken'))
    end

    it "name is unique and case insensitive" do
      # Arrange
      Technology.create!(
        name: 'Ruby'
      )

      # Act
      technology = Technology.new(
        name: 'ruby'
      )
      technology.valid?

      # Assert
      expect(technology.errors[:name]).to include(I18n.t('errors.messages.taken'))
    end
    
  end
  
end
