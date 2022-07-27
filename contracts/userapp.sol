// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./BookFactory.sol";
// import "./Oracle.sol";
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


    function str2int(string memory numString) public pure returns(uint) {
        uint  val=0;
        bytes   memory stringBytes = bytes(numString);
        for (uint  i =  0; i<stringBytes.length; i++) {
            uint exp = stringBytes.length - i;
            bytes1 ival = stringBytes[i];
            uint8 uval = uint8(ival);
           uint jval = uval - uint(0x30);
   
           val +=  (uint(jval) * (10**(exp-1))); 
             
        }
        return val;
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
