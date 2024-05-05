extends Node2D
@onready var chain = $Chain
@onready var colliding_object = %CollidingObject
var distant: float = 150.0
func _ready():
	chain.visible = false
	
func chain_to_move(length, duration = .2, finined = true):
	var tween_rect_w = chain.create_tween()
	var tween_offset = chain.create_tween()
	tween_rect_w.tween_property(chain, "region_rect", Rect2(0, 6, length, 4), duration)
	tween_offset.tween_property(chain, "offset",Vector2(length/2, 0), duration)

	
func on_chain_finished():
	await get_tree().create_timer(.3).timeout
	chain_to_move(0, 0.5)
	
	
func _input(event):
	if event.is_action_pressed("reload"):
		get_tree().reload_current_scene()
		
	if event.is_action_pressed("hook"):
		chain.visible = true
		look_at(get_global_mouse_position())
		chain_to_move(150)
	elif event.is_action_released("hook"):
		on_chain_finished()

