:: This script starts VLC and open live stream with traffic lights 
:: Then it crops the video and periodically saves current frame to the files sequence

:: Author: Tomasz Ceszke 2017

"C:\Program Files (x86)\VideoLAN\VLC\vlc.exe" http://ls.tkchopin.pl:1935/live/orzeszkowa.stream/playlist.m3u8  -I dummy -V dummy --no-audio --video-filter=croppadd:scene --croppadd-croptop=136 --croppadd-cropbottom=830 --croppadd-cropleft=1550 --croppadd-cropright=286 --scene-format=png --scene-path="C:\Users\tomek\OneDrive\Projects\Machine Learning\traffic-light-detection\datasource\traffic_lights_wejherowo\train" --scene-prefix=scene%TIME:~9,2% --scene-ratio=50 --no-scene-replace