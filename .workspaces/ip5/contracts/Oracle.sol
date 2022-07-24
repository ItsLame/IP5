// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract  oracle{ 
    string public bookTitle;
    string public bookAuthor;
    uint public bookID;
    address payable public ownerPayable;
    address public ownerAddress;
    uint public bookPrice;
    bool public forSale;


    event bookRequest(string bookTitle); 
    function requestTitle(string memory bookTitle) 
    private { 
        emit temperatureRequest(bookTitle); 
    }
    function requestPhase() public { 
        requestTitle("Title"); }

    function responsePhase(int256 Title) public { 
        bookTitle = Title; }

}k