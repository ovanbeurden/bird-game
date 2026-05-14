@tool
extends Node

func _process(_delta):
    if not Engine.is_editor_hint():
        return

    var bird = get_parent()
    if not bird:
        return

    if not bird.bird_data:
        return

    var sprite = bird.get_node("Area2D/Sprite2D")
    sprite.texture = bird.bird_data.texture_open
