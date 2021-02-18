# Main Technologies
# ###################################################

technology_1 = Technology.create!( name: 'JavaScript' )

technology_2 = Technology.create!( name: 'Java' )

technology_3 = Technology.create!( name: 'Python' )

technology_4 = Technology.create!( name: 'PHP' )

technology_5 = Technology.create!( name: 'C#' )

technology_6 = Technology.create!( name: 'CSS' )

technology_7 = Technology.create!( name: 'Ruby' )

technology_8 = Technology.create!( name: 'C' )

technology_9 = Technology.create!( name: 'TypeScript' )

technology_10 = Technology.create!( name: 'SQL' )

technology_11 = Technology.create!( name: 'NoSQL' )

technology_12 = Technology.create!( name: 'Git' )

# Personas
# ###################################################

user_1 = User.create!(
    email: 'felismino.daconceicao@gmail.com',
    password: 'yellowtiger502'
)

user_2 = User.create!(
    email: 'graciliana.novaes@cdev.com',
    password: 'brownbird755'
)

user_3 = User.create!(
    email: 'miria.dasneves@cdev.com',
    password: 'smallwolf333'
)

user_4 = User.create!(
    email: 'linton.araujos@moemasoft.com',
    password: 'crazybutterfly906'
)

user_5 = User.create!(
    email: 'genoveva.cunha@salemo.com.br',
    password: 'smallwolf378'
)

profile_1 = Profile.create!(
    name: 'Felismino da Conceição',
    cpf: '175.113.263-01',
    address: 'Rua Treze de Maio',
    number: '7971',
    complement: 'C12', 
    city: 'Nossa Senhora do Socorro',
    state: 'Espírito Santo', 
    postal_code: '84373',
    role: 'regular',
    user: user_1
)
    
profile_2 = Profile.create!(
    name: 'Graciliana Novaes',
    cpf: '388.586.242-26',
    address: 'Rua Quatro',
    number: '8229',
    complement: '-', 
    city: 'Resende',
    state: 'Roraima', 
    postal_code: '75674',
    role: 'admin',
    user: user_2
)

profile_3 = Profile.create!(
    name: 'Miriã das Neves',
    cpf: '788.163.279-21',
    address: 'Rua Tiradentes',
    number: '7654',
    complement: 'Fundos', 
    city: 'Toledo',
    state: 'Maranhão', 
    postal_code: '27244',
    role: 'business',
    user: user_3
)

profile_4 = Profile.create!(
    name: 'Línton Araújo',
    cpf: '280.720.644-08',
    address: 'Rua Doze',
    number: '8',
    complement: 'Park',
    city: 'Caxias',
    state: 'Alagoas',
    postal_code: '88870',
    role: 'admin',
    user: user_4
)

profile_5 = Profile.create!(
    name: 'Genoveva da Cunha',
    cpf: '898.791.029-74',
    address: 'Rua Dois',
    number: '983',
    complement: 'Court',
    city: 'Mauá',
    state: 'Paraná',
    postal_code: '54368',
    role: 'admin',
    user: user_5
)

# Companies
# ###################################################

