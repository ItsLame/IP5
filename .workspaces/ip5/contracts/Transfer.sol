// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

// import Book and BookFactory contract
import './Book.sol';
import './BookFactory.sol';

contract Transfer
{
    function buy(address _bookAddress) payable public {
        Book book = Book(_bookAddress);
        // check if the book is for sale
        require(book.forSale = true, "Book is not for sale");
        
        // transfer buyer -> owner (money)
        // money send into owner account
        address sendTo = book.owner;
        bool sent = sendTo.send(book.bookPrice); // gas limit 2300 gas
        require(sent, "Transfer failed. Ether not sent");

        // create a new copy of the book for buyer
        newBook(book.bookTitle, book.bookAuthor, book.bookPrice); // how to call this function properly??
    }

    function sell(address _bookAddress) public {
        Book book = Book(_bookAddress);
        // owner only action
        require(msg.sender = book.owner, "Only owner can mark book as for sale");
        // turn on book for sale
        book.forSale = true;
    }

    function offmarket(address _bookAddress) public {
        Book book = Book(_bookAddress);
        // owner only action
        require(msg.sender = book.owner, "Only owner can mark book as for sale");
        // turn off book for sale
        book.forSale = false;
    }
}