pragma solidity 0.5.11;
// pragma solidity ^0.5.11;
// pragma solidity >=0.5.11 <0.7.0;

// note: this generates heat as mining does
// because there's an incentive to drive, and driving gases are bad
// this is will be obvuiously end up burning considerable level of co2 etc etc...
// :D I'm joking obvuiously

// with this faucet, you can register via `register()` with your address and your username, you have to authenticate via the comma api, and prove that your are you, you have to upload a log with your digital signature, then call the contract, the contract will use an oracle (chainlink/oraclize) to call comma and link your ethereum address with your account)
// if you end up in the top 50 you get a slice of the reward present in the fauced, for that specific week pool (the pool distributes 1/4th of the value contained in the pool every week)
// people will donate to the faucet so that people are more incentivized to submit driven miles which will improve the driving model in the long run
// an implementation where the reward gets maximized if people upload the driver side video can be considered

contract ETHFaucet {
    mapping(int => address) public weeklyUsers;

    function poolAmount() {
      return sum();
    }

    public view sum(accounts) {
      int memory total = 0;
      for (uint i=0; i<accounts.length; i++) {
        total += accounts[i];
      }
    }
}
