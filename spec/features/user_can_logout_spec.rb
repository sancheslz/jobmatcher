require 'rails_helper'

feature('User can logout') do

    context "with profile" do
        
            scenario('see the menu') do
                # Arrange
                user = User.create!(
                    email: 'felismino.daconceicao@gmail.com',
                    password: 'yellowtiger502'
                )

                Profile.create!(
                    name: 'Felismino da Conceição',
                    cpf: '175.113.263-01',
                    address: 'Rua Treze de Maio',
                    number: '7971',
                    complement: 'C12', 
                    city: 'Nossa Senhora do Socorro',
                    state: 'Espírito Santo', 
                    postal_code: '84373',
                    role: 'regular',
                    user: user
                )

                # Act
                login_as user 
                visit root_path 

                # Assert
                within('nav') do
                    expect(page).to have_link('Menu')
                end
            end
        
            scenario('see the button') do
                # Arrange
                user = User.create!(
                    email: 'felismino.daconceicao@gmail.com',
                    password: 'yellowtiger502'
                )

                Profile.create!(
                    name: 'Felismino da Conceição',
                    cpf: '175.113.263-01',
                    address: 'Rua Treze de Maio',
                    number: '7971',
                    complement: 'C12', 
                    city: 'Nossa Senhora do Socorro',
                    state: 'Espírito Santo', 
                    postal_code: '84373',
                    role: 'regular',
                    user: user
                )

                # Act
                login_as user 
                visit root_path 
                within('nav') do
                    click_on 'Menu'
                end

                # Assert
                within('nav') do
                    expect(page).to have_link(I18n.t('views.home.logout'))
                end
            end
        
            scenario('with success') do
                # Arrange
                user = User.create!(
                    email: 'felismino.daconceicao@gmail.com',
                    password: 'yellowtiger502'
                )

                Profile.create!(
                    name: 'Felismino da Conceição',
                    cpf: '175.113.263-01',
                    address: 'Rua Treze de Maio',
                    number: '7971',
                    complement: 'C12', 
                    city: 'Nossa Senhora do Socorro',
                    state: 'Espírito Santo', 
                    postal_code: '84373',
                    role: 'regular',
                    user: user
                )

                # Act
                login_as user 
                visit root_path 
                within('nav') do
                    click_on 'Menu'
                    click_on I18n.t('views.home.logout')
                end

                # Assert
                within('nav') do
                    expect(page).to have_link(I18n.t('views.home.sign_in'))
                end
                expect(current_path).to eq(root_path)
            end
    end

    context "without a profile" do
        
            scenario('see the button') do
                # Arrange
                user = User.create!(
                    email: 'felismino.daconceicao@gmail.com',
                    password: 'yellowtiger502'
                )

                # Act
                login_as user 
                visit root_path 

                # Assert
                within('nav') do
                    expect(page).to have_link(I18n.t('views.home.logout'))
                end
            end
        
            scenario('with success') do
                # Arrange
                user = User.create!(
                    email: 'felismino.daconceicao@gmail.com',
                    password: 'yellowtiger502'
                )

                # Act
                login_as user 
                visit root_path 
                within('nav') do
                    click_on I18n.t('views.home.logout')
                end

                # Assert
                within('nav') do
                    expect(page).to have_link(I18n.t('views.home.sign_in'))
                end
                expect(current_path).to eq(root_path)
            end
    end
    
end