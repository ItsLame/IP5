// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./oracle.sol";
import "./BookFactory";

contract UserApp is BookOracleClient {
    BookFactory bookFactory;
    bytes32 public info1;
    bytes32 public info2;

    address ownerAddress;
    string bookTitle;
    string bookAuthor;
    uint bookPrice;

    function publish_book(string memory _bookTitle, string memory _bookAuthor, uint _bookPrice)  public {
        string memory title = book.bookTitle();
        string memory author = book.bookAuthor();
        bookFactory.newBook(title, author, price);
    }

    function get_info() public{
        bookTitle = getBook(ownerAddress,'title');
    } 


    constructor(address oracleAd) BookOracleClient(oracleAd) {}

    function getInfo(string calldata bookreq1, string calldata bookreq2)
        public
    {
        requestBookFromOracle(bookreq1, bookreq2);
    }

    function receiveBookFromOracle(
        uint256 requestId,
        bytes32 _info1,
        bytes32 _info2
    ) internal override {
        info1 = _info1;
        info2 = _info2;
        if (info1 == 'title'){
            bookTitle = info2;
        }
        else if (info1 == 'author')
        {
            bookAuthor = info2;
        }
        else if (info1 == 'price')
        {
            bookPrice = info2;
        }
    }
}
