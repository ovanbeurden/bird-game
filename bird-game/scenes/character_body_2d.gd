extends CharacterBody2D

var down_speed = 0

func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta
        
    if $Area2D.dragging:
        global_position = get_global_mouse_position() + $Area2D.drag_offset

    move_and_slide()

    for i in range(get_slide_collision_count()):
        var collision = get_slide_collision(i)
        var body = collision.get_collider()

        if body is RigidBody2D:
            print("Touching rigid body:", body.name)
