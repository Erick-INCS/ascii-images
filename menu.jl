include("AImages.jl")

using .AImages, REPL

mutable struct app
    name :: String
    path :: String 
    icon :: String
end
    
# Globals
appsPath = "/usr/share/applications"
files = readdir(appsPath)
apps = []

regexName = r"Name=(.*)"
regexPath = r"Exec=(.*)"
regexIcon = r"Icon=(.*)"
regexDE = r"[Desktop Entry]"
regexND = r"NoDisplay=true"

function getApp(desktop :: String)
    nm = match(regexName, desktop)
    ico = match(regexIcon, desktop)
    ph = match(regexPath, desktop)
    nd = match(regexND, desktop)
    de = match(regexDE, desktop)

    if nm !== nothing && ico !== nothing && ph !== nothing && nd === nothing && de !== nothing
	return app(nm.captures[1], ph.captures[1], ico.captures[1])
    end
end

function findImage(a::app)
    baseDir = "/usr/share/icons"
    fn = `find $baseDir -iname "$(a.icon)*"`
    qry = match(r".+(.png|.jpg|.gif){1}", read(fn, String))

    a.icon = qry !== nothing ? chomp(qry.match) : ""
    return a
end

function displayApp(a::app)
    global index
    run(`/usr/bin/clear`, wait=true)
    
    if a.icon !== ""
	img = permutedims(asciiImage(a.icon))
	img = permutedims([
	    reshape(
		[' ' for c in 1:lOffset
			for r in 1:AImages.imgSize] 
		,
		lOffset,
		:
	    )
	    ;
	    img
	])
    printAsciiImg(img)
    end

    
    println()
    for i=1:round(Int, screenSz[2]/2) - round(Int, length(a.name)/2)
	print(' ')
    end
    println(a.name)
    println("[" , index , "/" , length(apps) , "]")
end

function getKey()
    t = REPL.TerminalMenus.terminal
    REPL.TerminalMenus.enableRawMode(t) || error("unable to switch to raw mode")
    c = Char(REPL.TerminalMenus.readKey(t.in_stream))
    REPL.TerminalMenus.disableRawMode(t)
    c
end

# Process apps
apps = map(o->open(f->read(f, String), appsPath * "/" * o, "r"), files)
apps = map(getApp, apps)
apps = filter(a->a!==nothing, apps)
apps = map(findImage, apps)

const nApps = length(apps)
const screenSz = displaysize(stdout)
lOffset = round(Int, screenSz[2]/2)-round(Int, AImages.imgSize/2)

index = 1

while true
    global index
    displayApp(apps[index])
    #println(apps[5].icon)
    k = getKey()
    
    if k == 'x' || k == 'q'
	break
    elseif k == '\u03E9'
	# derecha
	index = index + 1 <= length(apps) ? index + 1 : 0;
    elseif k == '\u03E8'
	# izquierda
	index = index - 1 >= 0 ? index - 1 : length(apps);
    else
	# nothing
    end
end
#printAsciiImg(asciiImage(apps[3].icon))
#println(apps[3].name)
