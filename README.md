# Linter Capstone Project (Javascript Linter)

Is a basic javascript linter but can be extended really easy
creating module in the **/lintermodules** folder.

---

## Built With

- Ruby

## Getting Started

### Prerequisites

- Ruby version ~> 2.6
- IDE (if you want to test)

### Dependencies

- gem 'colorize', '~> 0.8.1'
- gem 'tty-font', '~> 0.5.0'
- gem 'tty-progressbar', '~> 0.17.0'

### Install

`bundle install`

### Run tests

Rubocop lint
`rubocop .`

### How to use

- From the root folder of the project run this commands
- `./bin/jslint.rb init` - will create a configuration file `jslint.yml`
- `./bin/jslint.rb all` - will search for all the `js` files in the project and start the process of checking the files for errors
- `./bin/jslint.rb path/to/the/file` - will trigger checking only for that file

- You can create new `js` files with your own code but there is already a test file in the **/test-files** folder and you can play with that
  trying to change something to see the errors.

- After the `init` command you can check all the linter rules in the `jslint.yml` file with the default values.

### Linter rules

- Checking if class name is capitalized
- Checking indentation
- Checking the length of the rows
- Checking if a variable is declared and never used

### Documentation for creating new rules

- If you want to add more functionality to the linter is very easy follow this steps
- First create a file with the desired name inside the **/lintermodules** folder.
- Open the file and write something like:
- `module Loader`
- `class NameOfTheClass < ModuleSpec`
- //Here you will declare a `check` method
- //You can always check one of the already created class
- //Do your logic in here and return true or false
- `end`
- `end`
- The last thing just add the name of the class in the `jslint.yml` file
- The rest is done automatic

## Authors

👤 **Marian Cristu**

- Github: [mariancristu](https://github.com/mariancristu)
- Twitter: [@mariancristu](https://twitter.com/)
- Linkedin: [linkedin](www.linkedin.com/in/mariancristu)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is [MIT](lic.url) licensed.
