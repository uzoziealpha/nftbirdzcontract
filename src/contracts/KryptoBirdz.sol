// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import './ERC721Connector.sol';


//this will store the information that wull run and deploy into the blockchain to test code 
contract Kryptobird is ERC721Connector {

   //create an array to store the kryptobird nfts
   string[] public kryptoBirdz;

   mapping(string => bool) _kryptoBirdzExists;
   
   function mint(string memory _kryptoBird) public {

    require(!_kryptoBirdzExists[_kryptoBird], 
    'Error - kryptoBird already exists');


    // deprecated .push  uint _id = KryptoBirdz.push(_kryptoBird);
    //.push method in solidity no longer returns length
    kryptoBirdz.push(_kryptoBird);
    uint _id = kryptoBirdz.length -1;


      _mint(msg.sender, _id);

//this will make us access the same mapping
      _kryptoBirdzExists[_kryptoBird] = true;


   }






   //we must have a name a symbol
   // initialize this contact to inherit name ans symbol from
   //erc721metadata. 
   constructor() ERC721Connector('KryptoBird', 'KBIRDZ')
   {}

}