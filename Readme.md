# comma-api-rb

API Client for api.comma.ai

### Usage

#### Comma API


```rb
me = CommaAPI.me()
puts("me:", me) #=> {"email":"makevoid@example.com","id":"12345....","points":2708,"prime":null,"regdate":1563123456,"superuser":false,"upload_video":false,"username":"antani12345"}
```

#### Athena API

Your EON needs to be on for these calls to work

```rb
state = AthenaAPI.carState()
puts("carState:", carState) #=> { ... }
## access carState as hash/dict
# carstate = state["carState"]
# wheelSpeedRL = carstate["wheelSpeeds"]["rl"]
# steeringTorque = carstate["steeringTorque"]
# steeringAngle = carstate["steeringAngle"]
# brake = data.carState["brake"]
# # puts wheelSpeedRL

# soon: access carstate via methods (getters, call without `()`, optional)
state = AthenaAPI.carState.speed()
state = AthenaAPI.carState.brake()
state = AthenaAPI.carState.steering.angle()
state = AthenaAPI.carState.steering.torque()
#
```


See more in the examples contained in the `example` (duh) dir.

enjoy :)

### Install

    bundle

### Run

    bundle exec rake


---

Have fun with OP!

@makevoid
