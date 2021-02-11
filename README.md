# JobMatcher

A project developed during the 5th class of TreinaDev program.

![Badge](https://img.shields.io/static/v1?label=Ruby&message=2.7.1&color=CC342D&style=flat&logo=ruby)
![Badge](https://img.shields.io/static/v1?label=Rails&message=6.0.3&color=CC0000&style=flat&logo=rubyonrails)
![Badge](https://img.shields.io/static/v1?label=SQLite3&message=1.4&color=003B57&style=flat&logo=sqlite)
![Badge](https://img.shields.io/static/v1?label=Bootstrap&message=4.0.0&color=7952B3&style=flat&logo=bootstrap)
![Badge](https://img.shields.io/static/v1?label=RSpec&message=4.0.2&color=E9573F&style=flat&logo=rubygems)
![Badge](https://img.shields.io/static/v1?label=Capybara&message=3.35&color=E9573F&style=flat&logo=rubygems)
![Badge](https://img.shields.io/static/v1?label=Devise&message=4.7.3&color=E9573F&style=flat&logo=rubygems)

## Description

The project consists of a Job Offer system where companies can register new opportunities and candidates can apply to them. The system allows free registration for both. Candidates can manage their profiles and apply for any job position. The company's employees can create new opportunities and manage the candidate's submission. Internal screens are only accessible to registered users.

## Requirements

- Ruby 2.7.1
- Rails 6.0.3

### About the gems

The project uses some gems to ensure its quality and functionality, here is a shortlist of the main gems used and their reasons:

- *Rails-RSpec* : the main Rails test suite, used to create unit tests. It works creating a test database, running tests, making asserts and destroying the test database at the end.
- *Capybara* : allows creating functional/acceptance tests, emulating the browser behavior. Tests created with this gem act as a user operating the system. 
- *Devise* : the main access control gem of Rails. Allows things like user registration and session authentication.

## Getting Stared

### How to Install

Clone the repository:

```cmd
git clone https://github.com/sancheslz/jobmatcher.git
```

Open the project directory on Terminal

```bash
cd  jobmatcher
```

Install all gems using Bundle on Terminal

```bash
bundle install
```

### How to Create Databases

To create your local database, open the project directory and run on Terminal:

```bash
rails db:migrate
```

### How to Run local server

To run a local server, open the project directory on Terminal and type:

```bash
rails server
```

### How to Run Tests

To run all tests, open the project directory on Terminal and type:

```bash
rspec 
```

It's also possible to test a group of tests, like `features` or `models`, using:

```bash
rspec spec/features
```

To run an specif test, use the following, changing `<testname>` for the test file name

```bash
rspec spec/features/<testname>
```

To run an specif line of code, use the following, adding the line where the test starts

```bash
rspec spec/features/<testname>:<linenumber>
```

---

## Status

This project is in development. You can access its evolution on [Trello](https://trello.com/b/2wIVzkaE/jobmatcher) website.

## Routes

Verb | Path                     | URL
---  | ---                      | ---
get  | `root`                   | `/`
