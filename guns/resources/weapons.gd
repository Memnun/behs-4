class_name Weapons extends Resource


@export var name : StringName
@export_category("Weapon Orientation")
@export var position : Vector3
@export var rotation : Vector3
@export_category("Visual Settings")
@export var mesh : PackedScene
@export var sprint_FOV_zoom : float
@export var ADS_FOV_zoom : float
@export_category("Weapon Stats")
@export var hitscan : bool
@export var can_ADS : bool
@export var scan_range : float
@export var projectile : String
@export var fire_speed : float
@export_category("Movement Stats")
@export var run_speed : float
@export var sprint_speed : float
@export var ads_speed : float
