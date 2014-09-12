TeamSpeakClient	= require "node-teamspeak"
Promise = require "promise"

name = process.argv[2]
channels = []
id = 0
p = []

move = ()->
	connection.send "clientmove", {"cid": channels[Math.floor(Math.random() * channels.length)], "clid": id}, () ->
		process.nextTick move

connection = new TeamSpeakClient "localhost", "25639"

p.push new Promise (resolve, reject) ->
	connection.send "clientlist", (err, response, raw) ->
		for user in response
			if user.client_nickname.indexOf(name) > -1
				id = user.clid

		resolve()

p.push new Promise (resolve, reject) ->
	connection.send "channellist", (err, response, raw) ->
		for room in response
			channels.push room.cid

		resolve()

Promise.all(p).then (res) ->
	process.nextTick move
