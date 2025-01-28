# SDL_Image.zig

Just provides a thin wrapper over [SDL_Image](https://github.com/libsdl-org/SDL_image) library, which I needed for personal usage.

## Maintenance
This repo might or might not work...
Idk. Open an issue if it doesn't, I'm not maintaining it 24/7 but try to at least make it working.

## Usage in Zig
As for many libraries in zig :

First fetch it
```sh
zig fetch --save git+https://github.com/Lygaen/SDL_Image.zig
```

Then add it
```diff
const std = @import("std");

pub fn build(b: *std.Build) void {
    // -- snip --

+    const sdlimage_dep = b.dependency("SDL_Image.zig", .{
+        .target = target,
+        .optimize = optimize,
+    });

    // Where `exe` represents your executable/library to link to
+    exe.linkLibrary(sdlimage_dep.artifact("SDL_Image.zig"));

    // -- snip --
}
```

And in your file where you want to *enjoy* SDL_Image :
```diff
const std = @import("std");

+ const c = @cImport({
+    @cInclude("SDL3_image/SDL_image.h");
+ });

// -- snip --
```

And *voilà* ! You're done.

## License

[**WTFPL – Do What the Fuck You Want to Public License**](http://www.wtfpl.net/)
