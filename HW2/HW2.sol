pragma solidity ^0.6.0;


contract Bank{
    mapping(address => uint256) accountBalance;
    mapping(string => address) public students;
    address payable public owner;
    uint256 public BankDeposit;
    
    constructor () public payable{
        BankDeposit = msg.value; 
        owner = msg.sender;
    }
    
    //註冊
    function enroll(string memory studentId, address userAddress) public{
        students[studentId]=userAddress;
    }
    
    //存款
    function deposit() public payable {
        require(msg.value > 0 , 'Wrong!');
        accountBalance[msg.sender] += msg.value;
        BankDeposit += msg.value;
    }
    
    //提款
    function withdraw(uint256 amt) public payable{
        require(accountBalance[msg.sender] >= amt,'Not enough!');
        msg.sender.transfer(amt);
        accountBalance[msg.sender] -= amt;
        BankDeposit -= amt;
        
        
    }
    
    //轉帳
    function transfer(uint256 amt , address payable add) public payable {
        require(accountBalance[msg.sender]>= amt ,"You don't have enough money !");
        accountBalance[add] += amt;
        accountBalance[msg.sender] -= amt;
    }

    //查詢存款
    function getBalance() public view returns(uint256){
        return accountBalance[msg.sender];
    }
    
    //查詢銀行存款
    function getBankBalance() public view  returns (uint256){
        require(owner == msg.sender);
        return(BankDeposit);
    }
    
    fallback()external{
        require(owner == msg.sender, "Permission denied");
        selfdestruct(owner);
    }
}
