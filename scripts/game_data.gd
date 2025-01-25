extends Node

enum FROG_COLECTIONS {GOTHIC, WILD_WEST, SILLY}

enum SCENES {GACHA_ROOM, MAIN_MENU}

const scene_paths = [
	"res://scenes/gacha_master.tscn",
	"res://scenes/main_menu.tscn"
]

const FROG_TEMPLATE_PATH = "res://resources/frog_resources/%s.tres"
const FROG_LIST = ["cowboy", "gotico", "palhaco"]

const DEFAUT_START_PLAYER_MONEY = 10

func get_all_frog_templates():
	var all_frogs = []
	
	for i in FROG_LIST:
		all_frogs.append(load(FROG_TEMPLATE_PATH % i))
	
	return(all_frogs)

func get_random_frong_res(frog_res_list : Array):
	var frog_res = frog_res_list.pick_random()
	return(frog_res)

func pick_new_random_frog_from_gacha():
	var new_frog = get_random_frong_res(get_all_frog_templates())
	PlayerData.add_new_frog_to_collection(new_frog)
	return(new_frog)

func start_fresh_game():
	PlayerData.current_money = DEFAUT_START_PLAYER_MONEY
	PlayerData.currnt_day = 1
	PlayerData.current_collection = []
