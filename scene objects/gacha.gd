extends Control

signal got_new_frog

@onready var anim = %AnimationPlayer
@onready var collision = %Area2D

var is_hovering = false
var can_interact = true

var already_played_idle_anim = false
var is_playing_gacha_anim = false

func _ready() -> void:
	print("ready do gacha")
	anim.play("idle")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("game_click") and is_hovering == true and can_interact == true:
		#GameData.change_mouse_pointer(GameData.MOUSE_POINTERS.POINTER)
		if PlayerData.current_money > 0:
			get_gacha()
		else: no_money()
	if is_hovering == false and already_played_idle_anim == false and is_playing_gacha_anim == false:
		already_played_idle_anim = true
		anim.play("idle")

func get_gacha():
	can_interact = false
	anim.play("gacha")
	is_playing_gacha_anim = true
	GlobalSignals.play_sfx.emit(GameResources.get_resource(GameResources.SFX["GACHA_SPIN"]))
	await anim.animation_finished
	can_interact = true
	
	got_new_frog.emit()

func no_money():
	print("NO MONEY")
	anim.play("no_money")
	GlobalSignals.show_warning.emit(GameData.GAME_WARNINGS["NOT_ENOUGH_COINS"])

func mouse_out_helper():
	anim.play("hover_out")
	await anim.animation_finished
	already_played_idle_anim = false

#signals

func _on_area_2d_mouse_entered() -> void:
	#GameData.change_mouse_pointer(GameData.MOUSE_POINTERS.HAND)
	print("ENTROU NO GACHA")
	is_hovering = true
	anim.play("hover_in")
	await anim.animation_finished

func _on_area_2d_mouse_exited() -> void:
	#GameData.change_mouse_pointer(GameData.MOUSE_POINTERS.POINTER)
	print("SAIU DO GACHA")
	is_hovering = false
	if is_playing_gacha_anim == false:
		mouse_out_helper()
	#anim.play("idle")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "gacha":
		is_playing_gacha_anim = false
		if is_hovering == false:
			mouse_out_helper()
