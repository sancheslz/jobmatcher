require 'rails_helper'

# TODO: define route from home
feature('Admin create opportunity') do

    scenario('see the title') do
        # Arrage 

        # Act
        visit new_opportunity_path

        # Assert
        expect(page).to have_content(I18n.t('views.opportunities.new_title'))
    end

    scenario('have the form fields') do
        # Arrage 
        # Act
        visit new_opportunity_path

        # Assert
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.title'))
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.description'))
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.requirement'))
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.expiration_date'))
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.position_quantity'))
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.salary'))
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.remote'))
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.level'))
    end

    scenario('required can\'t be blank') do
        # Arrage 
        # Act
        visit new_opportunity_path
        fill_in I18n.t('activerecord.attributes.opportunity.title'), with: ''
        fill_in I18n.t('activerecord.attributes.opportunity.description'), with: ''
        fill_in I18n.t('activerecord.attributes.opportunity.requirement'), with: ''
        click_on I18n.t('views.opportunities.new_submit')
        
        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'), count: 3)
    end

    scenario('create with success') do
        # Arrage 
        Technology.create!(name: 'Rails')
        Technology.create!(name: 'Ruby')
        Technology.create!(name: 'Git')
        Company.create!(
            name: 'Campus Code',
            cnpj: '1233456',
            address: 'My address',
            number: '1234',
            complement: 'BLC B',
            neighborhood: 'Paulista',
            city: 'São Paulo',
            state: 'SP',
            postal_code: '11345-345',
            website: 'www.campuscode.com',
            founded:  '2010',
        )

        # Act
        visit new_opportunity_path
        fill_in I18n.t('activerecord.attributes.opportunity.title'), with: 'Desenvolvedor Rails'
        fill_in I18n.t('activerecord.attributes.opportunity.description'), with: 'Vaga para desenvolvedor Rails'
        fill_in I18n.t('activerecord.attributes.opportunity.requirement'), with: 'Conhecimento em Rails'
        fill_in I18n.t('activerecord.attributes.opportunity.expiration_date'), with: 30.days.from_now.strftime('%d/%m/%Y')
        fill_in I18n.t('activerecord.attributes.opportunity.position_quantity'), with: 1
        fill_in I18n.t('activerecord.attributes.opportunity.salary'), with: '2500,00'
        select I18n.t('views.opportunities.level_entry'), from: I18n.t('activerecord.attributes.opportunity.level')
        select I18n.t('views.opportunities.remote_yes'), from: I18n.t('activerecord.attributes.opportunity.remote')
        check 'Rails'
        check 'Ruby'
        check 'Git'
        click_on I18n.t('views.opportunities.new_submit')

        opportunity = Opportunity.last
        # Assert
        expect(current_path).to eq(opportunity_path(opportunity))
    end

end