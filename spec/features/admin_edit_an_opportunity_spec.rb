require 'rails_helper'

# TODO: implement access from root path
feature('Admin edit an opportunity') do

    scenario('has the edit button') do
        # Arrange
        company = Company.create!(
            name: 'Campus Code',
            cnpj: '1234',
            website: 'www.campuscode.com.br'
        )

        opportunity = Opportunity.create!(
            company: company.reload,
            title: 'Desenvolvedor Rails',
            description: 'Conhecimento de Rails e Angular',
            requirement: 'Experiência com Rails 6',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            is_visible: true
        )

        # Act
        visit company_path(company)

        # Assert
        within("div#opportunity_#{opportunity.reload.id}") do
            expect(page).to have_link(I18n.t('views.main.edit'))
        end
    end

    scenario('access the edit form') do
        # Arrange
        company = Company.create!(
            name: 'Campus Code',
            cnpj: '1234',
            website: 'www.campuscode.com.br'
        )

        opportunity = Opportunity.create!(
            company: company.reload,
            title: 'Desenvolvedor Rails',
            description: 'Conhecimento de Rails e Angular',
            requirement: 'Experiência com Rails 6',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            is_visible: true
        )

        # Act
        visit company_path(company)
        within("div#opportunity_#{opportunity.reload.id}") do
            click_on I18n.t('views.main.edit')
        end

        # Assert
        expect(current_path).to eq(edit_opportunity_path(opportunity))
    end

    scenario('required fields can\'t be blank') do
        # Arrange
        company = Company.create!(
            name: 'Campus Code',
            cnpj: '1234',
            website: 'www.campuscode.com.br'
        )

        opportunity = Opportunity.create!(
            company: company.reload,
            title: 'Desenvolvedor Rails',
            description: 'Conhecimento de Rails e Angular',
            requirement: 'Experiência com Rails 6',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            is_visible: true
        )

        # Act
        visit company_path(company)
        within("div#opportunity_#{opportunity.reload.id}") do
            click_on I18n.t('views.main.edit')
        end
        fill_in I18n.t('activerecord.attributes.opportunity.title'), with: ''
        fill_in I18n.t('activerecord.attributes.opportunity.description'), with: ''
        fill_in I18n.t('activerecord.attributes.opportunity.requirement'), with: ''
        click_on I18n.t('views.opportunities.edit_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'), count: 3)
    end

    scenario('update with success') do
        # Arrange
        company = Company.create!(
            name: 'Campus Code',
            cnpj: '1234',
            website: 'www.campuscode.com.br'
        )

        opportunity = Opportunity.create!(
            company: company.reload,
            title: 'Desenvolvedor Rails',
            description: 'Conhecimento de Rails e Angular',
            requirement: 'Experiência com Rails 6',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            is_visible: true
        )

        # Act
        visit company_path(company)
        within("div#opportunity_#{opportunity.reload.id}") do
            click_on I18n.t('views.main.edit')
        end
        fill_in I18n.t('activerecord.attributes.opportunity.title'), with: 'Desenvolvedor Ruby on Rails'
        click_on I18n.t('views.opportunities.edit_submit')

        # Assert
        expect(page).not_to have_content(opportunity.title)
        expect(page).to have_content(opportunity.reload.title)
    end

end