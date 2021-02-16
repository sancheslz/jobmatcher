require 'rails_helper'

feature('Visitor sees on homepage') do

    scenario('site title on navbar') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_content(I18n.t('views.home.title'))
        end
    end

    scenario('site title on jumbotron') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('div.jumbotron') do
            expect(page).to have_content(I18n.t('views.home.title'))
        end
    end
    
    scenario('short description') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('div.jumbotron') do
            expect(page).to have_content(I18n.t('views.home.description'))
        end
    end

    scenario('last opportunities section title') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        expect(page).to have_content(I18n.t('views.home.last_opportunities'))
    end

    scenario('see a message if no opportunities') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        expect(page).to have_content(I18n.t('views.home.empty'))
    end

    scenario('see opportunity if exists') do 
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
            company: company.reload
        )

        # Act
        visit root_path

        # Assert
        expect(page).to have_content(opportunity.title)
        expect(page).to have_content(opportunity.description)
        expect(page).to have_content(opportunity.company.name)
    end

    scenario('search field') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_field(placeholder: I18n.t('views.home.search')) 
        end
    end

    scenario('search button') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_content(I18n.t('views.home.search_btn'))
        end
    end

    scenario('sign in button') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_content(I18n.t('views.home.sign_in'))
        end
    end

    scenario('sign up button') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_content(I18n.t('views.home.sign_up'))
        end
    end

end