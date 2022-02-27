// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

//building the mint function to create NFT
/**
    to keep the address
    - Mint for 
    A - NFT to point to an address
    B - keep track for the token owner IDS
    C -Keep track the token an owner address has
    D - create an event that emits a transfer log , where its been minted to and the ID
    E - Events  are one directional to keep track of block chain data and logs

 */

contract ERC721 {
    //,mapping in solididty creates a hash table of pair values 
    //to keep track and setting the token 


  // create mapping  token ID to the owner 
  //unit - is the calculation of bit so 
    mapping(uint256 => address) private _tokenOwner;

    //create mapping from owner to number of owned tokens 
    mapping(address => uint256) private _OwnedTokensCount;

}



