extends CharacterBody3D

@onready var camera = $Camera3D

@onready var weapon = $Camera3D/Weapon
@onready var player_class = $Class

const MOUSE_SENS = 0.005

var Jumps = 0

var isADS = false
var isShooting = false
var currentWeapon = 1

var isSprinting = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		if isADS:
			rotate_y(-event.relative.x * MOUSE_SENS * weapon.WEAPON_TYPE.ADS_FOV_zoom)
			camera.rotate_x(-event.relative.y * MOUSE_SENS * weapon.WEAPON_TYPE.ADS_FOV_zoom)
		else:
			rotate_y(-event.relative.x * MOUSE_SENS)
			camera.rotate_x(-event.relative.y * MOUSE_SENS)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
	
	if Input.is_action_pressed("alt_fire") and weapon.WEAPON_TYPE.can_ADS == true:
		isADS = true
	else:
		isADS = false
	
	if Input.is_action_just_pressed("weapon_switch_down"):
		currentWeapon = (currentWeapon+1)%3
		if currentWeapon == 1:
			weapon.WEAPON_TYPE = player_class.CLASS_TYPE.primary_weapon
		elif currentWeapon == 2:
			weapon.WEAPON_TYPE = player_class.CLASS_TYPE.secondary_weapon
		else:
			weapon.WEAPON_TYPE = player_class.CLASS_TYPE.melee_weapon
	
	if Input.is_action_just_pressed("weapon_switch_up"):
		currentWeapon = (currentWeapon+2)%3
		if currentWeapon == 1:
			weapon.WEAPON_TYPE = player_class.CLASS_TYPE.primary_weapon
		elif currentWeapon == 2:
			weapon.WEAPON_TYPE = player_class.CLASS_TYPE.secondary_weapon
		else:
			weapon.WEAPON_TYPE = player_class.CLASS_TYPE.melee_weapon

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += Vector3.DOWN * player_class.CLASS_TYPE.gravity * delta
	
	if Jumps != player_class.CLASS_TYPE.jumps and is_on_floor():
		Jumps = player_class.CLASS_TYPE.jumps
	
	if Input.is_action_pressed("sprint"):
		isSprinting = true
	else:
		isSprinting = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var targetSpeed = 0.0
	if direction != Vector3.ZERO:
		targetSpeed = get_move_speed()
	if direction:
		velocity.x = move_toward(velocity.x, targetSpeed * direction.x, abs(player_class.CLASS_TYPE.ground_accel))
		velocity.z = move_toward(velocity.z, targetSpeed * direction.z, abs(player_class.CLASS_TYPE.ground_accel))
	else:
		velocity.x = move_toward(velocity.x, targetSpeed * direction.x, abs(player_class.CLASS_TYPE.ground_friction))
		velocity.z = move_toward(velocity.z, targetSpeed * direction.z, abs(player_class.CLASS_TYPE.ground_friction))
		
	#FOV from speed
	var targetFOV = player_class.CLASS_TYPE.base_FOV * \
			(weapon.WEAPON_TYPE.sprint_FOV_zoom if (isSprinting and input_dir != Vector2.ZERO) else 1.0) * \
			(weapon.WEAPON_TYPE.ADS_FOV_zoom if isADS else 1.0)
	camera.fov = lerp(camera.fov, targetFOV, 0.2)
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and Jumps > 0:
		velocity.y = player_class.CLASS_TYPE.jump_strength
		Jumps -= 1
		
	move_and_slide()

func get_move_speed() -> float:
	return player_class.CLASS_TYPE.run_speed * weapon.WEAPON_TYPE.run_speed * \
			(weapon.WEAPON_TYPE.sprint_speed if isSprinting else 1.0) * \
			(weapon.WEAPON_TYPE.ads_speed if isADS else 1.0)
