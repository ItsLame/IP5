// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./BookFactory.sol";
import "./oracle.sol";


contract UserApp is BookOracleClient {
   
    string public info1;
    string public info2;

    address public ownerAddress;
    string public bookTitle;
    string public bookAuthor;
    uint public bookPrice;
    string public price;

    function publishbook(uint256  _reqID) public{
        BookFactory bookFactory;
        receiveBookFromOracle(_reqID, 'book','title');
        receiveBookFromOracle(_reqID,'book','author');
        receiveBookFromOracle(_reqID,'book','price');
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

    function bytes32ToString(bytes32 _bytes32) public pure returns (string memory) {
        uint8 i = 0;
        while(i < 32 && _bytes32[i] != 0) {
            i++;
        }
        bytes memory bytesArray = new bytes(i);
        for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
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
        info1 = bytes32ToString(_info1);
        info2 = bytes32ToString(_info2);
        if (keccak256(bytes(info1)) == keccak256(bytes('title'))){
            bookTitle = info2;
        }
        else if (keccak256(bytes(info1)) == keccak256(bytes('author')))
        {
            bookAuthor = info2;
        }
        else if (keccak256(bytes(info1)) == keccak256(bytes('price')))
        {
            price = info2;
        }
    }
}
