require 'rails_helper'

feature('Admin create technologies') do

    scenario('have option on menu') do
        # Arrange 
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )

        Profile.create!(
            name: 'Graciliana Novaes',
            cpf: '388.586.242-26',
            address: 'Rua Quatro',
            number: '8229',
            complement: '-', 
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '75674',
            role: 'admin',
            user: user
        )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
        end
        
        # Assert
        within('nav') do
            expect(page).to have_field(I18n.t('views.technologies.title'))
        end
    end

    scenario('can register a new one') do
        # Arrange 
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )

        Profile.create!(
            name: 'Graciliana Novaes',
            cpf: '388.586.242-26',
            address: 'Rua Quatro',
            number: '8229',
            complement: '-', 
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '75674',
            role: 'admin',
            user: user
        )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.technologies.title')
        end
        
        # Assert
        expect(page).to have_link(I18n.t('views.technologies.new_title'))
    end

    scenario('access the form') do
        # Arrange 
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )

        Profile.create!(
            name: 'Graciliana Novaes',
            cpf: '388.586.242-26',
            address: 'Rua Quatro',
            number: '8229',
            complement: '-', 
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '75674',
            role: 'admin',
            user: user
        )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.technologies.title')
            click_on I18n.t('views.technologies.new_title')
        end
        
        # Assert
        expect(current_path).to eq(new_technology_path)
    end

    scenario('field is required') do
        # Arrange 
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )

        Profile.create!(
            name: 'Graciliana Novaes',
            cpf: '388.586.242-26',
            address: 'Rua Quatro',
            number: '8229',
            complement: '-', 
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '75674',
            role: 'admin',
            user: user
        )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.technologies.title')
            click_on I18n.t('views.technologies.new_title')
        end
        
        fill_in I18n.t('activerecord.attributes.technology.name'), with: ''
        click_on I18n.t('views.technologies.new_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'))
    end

    scenario('create with success') do
        # Arrange 
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )

        Profile.create!(
            name: 'Graciliana Novaes',
            cpf: '388.586.242-26',
            address: 'Rua Quatro',
            number: '8229',
            complement: '-', 
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '75674',
            role: 'admin',
            user: user
        )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.technologies.title')
            click_on I18n.t('views.technologies.new_title')
        end
        
        fill_in I18n.t('activerecord.attributes.technology.name'), with: ''
        click_on I18n.t('views.technologies.new_submit')

        fill_in I18n.t('activerecord.attributes.technology.name'), with: 'Ruby'
        click_on I18n.t('views.technologies.new_submit')

        technologies = Technology.last

        # Assert
        expect(page).to have_content(technologies.name)
    end
end


