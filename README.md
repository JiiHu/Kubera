# Kubera

Ruby on rails application to manage your income and outcome. Named after the Lord of Wealth in Hindu mythology.

[![Build Status](https://travis-ci.org/JiiHu/Kubera.png)](https://travis-ci.org/JiiHu/Kubera)
[![Code Climate](https://codeclimate.com/github/JiiHu/Kubera.png)](https://codeclimate.com/github/JiiHu/Kubera)
[![Test Coverage](https://codeclimate.com/github/JiiHu/Kubera/badges/coverage.svg)](https://codeclimate.com/github/JiiHu/Kubera)

## What?
Mark all your income and outcome to this app by the category they belong to (food, gasoline etc.). You will be able to see what categories eat all your money.

## Where
[Hosted at Heroku](http://kubera-app.herokuapp.com/)

## How to use?
- Create account
- Log in
- Create some categories
- Mark all your income and outcome as entries
- See where your money goes

## Data model
[Avalaible at nomnoml](http://www.nomnoml.com/#view/%0A[Category|%0Aname:%20String;%0Aincome:%20boolean]%0A%0A[User|%0Ausername:%20String;%0Apassword:%20String]%0A%0A[Entry|%0Aamount:%20integer;%0Adate:%20Date]%0A%0A%0A[Category]-%3E[Entry]%0A[User]-%3E[Category]%0A[User]-%3E[Entry])

## Tests
All Controllers and Models are tested