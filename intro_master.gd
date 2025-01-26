extends Control

@onready var cutscene = %cutscene
@onready var anim = %AnimationPlayer
@onready var tile = %start_game

var ready_to_start = false

func _ready() -> void:
	start_game_intro()

func _process(delta: float) -> void:
	if Input.is_action_just_released("game_enter") and ready_to_start == true:
		GlobalSignals.change_scene.emit(load(GameData.scene_paths[GameData.SCENES.DESKTOP]))

func start_game_intro():
	anim.play("splash")
	await anim.animation_finished
	
	if GameData.is_firt_time == true:
		print("is player_first time")
		cutscene.visible = true
		cutscene.play_cutsene()
		await cutscene.finished_cutscene
		cutscene.visible = false
	
	tile.visible = true
	tile.start_title_screen()

#signals

func _on_start_game_finished_title_animation_in() -> void:
	ready_to_start = true
