#!/usr/bin/env coffee

app = module.exports = require('railway').createServer()

sio = require 'socket.io'
io = sio.listen(app)

io.sockets.on 'connection',  (socket) ->
  socket.emit 'news', { hello: 'world' }
  socket.on 'message', (data) ->
    console.log data
    socket.emit 'news', {dude: 'whatup'}
  socket.on 'update', (data)->
    socket.emit 'news', data
  socket.on 'game_update', (game) -> 
    Game.find game.id, (one, two) ->
      @game = two
      @game.home_score = game.home_score
      @game.away_score = game.away_score
      @game.save (game2) ->
        #socket.emit 'news', game
        socket.emit 'game_update', @game
        socket.broadcast.emit 'game_update', @game
    #socket.emit 'news', {game: Game.find(game.id)}


if not module.parent
    port = process.env.PORT or 3000
    app.listen port
    console.log "Railway server listening on port %d within %s environment", port, app.settings.env

