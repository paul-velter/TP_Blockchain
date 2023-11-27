// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Secret {
    address public owner;
    string private storedSecret;
    uint256 public constant FEE_AMOUNT = 100;

    event SecretUpdated(string newSecret);
    event FeePaid(address payer, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    modifier hasEnoughFee() {
        require(msg.value >= FEE_AMOUNT, "Insufficient fee");
        _;
    }

    constructor(string memory mySecret) {
        owner = msg.sender;
        storedSecret = mySecret;
    }

    function setSecret(string memory newSecret) public onlyOwner hasEnoughFee payable {
        storedSecret = newSecret;
        emit FeePaid(msg.sender, msg.value);
        emit SecretUpdated(newSecret);
    }

    function getSecret() public onlyOwner view returns (string memory) {
        return storedSecret;
    }

}
