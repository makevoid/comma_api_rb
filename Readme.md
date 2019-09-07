# comma-api-rb

API Client for api.comma.ai

### Usage

#### Comma API


```rb
me = CommaAPI.me()
puts("me:", me) # {"email":"makevoid@example.com","id":"12345....","points":2708,"prime":null,"regdate":1563123456,"superuser":false,"upload_video":false,"username":"antani12345"}
```

#### Athena API

Your EON needs to be on 

```rb
me = CommaAPI.me()
puts("me:", me) # {"email":"makevoid@example.com","id":"12345....","points":2708,"prime":null,"regdate":1563123456,"superuser":false,"upload_video":false,"username":"antani12345"}
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
