// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;


contract BankNegara{
    address public currentuser;
    address public admin;
    uint256 public threshold = 10 ether;
    mapping (address => uint256) private balanceOf;
    
    uint256 public bankBalance = address(this).balance;
    address public youraddress;
    
    address [] public listofdepositors;
    address [] public listofwithdrawers;
    address [] public listofsuspectedlaunderer;
    
    constructor() {
        admin = msg.sender;    
    }
    
    function getlength() view public returns(uint count){
        return listofdepositors.length;
    }
     function getArray() public view returns (address[] memory){
       return listofdepositors;
    }
    
    function getSuspectArray() public view returns (address[] memory){
       return listofsuspectedlaunderer;
    }
    function getlengthSuspect() view public returns(uint count){
        return listofsuspectedlaunderer.length;
    }
    modifier onlyAdmin(){
        require(msg.sender == admin);
        _;
    }
    modifier onlyAccountOwners(){
        require(msg.sender != admin);
        _;
    }
    
    function getThreshold() view public returns(uint256){
        return threshold;
    }
    
    function setThreshold(uint256 newThreshold) public onlyAdmin{
        threshold = newThreshold;
    }
    
    function deposit() public payable onlyAccountOwners{
        youraddress = msg.sender;
        require(msg.value > 0);
        uint256 deposited = msg.value;
        if(msg.value<=threshold){
            
        balanceOf[youraddress] += deposited;
        bankBalance += deposited;
        listofdepositors.push(youraddress);
        require(bankBalance <= 50 ether, "The bank is now suspected as the place for money laundering");
        }
        else if(deposited>threshold)
        {
            recordsuspect(youraddress);
            withdraw2(msg.value);
        }
    }
    
    function withdraw(uint256 amount) public onlyAccountOwners{
        currentuser = msg.sender;
        require(amount <= balanceOf[currentuser]);
        balanceOf[currentuser] -= amount;
        msg.sender.transfer(amount);
        bankBalance =- amount;
        listofwithdrawers.push(currentuser);
    }
    
    function recordsuspect(address suspect) internal{
        currentuser = suspect;
        listofsuspectedlaunderer.push(currentuser);
    }
    function withdraw2(uint256 amount) internal{
        currentuser = msg.sender;
        msg.sender.transfer(amount);
    }
        function balance() public view returns (uint) {
        return balanceOf[msg.sender];
    }
}