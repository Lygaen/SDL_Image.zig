const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "SDL_Image.zig",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });
    const sdl_dep = b.dependency("sdl", .{
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(sdl_dep.artifact("SDL3"));
    b.installArtifact(lib);
    lib.linkLibrary(sdl_dep.artifact("SDL3"));

    lib.defineCMacro("USE_STBIMAGE", "1");
    lib.defineCMacro("LOAD_BMP", "1");
    lib.defineCMacro("LOAD_GIF", "1");
    lib.defineCMacro("LOAD_JPG", "1");
    lib.defineCMacro("LOAD_PNG", "1");
    lib.defineCMacro("LOAD_SVG", "1");
    lib.defineCMacro("LOAD_TGA", "1");

    lib.addCSourceFiles(.{
        .files = &[_][]const u8{
            "IMG_avif.c",
            "IMG_bmp.c",
            "IMG_gif.c",
            "IMG_jpg.c",
            "IMG_jxl.c",
            "IMG_lbm.c",
            "IMG_pcx.c",
            "IMG_png.c",
            "IMG_pnm.c",
            "IMG_qoi.c",
            "IMG_stb.c",
            "IMG_svg.c",
            "IMG_tga.c",
            "IMG_tif.c",
            "IMG_webp.c",
            "IMG_WIC.c",
            "IMG_xcf.c",
            "IMG_xpm.c",
            "IMG_xv.c",
            "IMG_xxx.c",
            "IMG.c",
        },
        .root = b.path("SDL_image/src/"),
        .flags = &[_][]const u8{"-std=c99"},
    });
    lib.addIncludePath(b.path("SDL_image/include/"));
    lib.addSystemIncludePath(b.path("SDL3/"));
    lib.installHeader(b.path("SDL_image/include/SDL3_image/SDL_image.h"), "SDL3_image/SDL_image.h");
}
