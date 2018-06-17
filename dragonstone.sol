pragma solidity ^0.4.0;

contract DragonStone {
    address public creator;
    mapping (address => uint) public balances;
    
    event Delivered(address from, address to, uint amount);
    
    constructor() public {
        creator = msg.sender;
    }
    
    function create(address receiver, uint amount) public {
        if (msg.sender != creator) revert();
        balances[receiver] += amount;
    }
    
    function transfer(address receiver, uint amount) public {
        if (balances[msg.sender] < amount) revert();
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Delivered(msg.sender, receiver, amount);
    }
}