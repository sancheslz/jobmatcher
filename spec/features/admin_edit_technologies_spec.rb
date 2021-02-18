require 'rails_helper'

feature('Admin edit technologies') do

    scenario('can edit a record') do
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

        technology = Technology.create!( name: 'Ruby' )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.technologies.title')
        end

        # Assert
        within("li#technology_#{technology.reload.id}") do
            expect(page).to have_link(I18n.t('views.main.edit'))
        end
    end

    scenario('see the form') do
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

        technology = Technology.create!( name: 'Ruby' )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.technologies.title')
        end

        within("li#technology_#{technology.reload.id}") do
            click_on I18n.t('views.main.edit')
        end

        # Assert
        expect(current_path).to eq(edit_technology_path(technologies))
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

        technology = Technology.create!( name: 'Ruby' )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.technologies.title')
        end

        within("li#technology_#{technology.reload.id}") do
            click_on I18n.t('views.main.edit')
        end

        fill_in I18n.t('activerecord.attributes.technology.name'), with: ''
        click_on I18n.t('views.technologies.edit_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'))
    end

    scenario('technology must be unique') do
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

        Technology.create!( name: 'Rails' )

        technology = Technology.create!( name: 'Ruby' )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.technologies.title')
        end

        within("li#technology_#{technology.reload.id}") do
            click_on I18n.t('views.main.edit')
        end

        fill_in I18n.t('activerecord.attributes.technology.name'), with: 'Rails'
        click_on I18n.t('views.technologies.edit_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.taken'))
    end

    scenario('edit with success') do
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

        technology = Technology.create!( name: 'Ruby' )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.technologies.title')
        end

        within("li#technology_#{technology.reload.id}") do
            click_on I18n.t('views.main.edit')
        end

        fill_in I18n.t('activerecord.attributes.technology.name'), with: 'Rails'
        click_on I18n.t('views.technologies.edit_submit')

        # Assert
        within("li#technology_#{technology.reload.id}") do
            expect(page).to have_content(technology.reload.name)
        end
    end
    
end