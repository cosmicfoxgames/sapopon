extends Control

@onready var all_scenes = %all_scenes_here
@onready var sfx_handler = %sfx_handler

@onready var music_player = %music

func _ready() -> void:
	handle_changing_scene(load(GameData.scene_paths[GameData.SCENES.MAIN_MENU]))
	conect_all_signals()

func _process(delta: float) -> void:
	pass

func conect_all_signals():
	GlobalSignals.change_scene.connect(_on_change_scene)
	
	GlobalSignals.play_music.connect(_on_play_music)
	GlobalSignals.play_sfx.connect(_on_play_sfx)

func handle_changing_scene(scene_to_go : PackedScene):
	for i in all_scenes.get_children():
		i.queue_free()
	
	var new_scene = scene_to_go.instantiate()
	all_scenes.add_child(new_scene)

func play_music(music):
	music_player.stop()
	music_player.stream = music
	
	music_player.play()

#func fade_music():
	#const rate = 5

#signals

func _on_change_scene(scene : PackedScene):
	handle_changing_scene(scene)

func _on_play_music(which):
	play_music(which)

func _on_play_sfx(which):
	pass
