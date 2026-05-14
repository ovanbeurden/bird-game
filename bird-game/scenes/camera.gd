extends Node2D
var cursor_close
var cursor_open
var mouse_size = 32

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var cursor_open_img = load("res://sprites/cursor open.png").get_image()
    cursor_open_img.resize(mouse_size, mouse_size)
    cursor_open = ImageTexture.create_from_image(cursor_open_img)    
    var cursor_close_img = load("res://sprites/cursor close.png").get_image()
    cursor_close_img.resize(mouse_size, mouse_size)
    cursor_close = ImageTexture.create_from_image(cursor_close_img)
    Input.set_custom_mouse_cursor(cursor_open, Input.CURSOR_ARROW, Vector2(mouse_size/2, mouse_size/2))
    

func _input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:

        if event.pressed:
            Input.set_custom_mouse_cursor(cursor_close, Input.CURSOR_ARROW, Vector2(mouse_size/2, mouse_size/2))
        else:
            Input.set_custom_mouse_cursor(cursor_open, Input.CURSOR_ARROW, Vector2(mouse_size/2, mouse_size/2))
