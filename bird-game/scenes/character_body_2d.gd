extends CharacterBody2D

var down_speed = 0
var score = 0.0
var inv_scale_factor = 700
var birdstatus = 1
var mouth_close_time_left := 0.0

@export var bird_data: BirdData = preload("res://resources/bluebird.tres")
@onready var grab_player = $GrabPlayer
@onready var gulp_player = $GulpPlayer
@onready var not_tasty_player = $NotTastyPlayer
@onready var die_player = $DiePlayer
@onready var main = get_tree().get_root().get_node("BirdGame")

func _ready() -> void:
    print("My bird data: ", bird_data)
    print("My bird color: ", bird_data.color)
    $Area2D.area_entered.connect(_on_area_2d_area_entered)
    $Area2D/Sprite2D.sprite_frames = bird_data.texture_open
    grab_player.stream = bird_data.grab_sound
    gulp_player.stream = bird_data.eat_sound
    not_tasty_player.stream = bird_data.not_tasty_sound
    die_player.stream = bird_data.die_sound

func _physics_process(delta: float) -> void:
    mouth_close_time_left = maxf(0.0, mouth_close_time_left - delta)

    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta

    move_and_slide()
            
    if $Area2D.dragging:
        global_position = get_global_mouse_position() + $Area2D.drag_offset
        velocity = velocity*0

    if birdstatus == 0:
        $Area2D/Sprite2D.sprite_frames = bird_data.texture_dead
    elif mouth_close_time_left > 0.0:
        $Area2D/Sprite2D.sprite_frames = bird_data.texture_close
    elif $Area2D.dragging:
        $Area2D/Sprite2D.sprite_frames = bird_data.texture_hold
    else:
        $Area2D/Sprite2D.sprite_frames = bird_data.texture_open
        
    $Area2D/Sprite2D.play()
                
    scale = Vector2(score/inv_scale_factor+0.1, score/inv_scale_factor+0.1)


func _on_area_2d_area_entered(area: Area2D) -> void:
    if area is not Nut:
        return

    if bird_data == null or area.nut_data == null:
        return

    if birdstatus == 0:
        return

    mouth_close_time_left = 0.5
    $Area2D/Sprite2D.sprite_frames = bird_data.texture_close
    if bird_data.color.to_lower() == area.nut_data.color.to_lower():
        score += area.nutscore
        main.global_score += area.nutscore
        print(main.global_score)
        play_gulp_sound()
    else:
        if score < area.nutscore*2:
            score = 0.0
            birdstatus = 0
            play_die_sound()
        else:
            score -= area.nutscore*2
            main.global_score -= area.nutscore/2
            play_not_tasty_sound()

   
    area.queue_free()
    

func play_grab_sound():
    grab_player.play();

func play_gulp_sound():
    gulp_player.play()

func play_not_tasty_sound():
    not_tasty_player.play();
    
func play_die_sound():
    die_player.play();
