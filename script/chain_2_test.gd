extends Node2D

@onready var chain = $Chain
@onready var ray_cast = $CollidingObject
var length = 100



# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):

	if event.is_action_pressed("hook"):
		look_at(get_global_mouse_position())
		move_the_chain()

func move_the_chain():
	length += 100
	chain.region_rect = Rect2(0, 6, length, 4)