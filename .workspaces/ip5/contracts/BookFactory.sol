// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// import Book contract
import './Book.sol';

contract BookFactory
{
    // array of book contracts
    Book[] public books;

    // new book
    function newBook(string memory _bookTitle) public
    {
        // pointer to book contract
        Book book = new Book(books.length, _bookTitle, msg.sender);

        // push book contract pointer to array
        books.push(book);
    }

    // new book with ether
    function newBookEther(string memory _bookTitle) public payable
    {
        // pointer to book contract
        Book book = (new Book){value:msg.value}(books.length, _bookTitle, msg.sender);

        // push book contract pointer to array
        books.push(book);
    }
}