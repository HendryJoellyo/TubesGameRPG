class_name State_Attack extends State

var attacking : bool = false

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"


func Enter() -> void:
	player.UpdateAnimation("attack")
	attack_anim.play("attack_" + player.AnimDirection())
	animation_player.animation_finished.connect(EndAttack)
	attacking = true
	pass


func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)  # Disconnect when exiting
	attacking = false
	pass



func Process(_delta : float) -> State:
	player.velocity = Vector2.ZERO
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null
	
	
	
func Physics(_delta : float) -> State:
	return null
	
	
	
func HandleInput(_event : InputEvent) -> State:
	return null

func EndAttack( _newAnimName : String ) -> void:
	attacking = false
	
	