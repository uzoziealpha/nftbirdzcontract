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

 /**
     TO BUILD WE 
     1. Write a function called _mint that takes two arguments
       (address , tokenId)
    2. Add internal visibility to the signature
    3. Set the _tokenOwner of the tokenId to the address to 'to'
    4. Increase the owner token count by 1 each time the function is called.
  */

contract ERC721 {
  
   //we create an even to keep track of the transfer and logs 
   //this helps save gas as well
   event Transfer(
       address indexed from, 
       address indexed to, 
       uint256 indexed tokenId);
   



    //,mapping in solididty creates a hash table of pair values 
    //to keep track and setting the token 


  // create mapping  token ID to the owner 
  //unit - is the calculation of bit so 
    mapping(uint256 => address) private _tokenOwner;
   //create mapping from owner to number of owned tokens 
    mapping(address => uint256) private _OwnedTokensCount;
    



 ///   @notice Count all NFTs assigned to an Owner
 ///   @dev
 ///   @param _owner The address of who we query the balance
 ///   @return
  
   function balanceOf(address _owner) public view returns(uint256) {
     require(_owner != address(0), 'Token does not exist');
     return _OwnedTokensCount[_owner];
   } 


 ///   @notice Finding the Owner of an NFT
 ///   @dev
 ///   @param _tokenId the id for an NFT
 ///   @return

     function ownerOf(uint256 _tokenId) external view returns(address) {
       //this address stores the owner mapping it out with the ID
       address owner = _tokenOwner[_tokenId];
       require(owner != address(0), 'Owner does not exist');
       return owner;
}


   




  //Write a function called _mint that takes two arguments
  
       //NFT EXIST function to check if the token ID already exists
     function _exists(uint256 tokenId) internal view returns(bool) {
            //setting address of nft owner to check the address of the tokenOwner at the tokenId
           address owner = _tokenOwner[tokenId];
           // return truthiness if the address is not 0
           return owner != address(0);
       }

       //MINTING function makes the owner get a specific id 

      function _mint(address to, uint256 tokenId) internal virtual {
        //making the address to a specifc address not invalid
        require(to != address(0),'ERC721: minting to the zero address');
        //this will make sure that if it already exist return message
        require(!_exists(tokenId), 'ERC721: token already minted');
        // we are adding new address with a token ID with the mint using [tokenId]
        _tokenOwner[tokenId] = to;
   //     _OwnedTokensCount [to] = _OwnedTokensCount[to] + 1; 
    //this helps to keep track of the minting and adding 1 to the count. 
        _OwnedTokensCount[to] += 1;


        //event emitter for transfering
        emit Transfer(address(0), to, tokenId);
    }
}



