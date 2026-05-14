extends CharacterBody2D

#var drag_offset = Vector2.ZERO
var gravity_factor = 10
var mass = 10
var down_speed = 0
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta
        
    if $Area2D.dragging:
        global_position = get_global_mouse_position() + $Area2D.drag_offset


    move_and_slide()
