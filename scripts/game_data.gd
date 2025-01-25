extends Node

enum FROG_COLECTIONS {GOTHIC, WILD_WEST, SILLY, SHAPES_N_COLORS, REALISTIC, GAY}
enum MARKET_FLUCTUATIONS {NEGATIVE, NEUTRAL, POSITIVE}

enum SCENES {GACHA_ROOM, MAIN_MENU, MARKET, COLLECTION}

const scene_paths = [
	"res://scenes/gacha_master.tscn",
	"res://scenes/main_menu.tscn",
	"res://scenes/market_master.tscn",
	"res://scenes/collection_master.tscn"
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

func set_market_fluctuation_for_today():
	var pattern = CFGCommonLibrary.get_rand_number(0, 2)
	print("selected pattern for todays is " + MARKET_FLUCTUATIONS.keys()[pattern])
	
	var temp_collections_list = []
	
	var collections_in_pos = []
	var collections_in_neg = []
	
	var collections_affected = []
	var collections_w_super_influence = []
	
	for i in FROG_COLECTIONS:
		temp_collections_list.append(i)
	
	if pattern == MARKET_FLUCTUATIONS.POSITIVE:
		for i in range(4):
			collections_in_pos.append(temp_collections_list.pop_at(CFGCommonLibrary.get_rand_number(0, (temp_collections_list.size() - 1))))
		for i in range(2):
			collections_in_neg.append(temp_collections_list.pop_at(CFGCommonLibrary.get_rand_number(0, (temp_collections_list.size() - 1))))
	elif pattern == MARKET_FLUCTUATIONS.NEGATIVE:
		for i in range(2):
			collections_in_pos.append(temp_collections_list.pop_at(CFGCommonLibrary.get_rand_number(0, (temp_collections_list.size() - 1))))
		for i in range(4):
			collections_in_neg.append(temp_collections_list.pop_at(CFGCommonLibrary.get_rand_number(0, (temp_collections_list.size() - 1))))
	elif pattern == MARKET_FLUCTUATIONS.NEUTRAL:
		for i in range(3):
			collections_in_pos.append(temp_collections_list.pop_at(CFGCommonLibrary.get_rand_number(0, (temp_collections_list.size() - 1))))
		for i in range(3):
			collections_in_neg.append(temp_collections_list.pop_at(CFGCommonLibrary.get_rand_number(0, (temp_collections_list.size() - 1))))
	
	collections_affected.append_array(collections_in_pos)
	collections_affected.append_array(collections_in_neg)
	
	for i in range(2):
		collections_w_super_influence.append(collections_affected.pop_at(CFGCommonLibrary.get_rand_number(0, (collections_affected.size() - 1))))
	
	PlayerData.today_market_fluctuation = [collections_in_pos, collections_in_neg, collections_w_super_influence]
	print([collections_in_pos, collections_in_neg, collections_w_super_influence])
	#return[collections_in_pos, collections_in_neg, collections_w_super_influence]

func get_collection_value():
	print("veio pro get_collection_value")
	var valor = 0
	
	for i in PlayerData.current_collection:
		var frog = load(GameData.FROG_TEMPLATE_PATH % i)
		if PlayerData.today_market_fluctuation[0].has(i):
			#coleção do sapo é uma flutuiação positiva
			if PlayerData.today_market_fluctuation[2].has(i):
				#coleção é uma super influencia
				valor += frog.get_value() * 8
			else:
				#coleção não é uma super influencia
				valor += frog.get_value() * 2
		
		elif PlayerData.today_market_fluctuation[1].has(i):
			#coleção do sapo é uma flutuiação negativa
			if PlayerData.today_market_fluctuation[2].has(i):
				#coleção é uma super influencia
				valor += frog.get_value() * -8
			else:
				#coleção não é uma super influencia
				valor += frog.get_value() * -2
		
		else:
			#coleção não tá nas flutuações de hj
			valor += frog.get_value()
	
	PlayerData.current_collection_value = valor

func start_fresh_game():
	PlayerData.current_money = DEFAUT_START_PLAYER_MONEY
	PlayerData.currnt_day = 1
	PlayerData.current_collection = []
	
	#tirar depois
	set_market_fluctuation_for_today()
