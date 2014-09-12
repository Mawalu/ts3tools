TeamSpeakClient	= require "node-teamspeak"

name = process.argv[2]
id = 0

move = ()->
	connection.send "clientmove", {"cid": 43, "clid": id}, () ->
		process.nextTick move

connection = new TeamSpeakClient "localhost", "25639"
connection.send "clientlist", (err, response, raw) ->

	for user in response
		if user.client_nickname.indexOf(name) > -1
			id = user.clid
			process.nextTick move
