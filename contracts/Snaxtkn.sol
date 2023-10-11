// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Declaring the contract
contract SSnaxtkn {
    // Declaring state variables for the token's detail
    string public name ;  // Name of the token
    string public symbol;  // Symbol of the token
    uint8 public decimals;  // Number of decimal places the token can be divided into
    
    // Mapping to track each address's balance of this token
    mapping(address => uint256) public balances;
    
    // Mapping to track approved allowance of tokens a third-party can spend on behalf of token holders
    mapping(address => mapping(address => uint256)) public allowances;
    
    // Event emitted when tokens are transferred
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    // Event emitted when a spender is approved to spend tokens on behalf of a token holder
    event Approval(address indexed owner, address indexed spender, uint256 value);

     // Constructor to initialize the token's details
    constructor(string memory _name, string memory _symbol, uint8 _decimals) {
        name = _name;  // Set the token name
        symbol = _symbol;  // Set the token symbol
        decimals = _decimals;  // Set the decimal places
    }

    // Function to check the balance of a particular address
    function balanceOf(address owner) public view returns (uint256) {
        return balances[owner];  // Return the balance of the queried address
    }
    
    // Function to transfer tokens to a particular address
    function transfer(address to, uint256 value) public returns (bool) {
        require(balances[msg.sender] >= value, "Insufficient balance");  // Ensure sender has enough balance
        balances[msg.sender] -= value;  // Deduct the value from sender's balance
        balances[to] += value;  // Add the value to recipient’s balance
        emit Transfer(msg.sender, to, value);  // Emit Transfer event
        return true;  // Return true if successful
    }
    
    // Function to approve a spender to spend on behalf of the message sender
    function approve(address spender, uint256 value) public returns (bool) {
        allowances[msg.sender][spender] = value;  // Set allowance
        emit Approval(msg.sender, spender, value);  // Emit Approval event
        return true;  // Return true if successful
    }
    
    // Function to transfer tokens on behalf of an owner (requires prior approval)
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(balances[from] >= value, "Insufficient balance");  // Ensure owner has enough balance
        require(allowances[from][msg.sender] >= value, "Insufficient allowance");  // Ensure spender is allowed
        balances[from] -= value;  // Deduct value from owner's balance
        balances[to] += value;  // Add value to recipient’s balance
        allowances[from][msg.sender] -= value;  // Deduct the value from spender's allowance
        emit Transfer(from, to, value);  // Emit Transfer event
        return true;  // Return true if successful
    }
    
    // Function to create new tokens and add them to an address's balance 
    function mint(address to, uint256 value) public {
        balances[to] += value;  // Add the new tokens to the recipient’s balance
        emit Transfer(address(0), to, value);  // Emit Transfer event from address(0) to signify minting
    }
    
    // Function to destroy tokens from the message sender's balance
    function burn(uint256 value) public {
        require(balances[msg.sender] >= value, "Insufficient balance");  // Ensure sender has enough balance
        balances[msg.sender] -= value;  // Deduct the value from sender's balance
        emit Transfer(msg.sender, address(0), value);  // Emit Transfer event to address(0) to signify burning
    }
}
