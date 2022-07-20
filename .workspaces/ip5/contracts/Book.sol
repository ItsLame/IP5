// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Book
{
    string public bookTitle;
    uint public bookID;
    address public seller;

    constructor(uint _bookID, string memory _bookTitle, address _seller) public payable
    {
        bookID = _bookID;
        bookTitle = _bookTitle;
        seller = _seller;
    }
}