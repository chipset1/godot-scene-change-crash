# Godot bug reproduction project

Changing scenes crashes the game only on the second time the game is run.

To recreate the crash goto the door and press j. Close and reload the game and
goto the door and press j and the game should crash. If it doesn't crash rerun
the game and do it again it. Some times it take a few times and on the latest
build it takes many restarts for it to crash.

Windows 11 but system info sayes 10 for some reason.

Godot v4.3.stable - Windows 10.0.22631 - Vulkan (Forward+) - dedicated NVIDIA GeForce RTX 4070 (NVIDIA; 32.0.15.6603) - AMD Ryzen 7 7800X3D 8-Core Processor (16 Threads)

When run with a debug build found here
https://github.com/Calinou/godot-debug-builds I get the error

```
CrashHandlerException: Program crashed
Engine version: Godot Engine v4.3.stable.custom_build (77dcf97d82cbfe4e4615475fa52ca03da645dbd8)
Dumping the backtrace. Please include this when reporting the bug to the project developer.
[0] <couldn't map PC to fn name>
[1] <couldn't map PC to fn name>
[2] <couldn't map PC to fn name>
[3] <couldn't map PC to fn name>
[4] <couldn't map PC to fn name>
[5] <couldn't map PC to fn name>
[6] <couldn't map PC to fn name>
[7] <couldn't map PC to fn name>
[8] <couldn't map PC to fn name>
[9] <couldn't map PC to fn name>
[10] <couldn't map PC to fn name>
[11] <couldn't map PC to fn name>
-- END OF BACKTRACE --
```

same as the issue here
https://github.com/godotengine/godot/issues/94112

I compiled godot with mingw64 with these parameters.

scons platform=windows use_mingw=yes target=editor dev_build=yes debug_symbols=yes

and I didn't get an backtrace and the game crashes after you rerun the game and
change scene a few times in this build.
```
================================================================
CrashHandlerException: Program crashed with signal 11
Engine version: Godot Engine v4.4.dev.custom_build (dc5f1b7a2826962f02230227abc486ac160ae66c)
Dumping the backtrace. Please include this when reporting the bug to the project developer.
```