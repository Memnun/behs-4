class_name Classes extends Resource


@export var name : StringName
@export_category("Character Model")
@export var position : Vector3
@export var rotation : Vector3
@export_category("Visual Settings")
@export var mesh : PackedScene
@export var base_FOV : float
@export_category("Weapon Slots")
@export var primary_weapon : Resource
@export var secondary_weapon : Resource
@export var melee_weapon : Resource
@export_category("Movement Stats")
@export var run_speed : float
@export var jumps : int
@export var jump_strength : float
@export var gravity : float
@export var ground_accel : float
@export var ground_decel : float
@export var ground_friction : float
@export var air_accel : float
@export var air_friction : float
