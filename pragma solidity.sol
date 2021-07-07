pragma solidity ^0.4.11;

contract hadcoin_ico {
    // introducing the maximum number of Hadcoins availabe for seale
    uint public max_hadcoins = 1000000;
    
    // introducign the usd to hadcoins conversion relocatable
    uint public usd_to_hadcoins = 1000;
    
    //investors
    
    uint public total_hadcoins_bought = 0;
    
    mapping(address => uint) equity_hadcoins;
    mapping(address => uint) equity_usd;
    
    modifier can_buy_hadcoins(uint usd_invested){
        require((usd_invested * usd_to_hadcoins + total_hadcoins_bought) <= max_hadcoins);
        _;
    }
    function equity_in_hadcoins(address investor) external constant returns (uint) {
        return equity_hadcoins[investor];
    }
    function equity_in_usd(address investor)external constant returns (uint){
        return equity_usd[investor];
    }
    function buy_hadcoins(address investor, uint usd_invested) external can_buy_hadcoins(usd_invested) {
        uint hadcoins_bought= usd_invested*usd_to_hadcoins;
        equity_hadcoins[investor] += hadcoins_bought;
        equity_usd[investor] = equity_hadcoins[investor]/1000;
        total_hadcoins_bought +=hadcoins_bought;
    }
    
    function sell_hadcoins(address investor, uint hadcoins_sold) external {
        
        equity_hadcoins[investor] -= hadcoins_sold;
        equity_usd[investor] = equity_hadcoins[investor]/1000;
        total_hadcoins_bought -=hadcoins_sold;
    }
    
       
}