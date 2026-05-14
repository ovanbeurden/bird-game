extends CharacterBody2D

var down_speed = 0
var score = 0.0
var mouth_close_time_left := 0.0
@export var bird_data: BirdData = preload("res://resources/bluebird.tres")

func _ready() -> void:
    $Area2D.area_entered.connect(_on_area_2d_area_entered)
    $Area2D/Sprite2D.texture = bird_data.texture_open

func _physics_process(delta: float) -> void:
    mouth_close_time_left = maxf(0.0, mouth_close_time_left - delta)

    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta

    move_and_slide()
            
    if $Area2D.dragging:
        global_position = get_global_mouse_position() + $Area2D.drag_offset
        velocity = velocity*0

    if mouth_close_time_left > 0.0:
        $Area2D/Sprite2D.texture = bird_data.texture_close
    elif $Area2D.dragging:
        $Area2D/Sprite2D.texture = bird_data.texture_hold
    else:
        $Area2D/Sprite2D.texture = bird_data.texture_open
                
    scale = Vector2(score/100+0.1, score/100+0.1)


func _on_area_2d_area_entered(area: Area2D) -> void:
    if area is not Nut:
        return

    if bird_data == null or area.nut_data == null:
        return

    if bird_data.color.to_lower() != area.nut_data.color.to_lower():
        return

    mouth_close_time_left = 0.5
    $Area2D/Sprite2D.texture = bird_data.texture_close
    score += area.nutscore
    area.queue_free()
    
