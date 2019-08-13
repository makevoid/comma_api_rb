/* notes */

/* # class ETHFaucet */
contract ETHFaucet {
  /* # properties: */
  /* # */
  /* # property :xabc */
  /* # property :poolAmount */
  /* # property :xabc */

  /* # TODO: de-hardcode registeredUsers (TODO: implement) */
  /* # registeredUsers = [ "0x1234....", "0x1234...." ] */
  registeredUsers = %w(
    0x12345
    0x23456
    0x34567
  )

  register = -> {
    oracle_check
  }

  poolAmount = -> {
    sum(registeredUsers)
  }

  num_total = -> (registeredUsers) {
    registeredUsers.size
  }

  redistribute = -> {
    poolAmount = is_int poolAmount
    amount = poolAmount / 4
    redistributeWeeklyAmount amount
  }

  redistributeWeeklyAmount = -> (weeklyAmount) {
    addresses = getWeeklyUsers
    userAmount = weeklyAmount / size(addresses)
    for address in addresses
      distribute address, userAmount
    end
  }

  getWeeklyUsers = -> {
    // data = oracle.call("https://community.comma.ai/forum/leaderboard.php", "jq users[12]")
    // data = oracle.call("https://comma-api-proxied.org/community/leaderboard")
    // sample response for this week

    // users_points = [
    //   ["gregjhogan", 4646],
    //   ["andrewblanejr", 4144],
    //   ["mikeme1516", 4008],
    //   ["SuperScape", 3972],
    //   ["prat1k", 3929],
    //   ["BabaBoch", 3891],
    //   ["Frostedcore", 3676],
    //   ["the_dp", 3666],
    //   ["VirtuallyChris", 3505],
    // ]

    // simpler - reward all users returned by the api
    users = [
      "gregjhogan",
      "andrewblanejr",
      "mikeme1516",
      "SuperScape",
      "prat1k",
      "BabaBoch",
      "Frostedcore",
      "the_dp",
      "VirtuallyChris",
    ]

    users
  }

  distribute = -> (address) {
    sendErc20
  }

  is_int = -> {
    # check that the value is int
    # check that the value doesn't overflows
  }

}
