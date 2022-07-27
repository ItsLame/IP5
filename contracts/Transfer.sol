// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


// import Book and BookFactory contract
import "./Book.sol";
import "./BookFactory.sol";

contract Transfer
{
    BookFactory bookFactory;

    function buy(address _bookAddress,address sender) payable public {
        Book book = Book(_bookAddress);
        uint price = book.bookPrice();
        string memory title = book.bookTitle();
        string memory author = book.bookAuthor();
        bool forSale = book.forSale();
        // check if the book is for sale
        require(forSale == true, "Book is not for sale");
        // create a new copy of the book for buyer
        
        bookFactory.newBook(title, author, price,sender);
    }

    function sell(address _bookAddress) public  {
        Book book = Book(_bookAddress);
        address owner = book.ownerAddress();
        // owner only action
        require(msg.sender == owner, "Only owner can mark book as for sale");
        // turn on book for sale
        book.setForSale(true);
    }

    function offmarket(address _bookAddress) public  {
        Book book = Book(_bookAddress);
        address owner = book.ownerAddress();
        // owner only action
        require(msg.sender == owner, "Only owner can mark book as for sale");
        // turn off book for sale
        book.setForSale(false);
    }

    constructor(address bookfactoryAd)
    { 
        bookFactory = BookFactory(bookfactoryAd); 
    }
}