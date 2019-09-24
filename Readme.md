# comma-api-rb

Unofficial API Client for the Comma API (api.comma.ai)

### Install Gem // Configure Gem Bundle

Install Gem: `gem i comma-api-rb`

Require it (`require "comma-api-rb"`)

---

Use Bundler:

```rb
gem "comma-api-rb", require: "comma-api-rb"
```

suggestion: use `Bundler.require :default #, :production, :dev...` to automatically require the comma api gem


### Configuration

Set the `COMMA_JWT_TOKEN` environment variable with your Comma API JWT token

```
COMMA_JWT_TOKEN=...
```

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

---

Have fun with OP!

@makevoid
