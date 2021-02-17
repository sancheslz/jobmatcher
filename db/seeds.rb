# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Company.create!(
    name: 'Campus Code',
    cnpj: '1233456',
    address: 'Alameda Santos',
    number: '1293',
    complement: 'Conj 73',
    neighborhood: 'Jardim Paulista',
    city: 'São Paulo',
    state: 'SP',
    postal_code: '11345-111',
    website: 'www.campuscode.com',
    founded:  '2010',
)

Technology.create!(
    name: 'Rails'
)

Technology.create!(
    name: 'Ruby'
)

Technology.create!(
    name: 'Git'
)


Opportunity.create!(
    title: 'Desenvolvedor Rails',
    description: 'Deverá desenvolver aplicações Rails com entrega e consumo de api',
    requirement: 'Conhecimento em ruby e rails. Desejável conhecimento em React',
    expiration_date: 30.days.from_now,
    position_quantity: 1,
    salary: 2500.00,
    remote: :true,
    level: :entry,
)

user = User.create!(
    email: 'regular@gmail.com',
    password: 'regular1234'
)

Profile.create!(
    name: 'Regular User',
    cpf: '1234',
    user: user
)