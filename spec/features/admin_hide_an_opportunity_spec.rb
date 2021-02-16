require 'rails_helper'

# TODO: define route from home
feature('Admin hide a job opportunity') do
    
    scenario('access company\'s  opportunities') do
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
        expect(page).to have_content(opportunity.title)

    end

    scenario('can see only own opportunities') do
        # Arrange
        other_company = Company.create!(
            name: 'Rebase',
            cnpj: '1235',
            website: 'www.rebase.com.br'
        )
        company = Company.create!(
            name: 'Campus Code',
            cnpj: '1234',
            website: 'www.campuscode.com.br'
        )

        other_opportunity = Opportunity.create!(
            company: other_company.reload,
            title: 'Desenvolvedor Java',
            description: 'Conhecimento de Java',
            requirement: 'Experiência com Java e AWS',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            is_visible: true
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
        expect(page).to have_content(opportunity.title)
        expect(page).not_to have_content(other_opportunity.title)
    end 

    scenario('can see only active') do
        # Arrange
        company = Company.create!(
            name: 'Campus Code',
            cnpj: '1234',
            website: 'www.campuscode.com.br'
        )

        inactive_opportunity = Opportunity.create!(
            company: company.reload,
            title: 'Desenvolvedor Java',
            description: 'Conhecimento de Java',
            requirement: 'Experiência com Java e AWS',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            is_visible: false
        )
        active_opportunity = Opportunity.create!(
            company: company.reload,
            title: 'Desenvolvedor Rails',
            description: 'Conhecimento de Rails e Angular',
            requirement: 'Experiência com Rails 6',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            is_visible: true,
        )

        # Act
        visit company_path(company)

        # Assert
        expect(page).to have_content(active_opportunity.title) 
        expect(page).not_to have_content(inactive_opportunity.title) 
    end 

    scenario('can hide') do
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
            expect(page).to have_link(I18n.t('views.opportunities.hide'))
        end
    end 

    scenario('hide with success') do
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
            click_on I18n.t('views.opportunities.hide')
        end

        # Assert
        expect(page).not_to have_content(opportunity.title)
    end 

end