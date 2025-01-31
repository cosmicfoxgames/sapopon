extends Control

@onready var card = %card
@onready var timer = %Timer

@export var next_day_card : Resource
@export var loose_card : Resource
@export var win_card : Resource

var player_full_money

func _ready() -> void:
	GlobalSignals.stop_music.emit()
	player_full_money = PlayerData.current_money + PlayerData.current_collection_value
	print("player money is: " + str(PlayerData.current_money))
	print("current collection value is: " + str(PlayerData.current_collection_value))
	print("Player full money is: " + str(player_full_money))
	decide_what_to_do()

func _process(delta: float) -> void:
	pass

func decide_what_to_do():
	var where_to_go_next
	if player_full_money < GameData.LOOSE_CONDITION:
		GameData.loose_game()
		card.texture = loose_card
		where_to_go_next = load(GameData.scene_paths[GameData.SCENES.INTRO])
	elif player_full_money >= GameData.WIN_CONDITION and GameData.already_won_game == false:
		GameData.win_game()
		card.texture = loose_card
		where_to_go_next = load(GameData.scene_paths[GameData.SCENES.MAIN_MENU]) #trocar pra creditos depois
	else:
		card.texture = next_day_card
		where_to_go_next = load(GameData.scene_paths[GameData.SCENES.DESKTOP])
	
	timer.start()
	await timer.timeout
	
	GlobalSignals.fade_scene.emit(where_to_go_next)
