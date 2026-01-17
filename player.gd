extends CharacterBody3D

@onready var camera = $Camera3D
@onready var anim_player = $AnimationPlayer

@onready var shotgun = $Camera3D/shotgun
@onready var dmr = $Camera3D/dmr

const SPEED = 5.0
const SPRINT = 1.6
const JUMP_VELOCITY = 4.5
const MOUSE_SENS = 0.005
const FOV = 75.0

var Jumps = 2
const MaxJumps = 2

var isADS = false
var isShooting = false
var currentWeapon = 0

var isSprinting = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		if isADS:
			rotate_y(-event.relative.x * MOUSE_SENS * 0.5)
			camera.rotate_x(-event.relative.y * MOUSE_SENS * 0.5)
		else:
			rotate_y(-event.relative.x * MOUSE_SENS)
			camera.rotate_x(-event.relative.y * MOUSE_SENS)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
	
	if Input.is_action_just_pressed("shoot") and isShooting == false:
		play_shoot_effects()
	
	if Input.is_action_just_pressed("alt_fire") and dmr.visible:
		isADS = true
	elif Input.is_action_just_released("alt_fire") and dmr.visible:
		isADS = false
	
	if Input.is_action_just_pressed("weapon_switch_down"):
		dmr.hide()
		shotgun.hide()
		currentWeapon = (currentWeapon+1)%3
		if currentWeapon == 1:
			dmr.show()
		elif currentWeapon == 2:
			shotgun.show()
	
	if Input.is_action_just_pressed("weapon_switch_up"):
		dmr.hide()
		shotgun.hide()
		currentWeapon = (currentWeapon+2)%3
		if currentWeapon == 1:
			dmr.show()
		elif currentWeapon == 2:
			shotgun.show()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Jumps != MaxJumps and is_on_floor():
		Jumps = MaxJumps
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and Jumps != 0:
		velocity.y = JUMP_VELOCITY
		Jumps -= 1
	
	if Input.is_action_pressed("sprint"):
		isSprinting = true
	else:
		isSprinting = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var targetSpeed := SPEED * (SPRINT if isSprinting else 1.0) * (0.5 if isADS else 1.0)
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * targetSpeed
		velocity.z = direction.z * targetSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, targetSpeed)
		velocity.z = move_toward(velocity.z, 0, targetSpeed)
		
	if isShooting:
		if anim_player.current_animation != "shoot" \
				and anim_player.current_animation != "ads_fire":
			isShooting = false
		else:
			pass
	else:
		if isADS and dmr.visible:
			anim_player.play("ads")
		elif input_dir != Vector2.ZERO and is_on_floor():
			anim_player.play("move")
		else:
			anim_player.play("idle")
	
	#FOV from speed
	var targetFOV := FOV * (1.2 if (isSprinting and input_dir != Vector2.ZERO) else 1.0) * (0.6 if isADS else 1.0)
	camera.fov = lerp(camera.fov, targetFOV, 0.2)
	
	move_and_slide()

func play_shoot_effects():
	isShooting = true
	anim_player.stop()
	if isADS:
		anim_player.play("ads_fire")
	else:
		anim_player.play("shoot")
