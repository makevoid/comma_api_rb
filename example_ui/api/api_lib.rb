module FormatStream

  SSE_IDS = {}

  Format = -> (stream, hash) {
    # see Server-Sent Events mdn/spec: https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events (or just assume it "behaves" as a one-way websocket)
    out = ""
    id = SSE_IDS[:stream] || 0 # we need an auto-increment id for the sse to work
    # this is the (simple) output format - id: ID \n data: [JSON] \n\n
    out << "id: #{id}\n"
    out << "data: #{JSONDump.(hash)} \n\n" # json data
    SSE_IDS[:stream] = id
    out
  }

  # private

  #  faster, requires a C library (slower docker build time)
  # JSONDump = -> (hash) {
  #   Oj.dump(hash, mode: :compat)
  # }

  # no deps
  JSONDump = -> (hash) {
    hash.to_json
  }


end

Log = -> (msg) {
  puts msg
}
