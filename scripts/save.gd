extends Node

signal just_saved_game()
signal just_updated_game()

signal game_is_older_than_save

enum SAVE_VERSIONING_STATUS {SAME_VERSION, GAME_IS_NEW_VERSION, GAME_IS_OLD_VERSION}

const VERSIONS_THAT_NEED_UPDATION = []

var save = {}
var save_game_path = "user://game.save"

func save_game():
	var file = FileAccess.open(save_game_path, FileAccess.WRITE)
	get_save()
	file.store_var(save)
	file.close()
	print("fim do save game")
	
	just_saved_game.emit()

func load_game():
	print("VEIO PRO LOAD GAME")
	#DebugDevCheats.delete_save_file()
	if not FileAccess.file_exists(save_game_path):
		print("no save game yet. creating new save game")
		#GameData.get_system_locale()
		get_default_save_game()
		save_game()
	var file = FileAccess.open(save_game_path, FileAccess.READ)
	save = file.get_var()
	file.close()
	
	match check_if_save_is_same_version(save):
		SAVE_VERSIONING_STATUS.SAME_VERSION: update_with_loaded_game()
		SAVE_VERSIONING_STATUS.GAME_IS_NEW_VERSION: check_for_updates_in_save(save)
		SAVE_VERSIONING_STATUS.GAME_IS_OLD_VERSION: game_is_older_than_save.emit()

func get_save():
	print("veio pro get_save")
	save = {
		"version" : GameData.full_version,
		"current_money" : PlayerData.current_money,
		"collection" : PlayerData.current_collection,
		"curr_day" : PlayerData.currnt_day,
		"today_market_fluctuation" :  PlayerData.today_market_fluctuation
	}

func get_default_save_game():
	print("veio pro get_degault_save_game")
	save = {
		"version" : GameData.full_version,
		"current_money" : 0,
		"collection" : [],
		"curr_day" : 1,
		"today_market_fluctuation" : []
	}
	
	update_with_loaded_game()

func update_with_loaded_game():
	print("veio pro update with loaded game")
	print(save)
	PlayerData.current_money = save["current_money"]
	PlayerData.current_collection = save["collection"]
	PlayerData.currnt_day = save["curr_day"]
	PlayerData.today_market_fluctuation = save["today_market_fluctuation"]
	
	just_updated_game.emit()

#handle versioning

func check_if_save_is_same_version(s : Dictionary):
	print("veio pro check_if_save_is_same_version")
	
	var save_version = save["version"]
	
	var version_check_step = 0	
	for i in GameData.full_version:
		print("checking, game_version: " + str(i) + ", save_version: " + str(save_version[version_check_step]))
		if i > save_version[version_check_step]:
			print("GAME_IS_NEW_VERSION")
			return(SAVE_VERSIONING_STATUS.GAME_IS_NEW_VERSION)
		elif i < save_version[version_check_step]:
			print("GAME_IS_OLD_VERSION")
			return(SAVE_VERSIONING_STATUS.GAME_IS_OLD_VERSION)
		
		version_check_step += 1
	
	print("SAME_VERSION")
	return(SAVE_VERSIONING_STATUS.SAME_VERSION)

func check_for_updates_in_save(s):
	var save_version = save["version"]
	
	for i in VERSIONS_THAT_NEED_UPDATION:
		if i == save_version:pass
			#match i:
				#[2, 1, 0]: update_from_2_1_to_3_0(s)
	
	update_with_loaded_game()

#all save data updates
