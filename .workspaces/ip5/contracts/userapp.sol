// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./BookFactory.sol";
import "./oracle.sol";


contract UserApp is BookOracleClient {
   
    bytes32 public info1;
    bytes32 public info2;

    address public ownerAddress;
    string public bookTitle;
    string public bookAuthor;
    uint public bookPrice;
    string public price;

    function publishbook(uint256 memory reqID) public view {
        BookFactory bookFactory;
        receiveBookFromOracle(reqID, 'book','title');
        receiveBookFromOracle(reqID,'book','author');
        receiveBookFromOracle(reqID,'book','price');
        bookPrice =str2int(price);
        bookFactory.newBook(bookTitle, bookAuthor, bookPrice);
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

    constructor(address oracleAd, address bookfactoryAd) BookOracleClient(oracleAd) {}

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
            price = info2;
        }
    }
}
