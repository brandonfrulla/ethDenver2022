// SPDX-License-Identifier: MIT
/// @custom:security-contact ryvince.dev@gmail.com

pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20SnapshotUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/draft-ERC20PermitUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20VotesUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";


contract TokenFactory is Initializable, ERC20Upgradeable, ERC20BurnableUpgradeable, ERC20SnapshotUpgradeable, OwnableUpgradeable, PausableUpgradeable, ERC20PermitUpgradeable, ERC20VotesUpgradeable {
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}

    function initialize() initializer public {
        __ERC20_init("Leap Token", "L3AP");
        __ERC20Burnable_init();
        __ERC20Snapshot_init();
        __Ownable_init();
        __Pausable_init();
        __ERC20Permit_init("L3AP");

        _mint(msg.sender, 420000000000 * 10 ** decimals());
    }

    function snapshot() public onlyOwner {
        _snapshot();
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override(ERC20Upgradeable, ERC20SnapshotUpgradeable)
    {
        super._beforeTokenTransfer(from, to, amount);
    }


    function checkWallet (address from, address to, uint256 amount) public payable onlyOwner {
        //confirm wallet is registered, if not register
    }

    function confirmTime (address from, address to, uint256 amount) public payable onlyOwner {
        //confirm the time watched 
        //potentially do math on time watched, randomize
        //extension will have a time tracker / channel name depending on twitch / youtube, etc.
    }

    function payUser (address from, address to, uint256 amount) public payable onlyOwner {
        //airdrop the ERC20 to the user (msg.sender)
        //failback or max on tokens that can be sent per transaction
    }


    // The following functions are overrides required by Solidity. 
    // From OpenZepplin Contract Wizard

    function _afterTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20Upgradeable, ERC20VotesUpgradeable)
    {
        super._afterTokenTransfer(from, to, amount);
    }

    function _mint(address to, uint256 amount)
        internal
        override(ERC20Upgradeable, ERC20VotesUpgradeable)
    {
        super._mint(to, amount);
    }

    function _burn(address account, uint256 amount)
        internal
        override(ERC20Upgradeable, ERC20VotesUpgradeable)
    {
        super._burn(account, amount);
    }
}

contract SimpleBank {

    /* State variables
     */
    // We want to protect our users balance from other contracts
    mapping (address => uint) private balances ;
    
    // We want to create a getter function and allow contracts to be able
    //       to see if a user is enrolled.
    mapping (address => bool) public enrolled;

    // Let's make sure everyone knows who owns the bank, 
    address public owner = msg.sender;

    /* Events - publicize actions to external listeners
     */
    event LogEnrolled(address accountAddress);
    event LogDepositMade(address accountAddress, uint amount);
    event LogWithdrawal(address accountAddress, uint withdrawAmount, uint newBalance);

    /* Functions
     */
    // Fallback function - Called if other functions don't match call or
    // sent ether without data
    // Typically, called when invalid data is sent
    // Added so ether sent to this contract is reverted if the contract fails
    // otherwise, the sender's money is transferred to contract
    // fallback() external payable {
    //     revert();
    // }

    /// @notice Get balance
    /// @return The balance of the user
    function getBalance() public view returns (uint) {
      return balances[msg.sender];
      // 1. prevents function from editing state variables;
      //    allows function to run locally/off blockchain
      // 2. Get the balance of the sender of this transaction
    }

    /// @notice Enroll a customer with the bank
    /// @return The users enrolled status
    
    // Emit the appropriate event to enroll
    function enroll() public returns (bool){
      enrolled[msg.sender] = true;
      emit LogEnrolled(msg.sender);
      // 1. enroll of the sender of this transaction
    }

    /// @notice Deposit ether into bank
    /// @return The balance of the user after the deposit is made
    function deposit() public payable returns (uint) {
      require (enrolled[msg.sender] == true);
      balances[msg.sender] = balances[msg.sender] + msg.value;
      emit LogDepositMade(msg.sender, msg.value);
      return balances[msg.sender];

      // 1. Add the appropriate keyword so that this function can receive ether
      // 2. Users should be enrolled before they can make deposit
      // 3. Add the amount to the user's balance. Hint: the amount can be
      //    accessed from of the global variable `msg`
      // 4. Emit the appropriate event associated with this function
      // 5. return the balance of sndr of this transaction
    }

    /// @notice Withdraw ether from bank
    /// @dev This does not return any excess ether sent to it
    /// @param withdrawAmount amount you want to withdraw
    /// @return The balance remaining for the user
    function withdraw(uint withdrawAmount) public payable returns (uint) {

      require (balances[msg.sender] >= withdrawAmount);
     
      balances[msg.sender] = balances[msg.sender] - withdrawAmount;
       
       //msg.sender.transfer(withdrawAmount);
      /// @dev - above line ompiliing with TypeError: "send" and "transfer" are only available for objects of type "address payable", not "address"

      emit LogWithdrawal(msg.sender, withdrawAmount, balances[msg.sender]);
      return balances[msg.sender];

      // If the sender's balance is at least the amount they want to withdraw,
      // Subtract the amount from the sender's balance, and try to send that amount of ether
      // to the user attempting to withdraw. 
      // return the user's balance.

      // 1. Use a require expression to guard/ensure sender has enough funds
      // 2. Transfer Eth to the sender and decrement the withdrawal amount from
      //    sender's balance
      // 3. Emit the appropriate event for this message
    }
}