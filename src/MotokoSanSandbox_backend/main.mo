// @verify

actor ClaimReward {
  var claimed = false;
  var count = 0 : Int;
  
  assert:invariant 
   (not claimed implies count == 0) // initially synchronized
   and (count == 0 or count == 12);  // reward is unique

  public shared func claim() : async () {
    if (not claimed) {
      claimed := true;

      await async {
        assert:1:async claimed and count == 0;

        // (send reward)

        count += 1;
      };
    };
  };
}