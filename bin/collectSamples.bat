:: This script starts VLC and open live stream with traffic lights 
:: Then it crops the video and periodically saves current frame to the files sequence

:: Author: Tomasz Ceszke 2017

"C:\Program Files\VideoLAN\VLC\vlc.exe" http://ls.tkchopin.pl:1935/live/orzeszkowa.stream/playlist.m3u8 --no-audio --video-filter=croppadd:scene --croppadd-croptop=90 --croppadd-cropbottom=860 --croppadd-cropleft=1050 --croppadd-cropright=770 --scene-format=png --scene-path="..\datasource\collected" --scene-prefix=scene%TIME:~9,2% --scene-ratio=50 --no-scene-replace