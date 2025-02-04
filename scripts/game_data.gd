extends Node

var full_version = [0, 2, 0]

enum FROG_COLECTIONS {LUCKY, HARD, STYLISH, ADVENTURE, MYSTIC, MATERIALS}
enum MARKET_FLUCTUATIONS {NEGATIVE, NEUTRAL, POSITIVE}
enum FLUCTUATION_RATE {XTRA_BAD, BAD, GOOD, XTRA_GOOD}

enum SCENES {GACHA_ROOM, MAIN_MENU, MARKET, COLLECTION, DESKTOP, INTRO, INBETWEEN_CARD, CREDITS}

enum MOUSE_POINTERS {POINTER, HAND}

const game_version = "v0.2"

const scene_paths = [
	"res://scenes/gacha_master.tscn",
	"res://scenes/main_menu.tscn",
	"res://scenes/market_master.tscn",
	"res://scenes/collection_master.tscn",
	"res://scenes/desktop_master.tscn",
	"res://scenes/intro_master.tscn",
	"res://scenes/inbetween_master.tscn",
	"res://scenes/credits_master.tscn"
]

const FROG_TEMPLATE_PATH = "res://resources/frog_resources/%s.tres"
const FROG_LIST = [
	"frog_angel", "frog_demon", "frog_future", "frog_medieval", "frog_pieta", "frog_cheese", "frog_jfrog",
	"frog_chad", "frog_hfroger", "frog_gnome", "frog_autism", "frog_paradox", "frog_tan", "frog_ladybug",
	"frog_low_poly", "frog_sapone", "frog_lips", "frog_vga", "frog_french", "frog_war", "frog_rogue",
	"frog_alien", "frog_space", "frog_primitive", "frog_mage", "frog_greek", "frog_atom", "frog_sound",
	"frog_bread", "frog_grof", "frog_anime", "frog_abstract", "frog_pipa_l", "materials_steel_frog",
	"materials_alexandrite_frog", "materials_antimatter_frog", "materials_apatite_frog",
	"materials_slate_frog", "materials_meat_frog", "materials_chalcedony_frog", "materials_aventurine_frog",
	"materials_lead_frog", "materials_cement_frog", "materials_glass_frog", "materials_chrysoberyl_frog",
	"materials_chrysoprase_frog", "materials_manure_frog", "materials_feldspar_frog", "materials_cast_iron_frog",
	"materials_pig_iron_frog", "materials_fluorite_frog", "materials_malachite_frog",
	"materials_pearl_frog", "materials_molybdenum_frog", "materials_pvc_frog", "materials_ruby_frog",
	"materials_sapphire_frog", "materials_rhodochrosite_frog", "materials_sodalite_frog", "materials_topaz_frog",
	"materials_tungsten_frog", "materials_uranium_frog",
	"frog_icecream", "frog_coins", "frog_png", "frog_joker", "frog_sata"
]

const GAME_WARNINGS = {
	"NOT_ENOUGH_COINS" : "not_enough_money",
	"CANT_SELL_LESS_ZERO" : "can_sell_less_zero",
	"GOAL_TIP" : "objective_msg",
	"LOSE_TIPE" : "lose_msg",
}

const DEFAUT_START_PLAYER_MONEY = 10

#win loose condition based on how much money you have
const LOOSE_CONDITION = -100
const WIN_CONDITION = 100000

var is_firt_time = true
var already_won_game = false
var most_recent_frog : FrogTemplate

func get_all_frog_templates(list = FROG_LIST):
	var all_frogs = []
	
	for i in list:
		all_frogs.append(load(FROG_TEMPLATE_PATH % i))
	
	return(all_frogs)

func get_random_frong_res(frog_res_list : Array):
	var frog_res = frog_res_list.pick_random()
	return(frog_res)

func pick_new_random_frog_from_gacha():
	var new_frog #= get_random_frong_res(get_all_frog_templates())
	var chance = CFGCommonLibrary.get_rand_number(1, 100)
	var pool_to_pick_frog
	
	print("chance of rarity is: " + str(chance))
	
	if chance >= 1 and chance <= 60: pool_to_pick_frog = GameResources.frogs_by_ratitie["COMMOM"]
	elif chance > 60 and chance <= 85: pool_to_pick_frog = GameResources.frogs_by_ratitie["INCOMMOM"]
	elif chance > 85 and chance <= 95: pool_to_pick_frog = GameResources.frogs_by_ratitie["RARE"]
	elif chance > 95 and chance <= 100: pool_to_pick_frog = GameResources.frogs_by_ratitie["UNIQUE"]
	
	new_frog = get_random_frong_res(get_all_frog_templates(pool_to_pick_frog))
	
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
	print(PlayerData.today_market_fluctuation)
	print(PlayerData.current_collection)
	var valor = 0
	
	for i in PlayerData.current_collection:
		valor += get_frog_influenced_value(load(GameData.FROG_TEMPLATE_PATH % i))
	
	PlayerData.current_collection_value = valor

func get_frog_influenced_value(frog : FrogTemplate):
	var valor = 0
	print("veio pro get_frog_influenced_value")
	print("sapo é: " + frog.id + ", com valor de: " + str(frog.get_value()))
	
	#coleção do sapo é uma flutuiação positiva
	if PlayerData.today_market_fluctuation[0].has(GameData.FROG_COLECTIONS.keys()[frog.colection]):
		#coleção é uma super influencia
		if PlayerData.today_market_fluctuation[2].has(GameData.FROG_COLECTIONS.keys()[frog.colection]):
			print("sapo é super flutuação positiva")
			valor = frog.get_value() * 8
		#coleção não é uma super influencia
		else:
			print("sapo é flutuação positiva")
			valor = frog.get_value() * 2
	
	#coleção do sapo é uma flutuiação negativa
	elif PlayerData.today_market_fluctuation[1].has(GameData.FROG_COLECTIONS.keys()[frog.colection]):
		#coleção é uma super influencia
		if PlayerData.today_market_fluctuation[2].has(GameData.FROG_COLECTIONS.keys()[frog.colection]):
			print("sapo é super flutuação negativa")
			valor = frog.get_value() * -8
		#coleção não é uma super influencia
		else:
			print("sapo é flutuação negativa")
			valor = frog.get_value() * -2
	
	#coleção não tá nas flutuações de hj
	else:
		print("sapo não tá em flutuação")
		valor = frog.get_value()
	
	print("valor final de: " + str(valor))
	return(valor)

func start_fresh_game():
	set_market_fluctuation_for_today()
	PlayerData.current_money = DEFAUT_START_PLAYER_MONEY
	PlayerData.currnt_day = 1
	PlayerData.current_collection = []
	
	is_firt_time = true
	already_won_game = false
	Save.save_game()

#func change_mouse_pointer(which : MOUSE_POINTERS):
	#Input.set_custom_mouse_cursor(GameResources.get_resource(GameResources.CURSORS_GRAPHICS[MOUSE_POINTERS.keys()[which]]))

func loose_game():
	print("YOU LOSE")
	start_fresh_game()

func win_game():
	print("YOU WON")
	already_won_game = true
