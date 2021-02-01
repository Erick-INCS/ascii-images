# CUI Interactive applications menu for Linux
This is an Console User Interface application writen in Julia that allows you to see and open your installed applications

## Demo
<img src="img/demo.gif" style="margin: 0 auto;"></img>

## How to run
- Install the required julia package (only the first time)
```julia
# In the julia REPL
]
add Images, ImageIO, ImageMagick
#backspace
using Images, ImageIO, ImageMagick ## To compile the package
```
- Run
```shell
./menu.jl
#for windows: julia menu.jl
```
