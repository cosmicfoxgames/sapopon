extends Control

@onready var label = %Label
@onready var anim = %AnimationPlayer
@onready var timer = %Timer

func _ready() -> void:
	GlobalSignals.show_warning.connect(_on_show_warning)

func _process(delta: float) -> void:
	pass

func set_warning(warning : String):
	timer.stop()
	label.text = warning
	anim.play("in")
	await anim.animation_finished
	timer.start(6)
	anim.play("out")

#signals

func _on_show_warning(warning):
	print("veio pro show warinig")
	set_warning(warning)
