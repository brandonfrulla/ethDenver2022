const LeapTesting = artifacts.require("LeapW2E");

//const { catchRevert } = require("./exceptionsHelpers.js");
var LeapTest = artifacts.require("./LeapW2E.sol");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("LeapW2E", function (/* accounts */) {
  it("should assert true", async function () {
    await LeapTesting.deployed();
    return assert.isTrue(true);
  });
});
