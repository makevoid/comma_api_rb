## dl_route_example

    [ruby] [docker]


this tiny script downloads OP drives from "the cloud" to your box


#### call this script via docker (recommended):

    docker run -e ROUTE_ID="abcdef1234567890|2020-01-01--00-00-00" -e JWT_TOKEN="xxxxxxxxx" -v $(pwd):/app/route makevoid/comma_ai_download_drive

pass LOGS=1 to download all the logs:

    docker run -e ROUTE_ID="abcdef1234567890|2020-01-01--00-00-00" -e LOGS=1 -e JWT_TOKEN="xxxxxxxxx" -v $(pwd):/app/route makevoid/comma_ai_download_drive

#### call via plain ruby:

    ruby dl_route_example.rb ROUTE_ID="xxxxxxxx" JWT_TOKEN="xxxxxxxxx"


---

#### Get your JWT TOKEN

https://jwt.comma.ai/

log in with your google account, your Comma JWT token will get shown on the page, copy it and paste it in the docker script, it will be used to download the route files

---

note: you have to configure a working ruby environment to run this

run one of the two scripts, these download to the current directory a bunch of video files of your OP drive
use VLC or a similar app to play them

enjoy!

@makevoid
