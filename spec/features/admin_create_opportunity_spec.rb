require 'rails_helper'

feature('Admin create opportunity') do

    scenario('see the option on home page') do
        # Arrange 
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )

        profile = Profile.create!(
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

        company = Company.create!(
            name: 'Continuous Development',
            cnpj: '832.538.794/9328-87',
            address: 'Rio Grande do Sul',
            number: '347',
            complement: 'Center',
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '85390',
            website: 'www.cdev.com',
            founded:'2009',
        )

        technology_1 = Technology.create!( name: 'JavaScript' )
        technology_2 = Technology.create!( name: 'TypeScript' )

        login_as user

        # Act
        visit root_path

        # Assert
        within('div.jumbotron') do
            expect(page).to have_content(I18n.t('views.opportunities.new_title'))
        end
    end

    scenario('see the form') do
        # Arrange 
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )

        profile = Profile.create!(
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

        company = Company.create!(
            name: 'Continuous Development',
            cnpj: '832.538.794/9328-87',
            address: 'Rio Grande do Sul',
            number: '347',
            complement: 'Center',
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '85390',
            website: 'www.cdev.com',
            founded:'2009',
        )

        technology_1 = Technology.create!( name: 'JavaScript' )
        technology_2 = Technology.create!( name: 'TypeScript' )

        login_as user

        # Act
        visit root_path
        within('div.jumbotron') do
            click_on I18n.t('views.opportunities.new_title')
        end

        # Assert
        expect(current_path).to eq(new_opportunity_path) 
    end

    scenario('see all fields') do
        # Arrange 
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )

        profile = Profile.create!(
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

        company = Company.create!(
            name: 'Continuous Development',
            cnpj: '832.538.794/9328-87',
            address: 'Rio Grande do Sul',
            number: '347',
            complement: 'Center',
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '85390',
            website: 'www.cdev.com',
            founded:'2009',
        )

        technology_1 = Technology.create!( name: 'JavaScript' )
        technology_2 = Technology.create!( name: 'TypeScript' )

        login_as user

        # Act
        visit root_path
        within('div.jumbotron') do
            click_on I18n.t('views.opportunities.new_title')
        end

        # Assert
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.title'))
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.description'))
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.requirement'))
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.expiration_date'))
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.position_quantity'))
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.salary'))
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.remote'))
        expect(page).to have_field(I18n.t('activerecord.attributes.opportunity.level'))
    end

    scenario('required can\'t be blank') do
        # Arrange 
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )

        profile = Profile.create!(
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

        company = Company.create!(
            name: 'Continuous Development',
            cnpj: '832.538.794/9328-87',
            address: 'Rio Grande do Sul',
            number: '347',
            complement: 'Center',
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '85390',
            website: 'www.cdev.com',
            founded:'2009',
        )

        technology_1 = Technology.create!( name: 'JavaScript' )
        technology_2 = Technology.create!( name: 'TypeScript' )

        login_as user

        # Act
        visit root_path
        within('div.jumbotron') do
            click_on I18n.t('views.opportunities.new_title')
        end
        # Act

        fill_in I18n.t('activerecord.attributes.opportunity.title'), with: ''
        fill_in I18n.t('activerecord.attributes.opportunity.description'), with: ''
        fill_in I18n.t('activerecord.attributes.opportunity.requirement'), with: ''
        click_on I18n.t('views.opportunities.new_submit')
        
        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'), count: 3)
    end

    scenario('create with success') do
        # Arrange 
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )

        profile = Profile.create!(
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

        company = Company.create!(
            name: 'Continuous Development',
            cnpj: '832.538.794/9328-87',
            address: 'Rio Grande do Sul',
            number: '347',
            complement: 'Center',
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '85390',
            website: 'www.cdev.com',
            founded:'2009',
        )

        technology_1 = Technology.create!( name: 'JavaScript' )
        technology_2 = Technology.create!( name: 'TypeScript' )

        login_as user

        # Act
        visit root_path
        within('div.jumbotron') do
            click_on I18n.t('views.opportunities.new_title')
        end
        # Act

        fill_in I18n.t('activerecord.attributes.opportunity.title'), with: 'Desenvolvedor(a) Front End'
        fill_in I18n.t('activerecord.attributes.opportunity.description'), with: %{Você será responsável por desenvolver interfaces web a partir de especificações realizadas pelo time de design primariamente utilizando ReactJs mas também atendendo demandas de desenvolvimento e manutenção em sistemas desenvolvidos com React Native.}
        fill_in I18n.t('activerecord.attributes.opportunity.requirement'), with: %{Grande conhecimento em desenvolvimento ReactJs | Habilidade para desenvolver em Typescript | Experiência em desenvolvimento React Native | Capacidade de escrever código limpo e bem documentado | Conhecimento em Hooks, TDD, Clean Architecture, SOLID}
        fill_in I18n.t('activerecord.attributes.opportunity.expiration_date'), with: 30.days.from_now.strftime('%d/%m/%Y')
        fill_in I18n.t('activerecord.attributes.opportunity.position_quantity'), with: 1
        fill_in I18n.t('activerecord.attributes.opportunity.salary'), with: '8000,00'
        select I18n.t('views.opportunities.level_entry'), from: I18n.t('activerecord.attributes.opportunity.level')
        select I18n.t('views.opportunities.remote_yes'), from: I18n.t('activerecord.attributes.opportunity.remote')
        check technology_1
        check technology_2
        click_on I18n.t('views.opportunities.new_submit')

        # Assert
        opportunity = Opportunity.last
        expect(current_path).to eq(opportunity_path(opportunity))
    end

end