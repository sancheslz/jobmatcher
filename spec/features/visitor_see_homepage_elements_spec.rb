require 'rails_helper'

feature('Visitor sees on homepage navbar') do
    scenario('site title') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_content(t('views.home.title'))
        end
    end
    
    scenario('short description') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_content(t('views.home.description'))
        end
    end

    scenario('search field') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_content(t('views.home.search'))
        end
    end

    scenario('search button') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_content(t('views.home.search_btn'))
        end
    end

    scenario('sign in button') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_content(t('views.home.sign_in'))
        end
    end

    scenario('sign up button') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_content(t('views.home.sign_up'))
        end
    end
end