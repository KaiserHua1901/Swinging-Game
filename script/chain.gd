extends Node2D
@onready var chain = %Sprite
@onready var ray_cast = %RayCast
var distant: float = 100

signal hook(hook_position)


func _process(delta):
	#print(distant) 
	pass
func interpolate(length, duration = 0.2):
	var tween_offset = chain.create_tween()
	var tween_rect_h = chain.create_tween()
	
	tween_offset.tween_property(chain, "offset", Vector2(length/2.0, 0), duration)
	tween_rect_h.tween_property(chain, "region_rect", Rect2(0,0,length,16), duration)
	
func _input(event):
	if event.is_action_pressed("hook"):
		look_at(get_global_mouse_position())
		interpolate(await check_collision(), 0.2)
		await chain.get_tree().create_timer(0.2).timeout
		reverse_interpolate()

func reverse_interpolate():
	interpolate(0, .5)
	
func check_collision():
	await get_tree().create_timer(0.2).timeout
	var collision_point = null
	if ray_cast.is_colliding():
		collision_point = ray_cast.get_collision_point()
		distant = (global_position - collision_point).length()
		hook.emit(collision_point)
	else: 	
		distant = 100
	return distant

