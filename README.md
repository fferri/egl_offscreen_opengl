egl_offscreen_opengl
====================

Example program for creating an OpenGL context with EGL for offscreen rendering with a framebuffer.

Based on https://www.khronos.org/registry/egl/sdk/docs/man/html/eglIntro.xhtml.

## Running with Docker (requires [nvidia-docker](https://github.com/NVIDIA/nvidia-docker))

*Disclaimer:* It's still under development and I receive two errors that does seem to relate to the EGL version. 
*Disclaimer 2:* I used successfully a similar Dockerfile in other project where headless rendering was needed.

```bash
$ docker build -t eglopengl . 
$ docker run --gpus all --rm -it -v img:/usr/src/egl/img eglopengl
```
