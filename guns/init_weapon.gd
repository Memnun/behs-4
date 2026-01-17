extends Node3D

@export var WEAPON_TYPE : Weapons:
	set(value):
		WEAPON_TYPE = value
		load_weapon()


@export var weapon_mesh : Node
var scene_instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_weapon()

func load_weapon() -> void:
	scene_instance = WEAPON_TYPE.mesh.instantiate()
	scene_instance.set_name("WeaponMesh")
	add_child(scene_instance)
	weapon_mesh = $WeaponMesh
	position = WEAPON_TYPE.position
	rotation_degrees = WEAPON_TYPE.rotation
