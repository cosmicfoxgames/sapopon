extends Control

@onready var cutscene = %cutscene
@onready var anim = %AnimationPlayer
@onready var tile = %start_game
@onready var timer = %Timer

var ready_to_start = false

func _ready() -> void:
	start_game_intro()

func _process(delta: float) -> void:
	if Input.is_action_just_released("game_enter") and ready_to_start == true:
		GlobalSignals.fade_scene.emit(load(GameData.scene_paths[GameData.SCENES.MAIN_MENU]))

func start_game_intro():
	anim.play("splash")
	await anim.animation_finished
	
	if GameData.is_firt_time == true:
		print("is player_first time")
		play_intro_cutscene()
	else: cue_title()

func cue_title():
	tile.visible = true
	tile.start_title_screen()
	timer.start()

func play_intro_cutscene():
	GlobalSignals.play_music.emit(GameResources.get_resource(GameResources.MUSICS["INTRO"]))
	ready_to_start = false
	tile.visible = false
	cutscene.visible = true
	cutscene.play_cutsene()
	await cutscene.finished_cutscene
	cutscene.visible = false
	GlobalSignals.stop_music.emit()
	GlobalSignals.play_sfx.emit(GameResources.get_resource(GameResources.SFX["IMPACT"]))
	cue_title()

#signals

func _on_start_game_finished_title_animation_in() -> void:
	ready_to_start = true

#title wait time timer
func _on_timer_timeout() -> void:
	play_intro_cutscene()
