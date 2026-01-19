extends Node3D

@export var CLASS_TYPE : Classes:
	set(value):
		CLASS_TYPE = value
		load_class()


@export var class_skin : Node
@onready var weapon = $"../Camera3D/Weapon"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon.WEAPON_TYPE = CLASS_TYPE.primary_weapon
	load_class()

func load_class() -> void:
	#for n in get_children(): n.queue_free()
	#class_skin = CLASS_TYPE.mesh.instantiate()
	#class_skin.set_name("ClassSkin")
	position = CLASS_TYPE.position
	rotation_degrees = CLASS_TYPE.rotation
