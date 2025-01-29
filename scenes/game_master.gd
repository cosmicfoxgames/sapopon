extends Control

@onready var all_scenes = %all_scenes_here
@onready var sfx_handler = %sfx_handler

@onready var anim = %AnimationPlayer

@onready var music_player = %music

func _ready() -> void:
	Save.load_game()
	handle_changing_scene(load(GameData.scene_paths[GameData.SCENES.INTRO]))
	conect_all_signals()
	GameResources.populate_frogs_by_raritie()

func _process(delta: float) -> void:
	pass

func conect_all_signals():
	GlobalSignals.change_scene.connect(_on_change_scene)
	GlobalSignals.fade_scene.connect(_on_fade_scene)
	
	GlobalSignals.play_music.connect(_on_play_music)
	GlobalSignals.play_sfx.connect(_on_play_sfx)
	
	GlobalSignals.stop_music.connect(_on_stop_music)

func handle_changing_scene(scene_to_go : PackedScene):
	for i in all_scenes.get_children():
		i.queue_free()
	
	var new_scene = scene_to_go.instantiate()
	all_scenes.add_child(new_scene)

func fade_screen(scene_to_go : PackedScene):
	print("veio pro fade scren")
	get_tree().paused = true
	anim.play("fade_in")
	await anim.animation_finished
	handle_changing_scene(scene_to_go)
	await get_tree().create_timer(0.1).timeout
	anim.play("fade_out")
	await anim.animation_finished
	get_tree().paused = false

func play_music(music):
	music_player.stop()
	music_player.stream = music
	
	music_player.play()

func stop_music():
	music_player.stop()

#signals

func _on_change_scene(scene : PackedScene):
	handle_changing_scene(scene)

func _on_fade_scene(scene : PackedScene):
	fade_screen(scene)

func _on_play_music(which):
	play_music(which)
func _on_stop_music():
	stop_music()

func _on_play_sfx(which):
	sfx_handler.try_to_play_sfx(which)
