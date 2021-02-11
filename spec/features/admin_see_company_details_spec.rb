require 'rails_helper'

# TODO: implement access from root_path
feature('Admin see company details') do

    scenario('there is a title') do
        # Arrange
        company = Company.create!(
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
        visit company_path(company)

        # Assert
        expect(page).to have_content(I18n.t('views.companies.detail_title'))
    end

    scenario('all fields are displayed') do
        # Arrange
        company = Company.create!(
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
        visit company_path(company)

        # Assert
        expect(page).to have_content(company.name)
        expect(page).to have_content(company.cnpj)
        expect(page).to have_content(company.address)
        expect(page).to have_content(company.number)
        expect(page).to have_content(company.complement)
        expect(page).to have_content(company.neighborhood)
        expect(page).to have_content(company.city)
        expect(page).to have_content(company.state)
        expect(page).to have_content(company.postal_code)
        expect(page).to have_content(company.website)
        expect(page).to have_content(company.founded)
    end

    scenario('it\'s possible to edit it') do
        # Arrange
        company = Company.create!(
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
        visit company_path(company)

        # Assert
        expect(page).to have_link(I18n.t('views.main.edit'))
    end

end