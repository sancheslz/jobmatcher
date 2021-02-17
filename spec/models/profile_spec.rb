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
      user = User.create!(
        email: 'user@gmail.com',
        password: '123456'
      )

      Profile.create!(
        name: 'Bob Smith',
        cpf: '123',
        user: user
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
      user = User.create!(
        email: 'user@gmail.com',
        password: '123456'
      )
      
      # Act
      profile = Profile.create!(
        name: 'Bob Smith',
        cpf: '123',
        user: user
      )

      # Assert
      expect(profile.reload.is_active).to eq(true)
    end
    
  end

  context "#active?" do

    it "returns is_active attribute" do
      # Arrange
      user = User.create!(
        email: 'user@gmail.com',
        password: '123456'
      )
      # Act
      profile = Profile.create!(
        name: 'Bob Smith',
        cpf: '123',
        user: user
      )

      # Assert
      expect(profile.reload.active?).to eq(profile.is_active)
    end
    
  end  

  context "#set_role!" do
    
    it "regular user" do
      # Arrange
      user = User.create!(
        email: 'user@gmail.com',
        password: '123456'
      )
      # Act
      profile = Profile.create!(
        name: 'Bob Smith',
        cpf: '123',
        user: user
      )

      profile.set_role!(user.reload)
      profile.save

      # Assert
      expect(profile.reload.role).to eq('regular')
    end
    
    it "first business user" do
      # Arrange
      user = User.create!(
        email: 'user@rebase.com',
        password: '123456'
      )
      # Act
      profile = Profile.create!(
        name: 'Bob Smith',
        cpf: '123',
        user: user
      )

      profile.set_role!(user.reload)
      profile.save

      # Assert
      expect(profile.reload.role).to eq('admin')
    end
    
    it "other business user" do
      # Arrange
      first_user = User.create!(
        email: 'user@rebase.com',
        password: '123456'
      )
      Profile.create!(
        name: 'Bob Smith',
        cpf: '123',
        user: first_user,
        role: 'admin'
      )

      user = User.create!(
        email: 'other@rebase.com',
        password: '123456'
      )

      # Act
      profile = Profile.create!(
        name: 'Bob Smith',
        cpf: '124',
        user: user
      )

      profile.set_role!(user.reload)
      profile.save

      # Assert
      expect(profile.reload.role).to eq('business')
    end
    
  end

  context "#is_regular?" do

    it "regular user" do
      # Arrange
      user = User.create!(
        email: 'user@gmail.com',
        password: '123456'
      )
      # Act
      profile = Profile.create!(
        name: 'Bob Smith',
        cpf: '123',
        user: user
      )

      profile.set_role!(user.reload)
      profile.save

      # Assert
      expect(profile.reload.is_regular?).to eq(true)
    end
    
    it "admin is not regular" do
      # Arrange
      user = User.create!(
        email: 'user@rebase.com',
        password: '123456'
      )
      # Act
      profile = Profile.create!(
        name: 'Bob Smith',
        cpf: '123',
        user: user
      )

      profile.set_role!(user.reload)
      profile.save

      # Assert
      expect(profile.reload.is_regular?).to eq(false)
    end
    
    it "business user is not regular" do
      # Arrange
      first_user = User.create!(
        email: 'user@rebase.com',
        password: '123456'
      )
      Profile.create!(
        name: 'Bob Smith',
        cpf: '123',
        user: first_user,
        role: 'admin'
      )

      user = User.create!(
        email: 'other@rebase.com',
        password: '123456'
      )

      # Act
      profile = Profile.create!(
        name: 'Bob Smith',
        cpf: '124',
        user: user
      )

      profile.set_role!(user.reload)
      profile.save

      # Assert
      expect(profile.reload.is_regular?).to eq(false)
    end
  end
  
end
