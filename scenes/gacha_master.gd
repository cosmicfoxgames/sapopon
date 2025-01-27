extends Control

@onready var upper_ui = %upper_ui_gacha

func _ready() -> void:
	connect_all_signals()
	upper_ui.set_ui(PlayerData.current_money, PlayerData.currnt_day)
	GlobalSignals.play_music.emit(GameResources.get_resource(GameResources.MUSICS["GACHA"]))

func _process(delta: float) -> void:
	pass

func connect_all_signals():
	GlobalSignals.advance_day.connect(_on_advance_day)

func get_new_frog():
	var new_frog = GameData.pick_new_random_frog_from_gacha()
	GameData.most_recent_frog = new_frog
	GlobalSignals.got_new_frog.emit(new_frog)
	#GlobalSignals.print_to_console.emit("GOT A NEW FROG!\nIt is: " + new_frog.id + ", from the " + GameData.FROG_COLECTIONS.keys()[new_frog.colection] + " collesction, and it is the rarity of " + str(new_frog.frog_rarity))

func advance_day():
	print("veio pro advance day")
	upper_ui.print_to_console("passando dia!")
	await get_tree().create_timer(2).timeout
	upper_ui.print_to_console("")
	
	GameData.set_market_fluctuation_for_today()
	PlayerData.currnt_day += 1
	
	upper_ui.set_ui(PlayerData.current_money, PlayerData.currnt_day)
	Save.save_game()

#signals

func _on_upper_ui_gacha_spin_gacha_signal(many: Variant) -> void:
	get_new_frog()

func _on_advance_day():
	advance_day()
