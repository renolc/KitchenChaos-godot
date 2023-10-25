# KitchenChaos-godot

This is an adaptation of [CodeMonkey](https://unitycodemonkey.com)'s excellent [KitchenChaos](https://youtu.be/AmGSEH7QcDg) game, ported into Godot 4.1.2.stable.

I tried to stay as faithful to the original game as possible, but I didn't want to port the code 1-to-1. Instead, I tried to do things the Godot-way, or at least as best I could. And so, the code is written entirely in gdscript rather than C#, and the structure of the game may be a bit different. The end result should be roughly the same though.

### Notes and Changes

- all models were converted into gltf
- all animations, shaders, and particles were recreated directly within godot by hand <br/> (they are probably not 100% the same, but close enough)
- Godot doesn't have world canvases, so in-world UIs were created with Sprite3D's using SubViewport textures
- the code isn't nearly as type safe -- I used types where I felt it made sense, but I didn't go out of my way to type everything everywhere
- I tried out the `forward+` renderer at first, but my laptop worked better with `mobile` instead, and I got it looking pretty close to the originally regardless
- a few places used textures in the original, but I opted for shaders instead

### Maybe Godot-bugs I ran into

Note, these may not be actual bugs, but maybe something I'm doing wrong myself. Unsure.

- Sprite3D's set to have SubViewport textures don't work when set in the edtor -- instead I had to set them in code
- if I instantiate a node and set a property on it immediately, sometimes it would complain that the node wasn't ready yet -- I got around this by adding `await ready` at the start of the property setter
