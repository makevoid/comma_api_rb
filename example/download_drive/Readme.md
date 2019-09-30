## dl_route_example

    [ruby] [docker]


this tiny script downloads OP drives from "the cloud" to your box


#### call this script via docker (recommended):

    docker run -e ROUTE_ID="xxxxxxxx" makevoid/comma_ai_download_drive

pass LOGS=1 to download all the logs:

    docker run -e ROUTE_ID="xxxxxxxx" -e LOGS=1 makevoid/comma_ai_download_drive


#### call via plain ruby:

    ruby dl_route_example.rb ROUTE_ID="xxxxxxxx"


---

note: you have to configure a working ruby environment to run this

run one of the two scripts, these download to the current directory a bunch of video files of your OP drive
use VLC or a similar app to play them

enjoy!

@makevoid
