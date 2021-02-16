require 'rails_helper'

feature('Visitor see details from home page') do
    
    scenario('have company access link') do
        # Arrange
        company = Company.create!(
            name: 'Campus Code',
            website: 'www.campuscode.com.br',
            cnpj: '1234'
        )

        opportunity = Opportunity.create!(
            title: 'Desenvolvedor Rails',
            description: 'Criar fantásticas aplicações web',
            requirement: 'Conhecimento em Rails e React',
            expiration_date: 10.days.from_now.strftime('%d/%m/%Y'),
            company: company.reload
        )

        # Act
        visit root_path

        # Assert
        within("div#opportunity_#{opportunity.reload.id}") do
            expect(page).to have_link(company.name)
        end
        
    end

    scenario('access company details') do
        # Arrange
        company = Company.create!(
            name: 'Campus Code',
            website: 'www.campuscode.com.br',
            cnpj: '1234'
        )

        opportunity = Opportunity.create!(
            title: 'Desenvolvedor Rails',
            description: 'Criar fantásticas aplicações web',
            requirement: 'Conhecimento em Rails e React',
            expiration_date: 10.days.from_now.strftime('%d/%m/%Y'),
            company: company.reload
        )

        # Act
        visit root_path
        within("div#opportunity_#{opportunity.reload.id}") do
            click_on company.name
        end
        
        # Assert
        expect(current_path).to eq(company_path(company))
        
    end

    scenario('have opportunity access link') do
        # Arrange
        company = Company.create!(
            name: 'Campus Code',
            website: 'www.campuscode.com.br',
            cnpj: '1234'
        )

        opportunity = Opportunity.create!(
            title: 'Desenvolvedor Rails',
            description: 'Criar fantásticas aplicações web',
            requirement: 'Conhecimento em Rails e React',
            expiration_date: 10.days.from_now.strftime('%d/%m/%Y'),
            company: company.reload
        )

        # Act
        visit root_path

        # Assert
        within("div#opportunity_#{opportunity.reload.id}") do
            expect(page).to have_link(I18n.t('views.home.more'))
        end
        
    end

    scenario('access company details') do
        # Arrange
        company = Company.create!(
            name: 'Campus Code',
            website: 'www.campuscode.com.br',
            cnpj: '1234'
        )

        opportunity = Opportunity.create!(
            title: 'Desenvolvedor Rails',
            description: 'Criar fantásticas aplicações web',
            requirement: 'Conhecimento em Rails e React',
            expiration_date: 10.days.from_now.strftime('%d/%m/%Y'),
            company: company.reload
        )

        # Act
        visit root_path
        within("div#opportunity_#{opportunity.reload.id}") do
            click_on I18n.t('views.home.more')
        end

        # Assert
        expect(current_path).to eq(opportunity_path(opportunity))
        
    end

end