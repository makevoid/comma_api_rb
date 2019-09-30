# Examples

check out this dir for some example usage of the comma API rb

### how to get a route ID from the my.comma.ai webapp

1 - go to https://my.comma.ai/

2 - select a drive (which has video, in case you want to download the video)

3 - hit the `Copy Current Segment` button at the bottom-right corner of the screen

4 - paste the value that you just copied from the my.comma.api webapp somwehre

5 - you will end up with an identifier / code like this one:

```
abcdef1234567890|2020-01-01--00-00-00--12
```

you want to chop the last 4 chars (2 digits and 2 `--`, starting from the end of the )

so that from a code that looks like this

```
f5fd7b69a6836f10|2020-01-01--01-20-32--09
```

you end up with one like this:

```
f5fd7b69a6836f10|2020-01-01--01-20-32
```

6. congrats! you have your route ID

now you can use it for the example scripts as `ruby example/example1.rb ROUTE_ID="..."`
