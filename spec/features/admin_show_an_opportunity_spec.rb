require 'rails_helper'

feature('Admin hide a job opportunity') do
    
    scenario('access company\'s  opportunities') do
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
    
        opportunity = Opportunity.create!(
            title: "Desenvolvedor(a) Front End",
            description: %{Você será responsável por desenvolver interfaces web a partir de especificações realizadas pelo time de design primariamente utilizando ReactJs mas também atendendo demandas de desenvolvimento e manutenção em sistemas desenvolvidos com React Native.},
            requirement: %{Grande conhecimento em desenvolvimento ReactJs | Habilidade para desenvolver em Typescript | Experiência em desenvolvimento React Native | Capacidade de escrever código limpo e bem documentado | Conhecimento em Hooks, TDD, Clean Architecture, SOLID},
            position_quantity: 1,
            expiration_date: 30.days.from_now,
            salary: 8000,
            remote: true,
            level: :mid,
            company: company,
            is_visible: false,
        )

        CompanyProfile.create!( profile: profile, company: company )

        login_as user 

        # Act
        visit root_path 
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end

        # Assert
        expect(page).to have_content(opportunity.title)

    end

    scenario('can see only own opportunities') do
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
    
        opportunity = Opportunity.create!(
            title: "Desenvolvedor(a) Front End",
            description: %{Você será responsável por desenvolver interfaces web a partir de especificações realizadas pelo time de design primariamente utilizando ReactJs mas também atendendo demandas de desenvolvimento e manutenção em sistemas desenvolvidos com React Native.},
            requirement: %{Grande conhecimento em desenvolvimento ReactJs | Habilidade para desenvolver em Typescript | Experiência em desenvolvimento React Native | Capacidade de escrever código limpo e bem documentado | Conhecimento em Hooks, TDD, Clean Architecture, SOLID},
            position_quantity: 1,
            expiration_date: 30.days.from_now,
            salary: 8000,
            remote: true,
            level: :mid,
            company: company,
            is_visible: false,
        )

        other_company = Company.create!(
            name: 'MoemaSoft',
            cnpj: '815.916.474/1594-96',
            address: 'Rua São Sebastiao',
            number: '8',
            complement: 'Park',
            city: 'Caxias',
            state: 'Alagoas',
            postal_code: '56170',
            website: 'www.moemasoft.com',
            founded:'1983',
        )

        other_opportunity = Opportunity.create!(
            title: "Programador(a) PHP",
            description: %{Desenvolvimento e manutenção de aplicações web | Realizar a manutenção e criação de novas funcionalidades | Desenvolvimento de funcionalidades no Back-End | Aplicar melhores práticas de documentação de código desenvolvido},
            requirement: %{Formação em ensino superior ou técnico | Experiência prévia nas linguagens informadas | Habilidades interpessoais de escrita e de comunicação verbal},
            position_quantity: 2,
            expiration_date: 30.days.from_now,
            salary: 2000,
            remote: false,
            level: :entry,
            company: other_company,
            is_visible: false,
        )

        CompanyProfile.create!( profile: profile, company: company )

        login_as user 

        # Act
        visit root_path 
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end

        # Assert
        expect(page).to have_content(opportunity.title)
        expect(page).not_to have_content(other_opportunity.title)
    end 

    scenario('active are have danger border') do
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
    
        active_opportunity = Opportunity.create!(
            title: "Desenvolvedor(a) Front End",
            description: %{Você será responsável por desenvolver interfaces web a partir de especificações realizadas pelo time de design primariamente utilizando ReactJs mas também atendendo demandas de desenvolvimento e manutenção em sistemas desenvolvidos com React Native.},
            requirement: %{Grande conhecimento em desenvolvimento ReactJs | Habilidade para desenvolver em Typescript | Experiência em desenvolvimento React Native | Capacidade de escrever código limpo e bem documentado | Conhecimento em Hooks, TDD, Clean Architecture, SOLID},
            position_quantity: 1,
            expiration_date: 30.days.from_now,
            salary: 8000,
            remote: true,
            level: :mid,
            company: company,
            is_visible: true,
        )

        inactive_opportunity = Opportunity.create!(
            title: "Desenvolvedor(a) Front-end Sênior",
            description: %{A Vaga é para desenvolvedor Sênior, porém estamos contratando para todos os níveis. Havendo sinergia com as informações abaixo, sinta-se a vontade para entrar em contato. >> Desenvolvimento de aplicações web | Integrações entre sistemas. >> Diferenciais: Experiência com desenvolvimento no mercado de capitaisl; Experiência com desenvolvimento no mercado agro; Conhecimento em Flutter},
            requirement: %{Mínimo de 5 anos de experiência com desenvolvimento de aplicações web | Conhecimentos sólidos em Estruturas de Dados e APIs | Orientação a objetos e atenção plena a qualidade de código | Boa comunicação e capacidade para trabalhar em equipe para assimilar problemas e discutir soluções | REST | SCRUM | VUEJS},
            position_quantity: 1,
            expiration_date: 30.days.from_now,
            salary: 12000,
            remote: true,
            level: :senior,
            company: company,
            is_visible: false,
        )

        CompanyProfile.create!( profile: profile, company: company )

        login_as user 

        # Act
        visit root_path 
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end

        # Assert
        within('div.card-body.border-light') do
            expect(page).to have_content(active_opportunity.title) 
        end
        within('div.card-body.border-danger') do 
            expect(page).to have_content(inactive_opportunity.title) 
        end
    end 

    scenario('can show') do
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
    
        opportunity = Opportunity.create!(
            title: "Desenvolvedor(a) Front End",
            description: %{Você será responsável por desenvolver interfaces web a partir de especificações realizadas pelo time de design primariamente utilizando ReactJs mas também atendendo demandas de desenvolvimento e manutenção em sistemas desenvolvidos com React Native.},
            requirement: %{Grande conhecimento em desenvolvimento ReactJs | Habilidade para desenvolver em Typescript | Experiência em desenvolvimento React Native | Capacidade de escrever código limpo e bem documentado | Conhecimento em Hooks, TDD, Clean Architecture, SOLID},
            position_quantity: 1,
            expiration_date: 30.days.from_now,
            salary: 8000,
            remote: true,
            level: :mid,
            company: company,
            is_visible: false,
        )

        CompanyProfile.create!( profile: profile, company: company )

        login_as user 

        # Act
        visit root_path 
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end
        
        # Assert
        within("div#opportunity_#{opportunity.reload.id}") do
            expect(page).to have_link(I18n.t('views.opportunities.show'))
        end
    end 

    scenario('show with success') do
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
    
        opportunity = Opportunity.create!(
            title: "Desenvolvedor(a) Front End",
            description: %{Você será responsável por desenvolver interfaces web a partir de especificações realizadas pelo time de design primariamente utilizando ReactJs mas também atendendo demandas de desenvolvimento e manutenção em sistemas desenvolvidos com React Native.},
            requirement: %{Grande conhecimento em desenvolvimento ReactJs | Habilidade para desenvolver em Typescript | Experiência em desenvolvimento React Native | Capacidade de escrever código limpo e bem documentado | Conhecimento em Hooks, TDD, Clean Architecture, SOLID},
            position_quantity: 1,
            expiration_date: 30.days.from_now,
            salary: 8000,
            remote: true,
            level: :mid,
            company: company,
            is_visible: false,
        )

        CompanyProfile.create!( profile: profile, company: company )

        login_as user 

        # Act
        visit root_path 
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end

        within("div#opportunity_#{opportunity.reload.id}") do
            click_on I18n.t('views.opportunities.show')
        end

        # Assert
        within('div.card-body.border-light') do
            expect(page).to have_content(opportunity.title)
        end
    end 

end