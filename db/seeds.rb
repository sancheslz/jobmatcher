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

Technology.create!(name: 'Rails')
Technology.create!(name: 'Ruby')
Technology.create!(name: 'Git')