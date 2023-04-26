// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract E_commerce{
    address customer;
    address public owner;
    uint public amount_sent_by_customer;
    uint public price_of_product;
    bool public product_delivered;

    constructor(uint price)
    {
        owner=msg.sender;
        product_delivered=false;
        price_of_product=price;
    }

    modifier notOwner()
    {
        require(owner!=msg.sender);
        _;
    }

     modifier onlyOwner()
    {
        require(owner==msg.sender);
        _;
    }

    function payMoney() public payable notOwner{
        amount_sent_by_customer+=msg.value;
        customer=msg.sender;
    }

    function deliverProduct() public onlyOwner returns(bool){
        require(amount_sent_by_customer==price_of_product,"Insufficient amount transferred");
        product_delivered=true;
        return product_delivered;
    }

    function transferFunds() public{
        require(msg.sender==customer);
        require(product_delivered==true);
        payable(owner).transfer(price_of_product);
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

}
