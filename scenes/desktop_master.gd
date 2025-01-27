extends Control

@onready var anim = %AnimationPlayer
@onready var all_scenes = %all_scenes_here

@export var got_frog_scene : PackedScene

func _ready() -> void:
	on_first_start_game()
	connect_all_signals()

func _process(delta: float) -> void:
	pass

func connect_all_signals():
	GlobalSignals.got_new_frog.connect(_on_get_new_frog)

func on_first_start_game():
	handle_changing_scene(load(GameData.scene_paths[GameData.SCENES.GACHA_ROOM]))
	anim.play("window_in")
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
