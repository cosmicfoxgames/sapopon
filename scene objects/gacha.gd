extends Node2D

signal got_new_frog

@onready var anim = %AnimationPlayer

var is_hovering = false
var can_interact = true

func _ready() -> void:
	anim.play("idle")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("game_click") and is_hovering == true and can_interact == true:
		if PlayerData.current_money > 0:
			get_gacha()
		else: no_money()

func get_gacha():
	can_interact = false
	anim.play("gacha")
	GlobalSignals.play_sfx.emit(GameResources.get_resource(GameResources.SFX["GACHA_SPIN"]))
	await anim.animation_finished
	
	if is_hovering == false:
		anim.play("idle")
	can_interact = true
	
	got_new_frog.emit()

func no_money():
	print("NO MONEY")

#signals

func _on_area_2d_mouse_entered() -> void:
	anim.play("hover_in")
	await anim.animation_finished
	is_hovering = true

func _on_area_2d_mouse_exited() -> void:
	anim.play("hover_out")
	is_hovering = false
	await anim.animation_finished
	anim.play("idle")
