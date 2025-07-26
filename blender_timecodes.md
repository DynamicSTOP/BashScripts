# blender timecodes

recording this, since i am dumb and will 100% forget it

1. Open blender in video editing mode
2. In sequenser add a text strip and rename it to "Timecode"
3. \[OPTIONAL\] in case video was speed up. In sequenser select video strip -> shift+a -> effect strip -> speed control. Name of the strip should be "Speed". Uncomment **\[optional\]** code bellow   
4. click run script (looks like play button)
5. text strip start should be aligned with video strip start

```python
# most of the code is by Scott McPeak https://blender.stackexchange.com/a/165951
import bpy

scene = bpy.context.scene
obj = scene.sequence_editor.sequences_all['Timecode']
fps = scene.render.fps
# [optional]
# speed = scene.sequence_editor.sequences_all['Speed'].speed_factor

def recalculate_text(scene):
    # Number of frames since the start of the text strip.
    # [optional] 
    # frames = (scene.frame_current - obj.frame_start) * speed
    frames = (scene.frame_current - obj.frame_start) * speed

    # Divide to get hours, minutes, seconds, and hundredths of a second.
    seconds_float = frames / fps
    seconds = int(seconds_float)
    hundredths = int((seconds_float - seconds) * 100)
    minutes = int(seconds / 60)
    seconds -= minutes * 60
    hours = int(minutes / 60)
    minutes -= hours * 60

    # Combine as a string.
    time_string = "{:02d}:{:02d}:{:02d}.{:02d}".format(
        hours, minutes, seconds, hundredths)

    # Update the text object.    
    #print('Recalc: ' + time_string)
    obj.text = time_string

# This is used when moving between frames during editing.
bpy.app.handlers.frame_change_pre.clear()
bpy.app.handlers.frame_change_pre.append(recalculate_text)

# This is used during animation rendering.
bpy.app.handlers.render_pre.clear()
bpy.app.handlers.render_pre.append(recalculate_text)

```
