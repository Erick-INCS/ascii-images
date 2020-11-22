using Images, FileIO

imagePath = "abiword.png"
img = load(imagePath)

chars = [' ', '·', '+', '/','#', '▓']

function set0s(px)
    if px.alpha < 0.1
        return RGBA(0, 0, 0, 0)
    else 
        return px
    end
end

function toChar(n)
   for i = 1:size(chars)[1]
       if n < 1/size(chars)[1]*i
	   return chars[i]
       end
   end
   return last(chars)
end

function printAsciiImg(img)
    for i = 1:size(img)[1]
       for ii = 1:size(img)[2]
	   print(img[i,ii])
       end
       println()
   end
end

img = imresize(img, 20, 20)
img = map(set0s, img)
img = Gray.(img)
img = channelview(img)

# save("result.png", Gray.(map(setTo0, img)))

img = map(toChar, img)
printAsciiImg(img)
