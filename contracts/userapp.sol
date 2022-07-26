// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./BookFactory.sol";
import "./Transfer.sol";

contract UserApp {
    string public info1;
    string public info2;

    address public ownerAddress;
    string public bookTitle;
    string public bookAuthor;
    uint256 public bookPrice;
    string public price;
    BookFactory public bookFactory;
    Transfer public transferC;

    function publishbook(string memory  bookTitle, string memory  bookAuthor, uint256  bookPrice ) public {
        bookFactory.newBook(bookTitle, bookAuthor, bookPrice, msg.sender);
    }

    function buyBook(address  bookAddress) payable public {
        Book book = Book(bookAddress);
        require(msg.value == book.bookPrice(),"Need to send exact amount of Wei");
        // transfer buyer -> owner (money)
        // money send into owner account
        address payable owner = book.ownerPayable();
        owner.transfer(msg.value); 
        transferC.buy(bookAddress,msg.sender);
    }

    constructor(address bookfactoryAd, address transferContract)
    { 
        bookFactory = BookFactory(bookfactoryAd); 
        transferC = Transfer(transferContract);
    }

}
