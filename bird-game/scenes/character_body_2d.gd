extends CharacterBody2D

var down_speed = 0
var score = 0.0
@export var bird_data: BirdData = preload("res://resources/bluebird.tres")

func _ready() -> void:
    print(bird_data)
    $Area2D/Sprite2D.texture = bird_data.texture_open

func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta

    move_and_slide()
            
    if $Area2D.dragging:
        global_position = get_global_mouse_position() + $Area2D.drag_offset
        velocity = velocity*0
        $Area2D/Sprite2D.texture = bird_data.texture_hold
    else:
        $Area2D/Sprite2D.texture = bird_data.texture_open

    for i in range(get_slide_collision_count()):
        var collision = get_slide_collision(i)
        var body = collision.get_collider()

        if body is RigidBody2D:
            print("Touching rigid body:", body.name)
            if body.name == "Nut":
                $Area2D/Sprite2D.texture = bird_data.texture_close
                score += body.nutscore
                print(score)
                # TODO: remove nut
                
    #scale = Vector2(score/10000+0.1, score/10000+0.1)
    print(score)
    
