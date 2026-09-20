class_name LevelSceneTransition extends CanvasLayer
#used to hide the level loading :)

@onready var animation_player: AnimationPlayer = $SceneTransition/AnimationPlayer

#The transition fades in, when the animation finishes it returns true
func fade_in() -> bool:
	animation_player.play("fade_in")
	await animation_player.animation_finished
	return true
	
#The transition fades out, when the animation finishes it returns true
func fade_out() -> bool:
	animation_player.play("fade_out")
	await animation_player.animation_finished
	return true
