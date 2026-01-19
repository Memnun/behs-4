extends Node3D

@export var WEAPON_TYPE : Weapons:
	set(value):
		WEAPON_TYPE = value
		load_weapon()


@export var weapon_mesh : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func load_weapon() -> void:
	for n in get_children(): n.queue_free()
	if WEAPON_TYPE.is_melee and WEAPON_TYPE.hitscan:
		weapon_mesh = WEAPON_TYPE.alt_mesh.instantiate()
	else:
		weapon_mesh = WEAPON_TYPE.mesh.instantiate()
	weapon_mesh.set_name("WeaponMesh")
	add_child(weapon_mesh)
	position = WEAPON_TYPE.position
	rotation_degrees = WEAPON_TYPE.rotation
