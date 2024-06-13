extends Node

const FILE_PATH = "user://lang.save"

enum {
	PLAYER_NAME,
	AVATAR,
	PROFILE_CREATED,
	START_DATE,
	START_DATE_STRING,
	DIFFICULTY,
	EXP,
	DAILY_USUAL,
	DAILY_BLITZ,
	TUTOR_BATTLE,
	MEDALS,
	BLITZ_RIGHTS,
	DIALOGS_READ,
	MONSTERS_BEATEN,
}


var DATA = {
	PLAYER_NAME:"Hehe",
	AVATAR:0,
	PROFILE_CREATED:false,
	START_DATE:Time.get_unix_time_from_system(),
	START_DATE_STRING:Time.get_datetime_string_from_system(),
	DIFFICULTY:0,
	EXP: 100,
	DAILY_USUAL: "2020-12-12",
	DAILY_BLITZ: "2020-12-12",
	TUTOR_BATTLE:false,
	MEDALS:[0],
	BLITZ_RIGHTS: 0,
	DIALOGS_READ:0,
	MONSTERS_BEATEN:0
}


func load_data():
	if FileAccess.file_exists(FILE_PATH):
		var file_text = FileAccess.get_file_as_string(FILE_PATH)
		var json_parser = JSON.new()
		var err : Error = json_parser.parse(file_text)
		if err == Error.OK:
			var LOADED_DATA = json_parser.data
			for i in LOADED_DATA.keys():
				DATA[int(i)] = LOADED_DATA[i]
			DATA[AVATAR] = int(clamp(DATA[AVATAR], 0, 3))
			DATA[DIFFICULTY] = int(clamp(DATA[DIFFICULTY], 0, 1))
			DATA[BLITZ_RIGHTS] = int(DATA[BLITZ_RIGHTS])
			var new_arr = []
			for i in DATA[MEDALS]:
				new_arr.append(int(i))
			DATA[MEDALS] = new_arr
		else:
			print(err) # TODO: Обработку ошибок в игре
	else:
		save_data()

func save_data():
	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	var json_parser = JSON.new()
	var data_string = json_parser.stringify(DATA)
	file.store_string(data_string)
	file = null


func delete_data():
	if FileAccess.file_exists(FILE_PATH):
		DirAccess.remove_absolute(FILE_PATH)


var MULTI : SceneMultiplayer
var ip = "109.71.242.204"
var port = 30123

func ask_leaderboard_data():
	MULTI = get_tree().get_multiplayer()
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, 30123)
	MULTI.multiplayer_peer = peer
	await get_tree().create_timer(1).timeout
	rpc_id(1, "asked_for_leaderboard", DATA[PLAYER_NAME], DATA[START_DATE], DATA[EXP])

@rpc
func leaders_sent(leaders):
	LEADERBOARD = leaders
	print(LEADERBOARD)

## SERVER CODE


var LEADERBOARD = {}

@rpc("any_peer", "reliable")
func asked_for_leaderboard(nick, date, exp):
	var id = MULTI.get_remote_sender_id()
	LEADERBOARD[[nick, date]] = exp
	var leaders = []
	for key in LEADERBOARD.keys():
		leaders.append([key[0], key[1], LEADERBOARD[key]])
	print()
	leaders.sort_custom(sort_descending)
	var size = leaders.size()
	if size > 10:
		size = 10
	var users_array = []
	for i in range(size):
		users_array.append(leaders[i])
	rpc_id(id, "leaders_sent", users_array)

func sort_descending(a, b):
	if a[2] < b[2]:
		return true
	return false



