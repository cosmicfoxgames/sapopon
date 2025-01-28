extends Control

@onready var board = %Label
@onready var indicator_container = %VBoxContainer
@onready var coins_label = %coin_ammnt

@onready var frog_collection_container = %collection_buttons
@onready var frog_to_sell_container = %to_sell_buttons

@export var market_indicator : PackedScene
@export var frog_button : PackedScene

var coin_ammnt_to_add = 0
var frogs_to_subtract = []

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func set_ui():
	coins_label.text = str(coin_ammnt_to_add)
	
	set_fluctuation_markers()
	set_frog_collection()

func add_market_indicator(raw_key, parent, market_name, status : GameData.FLUCTUATION_RATE):
	var new_indicator = market_indicator.instantiate()
	parent.add_child(new_indicator)
	
	new_indicator.set_itself(market_name, status, GameResources.FROG_COLLECTIONS_COLORS[raw_key])

func set_fluctuation_markers():
	#flutuações boas
	for i in PlayerData.today_market_fluctuation[0]:
		if i == PlayerData.today_market_fluctuation[2][0] or i == PlayerData.today_market_fluctuation[2][1]:
			add_market_indicator(i, indicator_container, (tr(i) + " !"), GameData.FLUCTUATION_RATE.XTRA_GOOD)
		else: add_market_indicator(i, indicator_container, i, GameData.FLUCTUATION_RATE.GOOD)
	
	#flutuações ruins
	for i in PlayerData.today_market_fluctuation[1]:
		if i == PlayerData.today_market_fluctuation[2][0] or i == PlayerData.today_market_fluctuation[2][1]:
			add_market_indicator(i, indicator_container, (tr(i) + " !"), GameData.FLUCTUATION_RATE.XTRA_BAD)
		else: add_market_indicator(i, indicator_container, i, GameData.FLUCTUATION_RATE.BAD)

func set_frog_collection():
	for i in PlayerData.current_collection:
		create_new_collection_button(load(GameData.FROG_TEMPLATE_PATH % i))

func create_new_sell_button(frog : FrogTemplate):
	var new_frog_button = frog_button.instantiate()
	frog_to_sell_container.add_child(new_frog_button)
	new_frog_button.set_frog(frog)
	new_frog_button.button_click.connect(_on_click_sell_frog_button)

func create_new_collection_button(frog : FrogTemplate):
	var new_frog_button = frog_button.instantiate()
	frog_collection_container.add_child(new_frog_button)
	new_frog_button.set_frog(frog)
	new_frog_button.button_click.connect(_on_click_frog_collection_button)

#signals

func _on_button_2_button_down() -> void:
	GlobalSignals.change_scene.emit(load(GameData.scene_paths[GameData.SCENES.GACHA_ROOM]))

func _on_click_frog_collection_button(button):
	button.queue_free()
	create_new_sell_button(button.frog_res)
	
	coin_ammnt_to_add += GameData.get_frog_influenced_value(button.frog_res)
	coins_label.text = str(coin_ammnt_to_add)
	
	frogs_to_subtract.append(button.frog_res.id)

func _on_click_sell_frog_button(button):
	button.queue_free()
	create_new_collection_button(button.frog_res)
	
	coin_ammnt_to_add -= GameData.get_frog_influenced_value(button.frog_res)
	coins_label.text = str(coin_ammnt_to_add)
	
	frogs_to_subtract.erase(button.frog_res.id)

#sell button
func _on_game_button_button_click() -> void:
	print("cliclou pra vender sapos")
	print("valor: " + str(coin_ammnt_to_add))
	print("sapos: " + str(frogs_to_subtract))
	
	if coin_ammnt_to_add > 0:
		GlobalSignals.play_sfx.emit(GameResources.get_resource(GameResources.SFX["FROG_SELL"]))
		for i in frog_to_sell_container.get_children():
			i.queue_free()
		
		PlayerData.current_money += coin_ammnt_to_add
		for i in frogs_to_subtract:
			PlayerData.current_collection.erase(i)
		
		coin_ammnt_to_add = 0
		frogs_to_subtract = []
		coins_label.text = str(coin_ammnt_to_add)
	else: print("can't sell for lss than 0!")
