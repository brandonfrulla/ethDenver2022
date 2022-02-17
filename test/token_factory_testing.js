const TokenFactoryTesting = artifacts.require("TokenFactoryTesting");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("TokenFactoryTesting", function (/* accounts */) {
  it("should assert true", async function () {
    await TokenFactoryTesting.deployed();
    return assert.isTrue(true);
  });
});
