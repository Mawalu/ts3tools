TeamSpeakClient	= require "node-teamspeak"
Promise			= require "promise"

msg = process.argv[2]
p   = []

connection = new TeamSpeakClient "localhost", "25639"
connection.send "clientlist", (err, response, raw) ->

	for user in response
		p.push new Promise (resolve, reject) ->
			connection.send "clientpoke", {"msg": msg, "clid": user.clid}, (err, response, rawResponse) ->
				resolve()

	Promise.all(p).then (res) ->
		process.exit 0
