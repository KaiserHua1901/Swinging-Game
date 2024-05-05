extends Node2D

@onready var chain = $Chain
@onready var colliding_object = %CollidingObject
@onready var distant = 150.0
func chain_to_move(length = 0, duration = .2):
	var tween_rect_w = chain.create_tween()
	var tween_offset = chain.create_tween()
	tween_rect_w.tween_property(chain, "region_rect", Rect2(0, 6, length, 4), duration)
	tween_offset.tween_property(chain, "offset",Vector2(length/2, 0), duration)
	#if tween_rect_w.is_running():
		#return true
	#if not tween_rect_w.is_running():
		#return false

func chain_reverse():
	await get_tree().create_timer(.8).timeout
	chain_to_move(0)


func _input(event):
	var click = false
	if event.is_action_pressed("hook"):
		look_at(get_global_mouse_position())
		chain_to_move(colliding())

	if event.is_action_released("hook"):
		click = false
		chain_reverse() 
		print(rotation)
		
func colliding():
	if colliding_object.is_colliding():
		var hook_pos = colliding_object.get_collision_point()
		distant = (chain.global_position - hook_pos - Vector2(-20, 0)).length()
		return distant
	else:
		return distant 
		
		



	
