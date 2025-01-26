extends Node2D

signal finished_cutscene

@onready var anim = %AnimationPlayer

func _ready() -> void:
	#play_cutsene()
	pass

func _process(delta: float) -> void:
	pass

func play_cutsene():
	anim.play("new_animation")
	await anim.animation_finished
	finished_cutscene.emit()
