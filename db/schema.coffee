define 'User', ->
    property 'email', String, index: true
    property 'password', String
    property 'activated', Boolean, default: false

Game = describe 'Game', () ->
    property 'title', String
    property 'away', String
    property 'home', String
    property 'home_score', Number
    property 'away_score', Number
