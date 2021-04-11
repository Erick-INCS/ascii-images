# CUI Interactive applications menu for Linux
This is an Console User Interface application writen in Julia that allows you to see and open your installed applications

## Demo
<img src="img/demo.gif" style="margin: 0 auto;"></img>

## How to run
- Install the required julia package (only the first time)
```julia
# In the julia REPL
]
activate .
add Images, ImageIO, ImageMagick, FileIO
#backspace here
using Images, ImageIO, ImageMagick, FileIO ## To compile the package, only needed for version < 1.6
```

- Test the app
```shell
./precompile.jl
```

- Create sysimage (optional)
```julia
# In julia REPL
]
add PackageCompiler
#backspace here
create_sysimage([:Images, :ImageIO, :ImageMagick, :FileIO], sysimage_path="image.so", precompile_execution_file="precompile.jl")
```

- Run
```shell
./menu.jl
# for windows: julia menu.jl
# with sysimage
julia -Jimage.so menu.jl
```
