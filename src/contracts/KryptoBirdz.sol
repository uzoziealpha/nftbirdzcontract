// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import './ERC721Connector.sol';


//this will store the information that wull run and deploy into the blockchain to test code 
contract Kryptobird is ERC721Connector {

   //we must have a name a symbol
   // initialize this contact to inherit name ans symbol from
   //erc721metadata. 
   constructor() ERC721Connector('KryptoBird', 'KBIRDZ')
   {}

}