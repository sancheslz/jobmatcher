require 'rails_helper'

feature('Visitor sees on homepage navbar') do
    scenario('site title') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        expect(page).to have_content(I18n.t('views.home.title'))
    end
    
    scenario('short description') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        expect(page).to have_content(I18n.t('views.home.description'))
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