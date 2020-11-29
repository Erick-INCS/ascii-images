module AImages

using Images, FileIO

export asciiImage, printAsciiImg

imagePath = "abiword.png"
imgSize = 20
chars = [' ', '·', '+', '/','#', '▓']

function set0s(px)
    if px.alpha < 0.1
	typeof(px) == ColorTypes.RGBA{FixedPointNumbers.Normed{UInt32,32}} && return RGBA{N0f32}(0, 0, 0, 0)
	typeof(px) == ColorTypes.RGBA{FixedPointNumbers.Normed{UInt16,16}} && return RGBA{N0f16}(0, 0, 0, 0)
	typeof(px) == ColorTypes.RGBA{FixedPointNumbers.Normed{UInt8,8}} && return RGBA(0, 0, 0, 0)
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

function asciiImage(path::String)

    img = RGBA.(load(path))
    img = imresize(img, imgSize, imgSize)
    img = map(set0s, img)
    img = Gray.(img)
    img = channelview(img)

    # save("result.png", Gray.(map(setTo0, img)))

    img = map(toChar, img)
end

#printAsciiImg(
#	      asciiImage("/usr/share/icons/hicolor/16x16/apps/display-im6.q16.png")
#	      asciiImage("/usr/share/icons/hicolor/256x256/apps/com.obsproject.Studio.png")
#	      )
# print(PROGRAM_FILE)

end
