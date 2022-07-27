// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// import Book, BookFactory, and BookReadOnly contract
import "./Book.sol";
import "./BookFactory.sol";
// import "./BookReadOnly.sol";

contract Transfer
{
    // BookFactory bookFactory;
    // BookReadOnly bookReadOnly;
    // Book book;

    // constructor(address _bookfactoryAddress)
    // { 
    //     bookFactory = BookFactory(_bookfactoryAddress); 
    // }

    // buy book and ownership to read (not allowed for resale)
    function buy(BookFactory _bookFactory, Book _book, address _senderAddress) payable public
    {
        // Book book = Book(_bookAddress);
        // uint price = _book.bookPrice();
        // string memory title = _book.bookTitle();
        // string memory author = _book.bookAuthor();
        // bool forSale = _book.forSale();

        // check if the book is for sale
        // require(_book.forSale() == true, "Book is not for sale");
        // require(msg.value >= _book.bookPrice() ,"give the right price");

        // create a new copy of the book for buyer
        // bookFactory.newBook(title, author, price, msg.sender);

        // create a new book contract for buyer (for proof; non-resale)
        _bookFactory.newBookReadOnly(_book.bookTitle(), _book.bookAuthor(), _book.bookPrice(), _senderAddress);
        
        // transfer buyer -> owner (money)
        // money send into owner account
        _book.ownerPayable().transfer(msg.value); 

        // transfer ownership
        // book.setNewOwner(msg.sender);

        // put book off the market 
        // offmarket(_book);
    }

    // put book up for selling
    function sell(Book _book) public
    {
        // Book book = Book(_bookAddress);
        // address owner = _book.ownerAddress();

        // owner only action
        // require(_senderAddress == _book.ownerAddress(), "Only owner can mark book as for sale");

        // turn on book for sale
        _book.setForSale(true);
    }

    // put book off market
    function offmarket(Book _book) public
    {
        // Book book = Book(_bookAddress);
        // address owner = _book.ownerAddress();

        // owner only action
        // require(msg.sender == _book.ownerAddress(), "Only owner can mark book as off market");

        // turn off book for sale
        _book.setForSale(false);
    }
}