extends Control

@onready var anim = %AnimationPlayer
@onready var all_scenes = %all_scenes_here
@onready var days = %days_label

@export var got_frog_scene : PackedScene

func _ready() -> void:
	on_first_start_game()
	connect_all_signals()
	play_boot_up_warning()
	
	GlobalSignals.play_sfx.emit(GameResources.get_resource(GameResources.SFX["BOOTUP"]))

func _process(delta: float) -> void:
	pass

func connect_all_signals():
	GlobalSignals.got_new_frog.connect(_on_get_new_frog)

func on_first_start_game():
	handle_changing_scene(load(GameData.scene_paths[GameData.SCENES.GACHA_ROOM]))
	anim.play("window_in")
	days.text = tr("day") % str(PlayerData.currnt_day)
	await anim.animation_finished

func handle_changing_scene(scene_to_go : PackedScene):
	for i in all_scenes.get_children():
		i.queue_free()
	
	var new_scene = scene_to_go.instantiate()
	all_scenes.add_child(new_scene)

func click(which):
	var scene_to_go
	match which:
		"market" : scene_to_go = load(GameData.scene_paths[GameData.SCENES.MARKET])
		"collection" : scene_to_go = load(GameData.scene_paths[GameData.SCENES.COLLECTION])
		"gacha" : scene_to_go = load(GameData.scene_paths[GameData.SCENES.GACHA_ROOM])
	
	anim.play("window_out")
	await anim.animation_finished
	handle_changing_scene(scene_to_go)
	anim.play("window_in")
	await anim.animation_finished

func advance_day():
	print("veio pro advance day")
	GameData.get_collection_value()
	GameData.set_market_fluctuation_for_today()
	PlayerData.currnt_day += 1
	
	Save.save_game()
	
	GlobalSignals.fade_scene.emit(load(GameData.scene_paths[GameData.SCENES.INBETWEEN_CARD]))

func play_boot_up_warning():
	GameData.get_collection_value()
	
	if GameData.is_firt_time == true:
		GlobalSignals.show_warning.emit(GameData.GAME_WARNINGS["GOAL_TIP"])
	if (PlayerData.current_money + PlayerData.current_collection_value) <= -50:
		GlobalSignals.show_warning.emit(GameData.GAME_WARNINGS["LOSE_TIPE"])

#signals

func _on_button_gacha_clicked(which: Variant) -> void:
	click(which)
func _on_button_collection_clicked(which: Variant) -> void:
	click(which)
func _on_button_market_clicked(which: Variant) -> void:
	click(which)

func _on_get_new_frog(frog : FrogTemplate):
	print("veio pro _on_et_new_frog")
	var new_frog_scene = got_frog_scene.instantiate()
	add_child(new_frog_scene)
	get_tree().paused = true

#next day button
func _on_game_button_button_click() -> void:
	if GameData.is_firt_time == true: GameData.is_firt_time = false
	advance_day()

#back to main menu button
func _on_game_button_2_button_click() -> void:
	if GameData.is_firt_time == true: GameData.is_firt_time = false
	Save.save_game()
	GlobalSignals.fade_scene.emit(load(GameData.scene_paths[GameData.SCENES.MAIN_MENU]))
