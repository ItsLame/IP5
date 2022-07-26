// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

// import Book and BookFactory contract
import './Book.sol';
import './BookFactory.sol';

contract Transfer
{
    BookFactory bookFactory;

    function buy(address _bookAddress) payable public {
        Book book = Book(_bookAddress);
        uint price = book.bookPrice();
        string memory title = book.bookTitle();
        string memory author = book.bookAuthor();
        bool forSale = book.forSale();
        // check if the book is for sale
        require(forSale == true, "Book is not for sale");
        
        // transfer buyer -> owner (money)
        // money send into owner account
        address payable sendTo = book.ownerPayable();
        bool sent = sendTo.send(price); // gas limit 2300 gas
        require(sent, "Transfer failed. Ether not sent");

        // create a new copy of the book for buyer
        bookFactory.newBook(title, author, price);
    }

    function sell(address _bookAddress) public view {
        Book book = Book(_bookAddress);
        bool forSale = book.forSale();
        address owner = book.ownerAddress();
        // owner only action
        require(msg.sender == owner, "Only owner can mark book as for sale");
        // turn on book for sale
        forSale = true;
    }

    function offmarket(address _bookAddress) public view {
        Book book = Book(_bookAddress);
        bool forSale = book.forSale();
        address owner = book.ownerAddress();
        // owner only action
        require(msg.sender == owner, "Only owner can mark book as for sale");
        // turn off book for sale
        forSale = false;
    }
}