company_1 = Company.create!(
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

company_2 = Company.create!(
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

company_3 = Company.create!(
    name: 'Salemo\'s Tech',
    cnpj: '249.535.374/1713-25',
    address: 'Avenida Brasil',
    number: '98',
    complement: 'Court',
    city: 'Mauá',
    state: 'Paraná',
    postal_code: '54368',
    website: 'www.salemo.com.br',
    founded:'2009',
)

# Companies Members
# ###################################################

company_profile_1 = CompanyProfile.create!(
    profile: profile_2,
    company: company_1, 
)

company_profile_2 = CompanyProfile.create!(
    profile: profile_3,
    company: company_1, 
)

company_profile_3 = CompanyProfile.create!(
    profile: profile_4,
    company: company_2, 
)

company_profile_4 = CompanyProfile.create!(
    profile: profile_5,
    company: company_3, 
)

# Opportunities
# ###################################################

opportunity_1 = Opportunity.create!(
    title: "Desenvolvedor(a) Front End",
    description: %{Você será responsável por desenvolver interfaces web a partir de especificações realizadas pelo time de design primariamente utilizando ReactJs mas também atendendo demandas de desenvolvimento e manutenção em sistemas desenvolvidos com React Native.},
    requirement: %{Grande conhecimento em desenvolvimento ReactJs | Habilidade para desenvolver em Typescript | Experiência em desenvolvimento React Native | Capacidade de escrever código limpo e bem documentado | Conhecimento em Hooks, TDD, Clean Architecture, SOLID},
    position_quantity: 1,
    expiration_date: 30.days.from_now,
    salary: 8000,
    remote: true,
    level: :mid,
    company: company_1,
    is_visible: true,
)

opportunity_2 = Opportunity.create!(
    title: "Programador(a) PHP",
    description: %{Desenvolvimento e manutenção de aplicações web | Realizar a manutenção e criação de novas funcionalidades | Desenvolvimento de funcionalidades no Back-End | Aplicar melhores práticas de documentação de código desenvolvido},
    requirement: %{Formação em ensino superior ou técnico | Experiência prévia nas linguagens informadas | Habilidades interpessoais de escrita e de comunicação verbal},
    position_quantity: 2,
    expiration_date: 30.days.from_now,
    salary: 2000,
    remote: false,
    level: :entry,
    company: company_2,
    is_visible: true,
)

opportunity_3 = Opportunity.create!(
    title: "Desenvolvedor(a) Java",
    description: %{Manutenção e criação de novas funcionalidades | Aplicação das melhores práticas de documentação de código desenvolvidas | Busca por novas ferramentas e técnicas para a melhoria contínua de nossos sistemas.},
    requirement: %{2 anos ou mais de experiência em desenvolvimento de sistemas web | Gradução completa em TI | Conhecimento em desenvolvimento JAVA e webservices | Conhecimento em servidor Tomcat | Conhecimento em sistema operacional Linux | Conhecimento em banco de dados MySQL | Conhecimento na ferramenta Git.},
    position_quantity: 1,
    expiration_date: 60.days.from_now,
    salary: 6000,
    remote: false,
    level: :mid,
    company: company_3,
    is_visible: true,
)

opportunity_4 = Opportunity.create!(
    title: "Desenvolvedor(a) Full Stack",
    description: %{Buscamos um profissional para trabalhar basicamente desenvolvendo aplicações, APIs e integrações que rodam no back-end, mas precisa ser alguém que se vire minimamente no front-end. | Desenvolvimento e manutenção de aplicações web | Desenvolvimento de funcionalidades no Back-End | Realizar a manutenção e criação de novas funcionalidades | Buscar novas ferramentas e técnicas para a melhoria contínua de nossos sistemas},
    requirement: %{Este profissional precisa ter experiencia de pelo menos 2 anos com as seguintes linguagens / frameworks: NodeJS & NPM, Banco de Dados SQL e NoSQL, HTML5, CSS3, Javascript DOM, Javascript ES6+, Git, PHP},
    position_quantity: 5,
    expiration_date: 30.days.from_now,
    salary: 4000,
    remote: true,
    level: :mid,
    company: company_2,
    is_visible: false,
)

opportunity_5 = Opportunity.create!(
    title: "Desenvolvedor(a) Front-end Sênior",
    description: %{A Vaga é para desenvolvedor Sênior, porém estamos contratando para todos os níveis. Havendo sinergia com as informações abaixo, sinta-se a vontade para entrar em contato. >> Desenvolvimento de aplicações web | Integrações entre sistemas. >> Diferenciais: Experiência com desenvolvimento no mercado de capitaisl; Experiência com desenvolvimento no mercado agro; Conhecimento em Flutter},
    requirement: %{Mínimo de 5 anos de experiência com desenvolvimento de aplicações web | Conhecimentos sólidos em Estruturas de Dados e APIs | Orientação a objetos e atenção plena a qualidade de código | Boa comunicação e capacidade para trabalhar em equipe para assimilar problemas e discutir soluções | REST | SCRUM | VUEJS},
    position_quantity: 1,
    expiration_date: 30.days.from_now,
    salary: 12000,
    remote: true,
    level: :senior,
    company: company_1,
    is_visible: false,
)

opportunity_6 = Opportunity.create!(
    title: "Desenvolvedor(a) Full Stack Ruby on Rails Sênior",
    description: %{Elaborar, analisar e entender as especificações técnicas dos sistema | Organizar a documentação dos programas criados ou modificados | Validar os requisitos do software ao longo do seu desenvolvimento | Criar e executar os procedimentos para configuração, migração ou implantação de sistemas | Garantir segurança e proteção dos dados das soluções | Depurar e compilar programas | Criar as estruturas e rotinas para bancos de dados},
    requirement: %{Para dominar nossos desafios, você precisará de habilidades em: Lógica de programação, algoritmos, modelagem e estrutura de dados, ruby, ruby on rails, react, vue, jquery, aws, postgres. | Nível Superior concluído nos cursos de Engenharia, TI ou correlatos | Inglês (mínimo intermediário, desejável avançado) | Organização (planejamento) | Foco em ação | Gestão de tempo e prioridades | Vontade de aprender | Capacidade de lidar com pressão | Capacidade de lidar com conflitos | Capacidade de negociação | Liderança},
    position_quantity: 1,
    expiration_date: 30.days.from_now,
    salary: 10000,
    remote: true,
    level: :senior,
    company: company_3,
    is_visible: true,
)

opportunity_7 = Opportunity.create!(
    title: "Programador(a) Web Front End Pleno",
    description: %{Desenvolver melhorias e novas funcionalidades},
    requirement: %{Experiência com ferramentas de versionamento de código (GIT,...) | Experiência prévia nas linguagens informadas},
    position_quantity: 1,
    expiration_date: 30.days.from_now,
    salary: 5000,
    remote: true,
    level: :mid,
    company: company_1,
    is_visible: true,
)

opportunity_8 = Opportunity.create!(
    title: "Senior Full Stack Developer - JavaScript / Ruby on Rails / Python",
    description: %{We are looking for someone with strong problem-solving skills and self-management skills | Most of our projects are in JavaScript / RoR / Python, but we're also looking for people willing to learn new technologies and work with different stacks},
    requirement: %{STACK (one of): JavaScript / Node.js / React, Ruby on Rails, Python, Go. || ABOUT YOU: Experience in Full Stack Development, Real agile experience, Growth mindset, Willingness to learn our systems, Full-time availability, Demonstrated ability to work independently/autonomously, Ability to communicate effectively and work exclusively in English. (This is a must). || BONUS POINTS FOR: TypeScript, React Native / Ionic, Swift, Angular, Python, Clean Code, Unit Tests, Experience managing clients and client relationships is a big plus},
    position_quantity: 1,
    expiration_date: 20.days.from_now,
    salary: 18000,
    remote: true,
    level: :senior,
    company: company_1,
    is_visible: false,
)

# Technology Opportunities
TechnologyOpportunity.create!(
    technology: technology_1,
    opportunity: opportunity_1
)

TechnologyOpportunity.create!(
    technology: technology_9,
    opportunity: opportunity_1
)

TechnologyOpportunity.create!(
    technology: technology_4,
    opportunity: opportunity_2
)

TechnologyOpportunity.create!(
    technology: technology_10,
    opportunity: opportunity_2
)

TechnologyOpportunity.create!(
    technology: technology_2,
    opportunity: opportunity_3
)

TechnologyOpportunity.create!(
    technology: technology_10,
    opportunity: opportunity_3
)

TechnologyOpportunity.create!(
    technology: technology_12,
    opportunity: opportunity_3
)

TechnologyOpportunity.create!(
    technology: technology_1,
    opportunity: opportunity_4
)

TechnologyOpportunity.create!(
    technology: technology_4,
    opportunity: opportunity_4
)

TechnologyOpportunity.create!(
    technology: technology_11,
    opportunity: opportunity_4
)

TechnologyOpportunity.create!(
    technology: technology_12,
    opportunity: opportunity_4
)

TechnologyOpportunity.create!(
    technology: technology_1,
    opportunity: opportunity_5
)

TechnologyOpportunity.create!(
    technology: technology_6,
    opportunity: opportunity_5
)

TechnologyOpportunity.create!(
    technology: technology_9,
    opportunity: opportunity_5
)

TechnologyOpportunity.create!(
    technology: technology_10,
    opportunity: opportunity_5
)

TechnologyOpportunity.create!(
    technology: technology_11,
    opportunity: opportunity_5
)

TechnologyOpportunity.create!(
    technology: technology_1,
    opportunity: opportunity_6
)

TechnologyOpportunity.create!(
    technology: technology_7,
    opportunity: opportunity_6
)

TechnologyOpportunity.create!(
    technology: technology_10,
    opportunity: opportunity_6
)

TechnologyOpportunity.create!(
    technology: technology_12,
    opportunity: opportunity_7
)

TechnologyOpportunity.create!(
    technology: technology_3,
    opportunity: opportunity_7
)

TechnologyOpportunity.create!(
    technology: technology_4,
    opportunity: opportunity_7
)

TechnologyOpportunity.create!(
    technology: technology_7,
    opportunity: opportunity_7
)

TechnologyOpportunity.create!(
    technology: technology_9,
    opportunity: opportunity_7
)

TechnologyOpportunity.create!(
    technology: technology_1,
    opportunity: opportunity_8
)
TechnologyOpportunity.create!(
    technology: technology_3,
    opportunity: opportunity_8
)
TechnologyOpportunity.create!(
    technology: technology_7,
    opportunity: opportunity_8
)
TechnologyOpportunity.create!(
    technology: technology_9,
    opportunity: opportunity_8
)