extends Node2D

var cursor_close
var cursor_open
var mouse_size = 64
var hide_system_cursor := false
var birdlife = 3

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
    

func _process(_delta: float) -> void:
    cursor_sprite.position = get_viewport().get_mouse_position()
    
    birdlife = $BirdGuy.birdstatus + $BirdGuy2.birdstatus + $BirdGuy3.birdstatus
    if birdlife == 0:
        game_over()
        # TODO: stop everything and game over
        


func _input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.pressed:
            cursor_sprite.texture = cursor_close
        else:
            cursor_sprite.texture = cursor_open

func _exit_tree() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

            
func game_over():
    get_tree().paused = true
    $GameOver.visible = true
