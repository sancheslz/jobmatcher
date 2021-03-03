require 'rails_helper'

describe "Opportunity" do

  context "#valid?" do

    it "title is required" do
      # Arrange

      # Act
      opportunity = Opportunity.new
      opportunity.valid?

      # Assert
      expect(opportunity.errors[:title]).to include(
        I18n.t('errors.messages.blank')
      )
    end

    it "description is required" do
      # Arrange

      # Act
      opportunity = Opportunity.new
      opportunity.valid?

      # Assert
      expect(opportunity.errors[:description]).to include(
        I18n.t('errors.messages.blank')
      )
    end

    it "requirement is required" do
      # Arrange

      # Act
      opportunity = Opportunity.new
      opportunity.valid?

      # Assert
      expect(opportunity.errors[:requirement]).to include(
        I18n.t('errors.messages.blank')
      )
    end

    it "hidden as default" do
      # Arrange

      # Act
      opportunity = Opportunity.new

      # Assert
      expect(opportunity.is_visible).to eq(false)

    end

  end
  
  context "#add_date_if_empty" do
    
    it "user fill date" do
      # Arrange
      Company.create!(
        :name => 'Campus Code',
        :cnpj => '1234',
        :website => 'www.campuscode.com.br'
      )
      # Act
      opportunity = Opportunity.create!(
        :company => Company.last,
        :title => 'Desenvolvedor Rails',
        :description => 'Conhecimento de Rails e Angular',
        :requirement => 'Experiência com Rails 6',
        :expiration_date => Time.now.strftime('%d/%m/%Y')
      )
      
      # Assert
      expect(opportunity.reload.expiration_date.strftime('%d/%m/%Y')).to \
      eq(Time.now.strftime('%d/%m/%Y'))
    end
    
    it "default 30 days if empty" do
      # Arrange
      Company.create!(
        :name => 'Campus Code',
        :cnpj => '1234',
        :website => 'www.campuscode.com.br'
      )
      # Act
      opportunity = Opportunity.create!(
        :company => Company.last,
        :title => 'Desenvolvedor Rails',
        :description => 'Conhecimento de Rails e Angular',
        :requirement => 'Experiência com Rails 6'
      )
      
      # Assert
      expect(opportunity.reload.expiration_date.strftime('%d/%m/%Y')).to \
      eq(30.days.from_now.strftime('%d/%m/%Y'))
    end
    

  end
  
  context "#change_visibility!" do

    it "hide if visible" do
      # Arrange
      Company.create!(
        :name => 'Campus Code',
        :cnpj => '1233456',
        :address => 'Alameda Santos',
        :number => '1293',
        :complement => 'Conj 73',
        :neighborhood => 'Jardim Paulista',
        :city => 'São Paulo',
        :state => 'SP',
        :postal_code => '11345-111',
        :website => 'www.campuscode.com',
        :founded => '2010',
      )

      opportunity = Opportunity.create!(
        :title => 'Desenvolvedor Rails',
        :description => %{Deverá desenvolver aplicações Rails com entrega e \
          consumo de api},
        :requirement => %{Conhecimento em ruby e rails. Desejável conhecimento\
           em React},
        :company => Company.last,
        :is_visible => true
      )

      # Act
      opportunity.reload
      changed = Opportunity.last
      changed.change_visibility!

      # Assert
      expect(opportunity.is_visible).not_to eq(changed.is_visible)
    end

    it "show if hidden" do
      # Arrange
      Company.create!(
        :name => 'Campus Code',
        :cnpj => '1233456',
        :address => 'Alameda Santos',
        :number => '1293',
        :complement => 'Conj 73',
        :neighborhood => 'Jardim Paulista',
        :city => 'São Paulo',
        :state => 'SP',
        :postal_code => '11345-111',
        :website => 'www.campuscode.com',
        :founded => '2010',
      )
      opportunity = Opportunity.create!(
        :title => 'Desenvolvedor Rails',
        :description => %{Deverá desenvolver aplicações Rails com entrega \
          e consumo de api},
        :requirement => %{Conhecimento em ruby e rails. Desejável conhecimento\
           em React},
        :company => Company.last,
        :is_visible => false
      )

      # Act
      opportunity.reload
      changed = Opportunity.last
      changed.change_visibility!

      # Assert
      expect(opportunity.is_visible).not_to eq(changed.is_visible)
    end
    
  end
  
end
