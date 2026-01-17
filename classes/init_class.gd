extends Node3D

@export var CLASS_TYPE : Classes:
	set(value):
		CLASS_TYPE = value
		load_class()


@export var class_skin : Node
var scene_instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_class()

func load_class() -> void:
	scene_instance = CLASS_TYPE.mesh.instantiate()
	scene_instance.set_name("ClassSkin")
	add_child(scene_instance)
	class_skin = $ClassSkin
	position = CLASS_TYPE.position
	rotation_degrees = CLASS_TYPE.rotation
