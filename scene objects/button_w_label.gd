extends Control

@onready var anim = %AnimationPlayer
@onready var show_label = %Label
@onready var show_icon = %Icon

@export var label : String
@export var icon : Resource

var is_hovering = false

func _ready() -> void:
	set_button()

func _process(delta: float) -> void:
	#print(is_hovering)
	if Input.is_action_just_released("game_click") and is_hovering == true:
		anim.play("click")
		on_click()

func set_button():
	show_label.text = label
	if icon != null: show_icon.texture = icon

func on_click():
	ButtonActions.clicked_on_button(label)

#signals

func _on_area_2d_mouse_entered() -> void:
	is_hovering = true
	anim.play("in")
	await anim.animation_finished

func _on_area_2d_mouse_exited() -> void:
	is_hovering = false
	anim.play("out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if is_hovering == true:
		anim.play("hover")
	else: anim.clear_queue()
