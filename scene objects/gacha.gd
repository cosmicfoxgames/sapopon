extends Node2D

signal got_new_frog

@onready var anim = %AnimationPlayer

var is_hovering

func _ready() -> void:
	anim.play("idle")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("game_click") and is_hovering == true:
		get_gacha()

func get_gacha():
	anim.play("gacha")
	await anim.animation_finished
	anim.play("idle")
	
	got_new_frog.emit()

#signals

func _on_area_2d_mouse_entered() -> void:
	is_hovering = true

func _on_area_2d_mouse_exited() -> void:
	is_hovering = false
