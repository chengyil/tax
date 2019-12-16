# Prerequisite
- docker version 19.03.4
- docker-compose version 1.24.0
- Linux environment

# Setup
```
* build image
```shell
cd tax
```
```
# docker-compose build
Building app
Step 1/7 : FROM ruby:2.5
 ---> db6a057a56d9
Step 2/7 : RUN mkdir -p /usr/src/tax/build
 ---> Using cache
 ---> 85917483d43f
Step 3/7 : COPY Gemfile Gemfile.lock /usr/src/tax/build/
 ---> Using cache
 ---> 8247965528e5
Step 4/7 : RUN cd /usr/src/tax/build && bundle install
 ---> Using cache
 ---> 0e3881dec6ec
Step 5/7 : WORKDIR /usr/src/tax
 ---> Using cache
 ---> eed0c862c9ae
Step 6/7 : VOLUME [.]
 ---> Using cache
 ---> a2e404cec255
Step 7/7 : CMD ["irb"]
 ---> Using cache
 ---> d6a5f9c89468
Successfully built d6a5f9c89468
Successfully tagged tax:latest
```

# Run Test
```shell
cd tax
bin/run_functional_tests
```
```
# bin/run_functional_tests
Creating network "taxation_default" with the default driver
cd /usr/src/tax/bin/../spec;bundle exec rake spec:functional
/usr/local/bin/ruby -I/usr/local/bundle/gems/rspec-core-3.9.0/lib:/usr/local/bundle/gems/rspec-support-3.9.0/lib /usr/local/bundle/gems/rspec-core-3.9.0/exe/rspec --pattern spec/\*\*\{,/\*/\*\*\}/\*_spec.rb
...Testing interactive input: 1
"Welcome to Individual Income Tax Calculator\n1. Calculate Individual Income\n2. Exit\nEnter options\nWhat is your monthly income?\n"
/What is your monthly income?/
6500000
"What is your marital status?\n1. Single\n2. Married\n"
/What is your marital status?/
2
"How many dependant do you have?\n"
/How many dependant do you have?/
1
"Total income : 78.000.000 IDR\nDependant Relief 63.000.000 IDR Married with 1 dependant\nAssessable income : 15.000.000 IDR\nTax Payable: 750.000 IDR, Tax on first 15.000.000 IDR\nPayable Tax : 750.000 IDR\nWelcome to Individual Income Tax Calculator\n1. Calculate Individual Income\n2. Exit\nEnter options\n"
"Total income : 78.000.000 IDR\nDependant Relief 63.000.000 IDR Married with 1 dependant\nAssessable income : 15.000.000 IDR\nTax Payable: 750.000 IDR, Tax on first 15.000.000 IDR\nPayable Tax : 750.000 IDR\n"
.Testing interactive input: 1
"Welcome to Individual Income Tax Calculator\n1. Calculate Individual Income\n2. Exit\nEnter options\nWhat is your monthly income?\n"
/What is your monthly income?/
25000000
"What is your marital status?\n1. Single\n2. Married\n"
/What is your marital status?/
1
"Total income : 300.000.000 IDR\nDependant Relief 54.000.000 IDR Single\nAssessable income : 246.000.000 IDR\nTax Payable: 2.500.000 IDR, Tax on first 50.000.000 IDR\nTax Payable: 29.400.000 IDR, Tax on next 196.000.000 IDR\nPayable Tax : 31.900.000 IDR\nWelcome to Individual Income Tax Calculator\n1. Calculate Individual Income\n2. Exit\nEnter options\n"
"Total income : 300.000.000 IDR\nDependant Relief 54.000.000 IDR Single\nAssessable income : 246.000.000 IDR\nTax Payable: 2.500.000 IDR, Tax on first 50.000.000 IDR\nTax Payable: 29.400.000 IDR, Tax on next 196.000.000 IDR\nPayable Tax : 31.900.000 IDR\n"
................................

Finished in 5.84 seconds (files took 0.24054 seconds to load)
36 examples, 0 failures
```

# Run App
```shell
cd tax
bin/app
```
```
# bin/app
Welcome to Individual Income Tax Calculator
1. Calculate Individual Income
2. Exit
Enter options
```
