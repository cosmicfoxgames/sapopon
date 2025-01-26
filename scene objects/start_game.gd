extends Node2D

signal finished_title_animation_in

@onready var anim = %AnimationPlayer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func start_title_screen():
	anim.play("title_in")
	await anim.animation_finished
	finished_title_animation_in.emit()
