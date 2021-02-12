require 'rails_helper'

# TODO: add access from home page
feature('Admin create a technologies') do
    scenario('see the form') do
        # Arrange 

        # Act
        visit technologies_path

        # Assert
        expect(page).to have_field(I18n.t('activerecord.attributes.technology.name'))
        expect(page).to have_button(I18n.t('views.technologies.new_submit'))
    end
    scenario('field is required') do
        # Arrange 

        # Act
        visit technologies_path
        fill_in I18n.t('activerecord.attributes.technology.name'), with: ''
        click_on I18n.t('views.technologies.new_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'))
    end
    scenario('with success') do
        # Arrange 

        # Act
        visit technologies_path
        fill_in I18n.t('activerecord.attributes.technology.name'), with: 'Ruby'
        click_on I18n.t('views.technologies.new_submit')

        technologies = Technology.last

        # Assert
        expect(page).to have_content(technologies.name)
    end
end

feature('Admin see a technologies') do

    scenario('any records') do
        # Arrange

        # Act
        visit technologies_path

        # Assert
        expect(page).to have_content(I18n.t('views.technologies.empty'))
    end

    scenario('see records') do
        # Arrange
        technologies = Technology.create!(
            name: 'Ruby'
        )
        # Act
        visit technologies_path

        # Assert
        expect(page).to have_content(I18n.t('views.technologies.title'))
        expect(page).to have_content(technologies.name)
    end

end

feature('Admin edit a technologies') do

    scenario('can edit a record') do
        # Arrange
        technologies = Technology.create!(
            name: 'Ruby'
        )

        # Act
        visit technologies_path

        # Assert
        expect(page).to have_link(I18n.t('views.main.edit'))
    end

    scenario('see the form') do
        # Arrange
        technologies = Technology.create!(
            name: 'Ruby'
        )

        # Act
        visit technologies_path
        click_on I18n.t('views.main.edit')

        # Assert
        expect(current_path).to eq(edit_technology_path(technologies))
    end

    scenario('field is required') do
        # Arrange
        technologies = Technology.create!(
            name: 'Ruby'
        )

        # Act
        visit technologies_path
        click_on I18n.t('views.main.edit')
        fill_in I18n.t('activerecord.attributes.technology.name'), with: ''
        click_on I18n.t('views.technologies.edit_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'))
    end

    scenario('edit with success') do
        # Arrange
        technologies = Technology.create!(
            name: 'Ruby'
        )

        # Act
        visit technologies_path
        click_on I18n.t('views.main.edit')
        fill_in I18n.t('activerecord.attributes.technology.name'), with: 'Ruby on Rails'
        click_on I18n.t('views.technologies.edit_submit')

        technologies.reload

        # Assert
        expect(page).to have_content(technologies.name)
    end
    
end