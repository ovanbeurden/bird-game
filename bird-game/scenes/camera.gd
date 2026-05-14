extends Node2D

var cursor_close
var cursor_open
var mouse_size = 32
var hide_system_cursor := false
var birdlife = 3
var global_score = 0
var bomblife = 3
var final_score = 0

@onready var cursor_sprite: Sprite2D = $CursorLayer/CursorSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    hide_system_cursor = not OS.has_feature("editor")
    var cursor_open_img = load("res://sprites/cursor open.png").get_image()
    cursor_open_img.resize(mouse_size, mouse_size)
    cursor_open = ImageTexture.create_from_image(cursor_open_img)    
    var cursor_close_img = load("res://sprites/cursor close.png").get_image()
    cursor_close_img.resize(mouse_size, mouse_size)
    cursor_close = ImageTexture.create_from_image(cursor_close_img)
    cursor_sprite.texture = cursor_open
    Input.mouse_mode = Input.MOUSE_MODE_HIDDEN if hide_system_cursor else Input.MOUSE_MODE_VISIBLE
    $GameOver.visible = false
    $Label2.visible = false
    

func _process(_delta: float) -> void:
    cursor_sprite.position = get_viewport().get_mouse_position()
    $Label.text = "Score: " + str(global_score)
    birdlife = $BirdGuy.birdstatus + $BirdGuy2.birdstatus + $BirdGuy3.birdstatus
    if has_node("Area2D") or has_node("Area2D2") or has_node("Area2D3"):
        bomblife = 1
    else:
        bomblife = 0
    if birdlife == 0 or bomblife == 0:
        game_over()
    

func _input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.pressed:
            cursor_sprite.texture = cursor_close
        else:
            cursor_sprite.texture = cursor_open

func _exit_tree() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

            
func game_over():
    $GameOver.visible = true
    final_score = global_score
    $Label2.text = "Your final score: " + str(final_score)
    $Label2.visible = true
