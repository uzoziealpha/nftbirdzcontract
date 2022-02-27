// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import './ERC165.sol';
import './interfaces/IERC721.sol';

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

contract ERC721 is ERC165, IERC721 {
  
   //we create an even to keep track of the transfer and logs 
   //this helps save gas as well
   event Transfer(
       address indexed from, 
       address indexed to, 
       uint256 indexed tokenId);
   
   event Approval (
     address indexed owner,
     address indexed approved,
     uint256 indexed tokenId);
   
   


    //,mapping in solididty creates a hash table of pair values 
    //to keep track and setting the token 


  // create mapping  token ID to the owner 
  //unit - is the calculation of bit so 
    mapping(uint256 => address) private _tokenOwner;
   //create mapping from owner to number of owned tokens 
    mapping(address => uint256) private _OwnedTokensCount;
   //create mapping to keep track for approved addresses
    mapping(uint256 => address) private _tokenApprovals;

  //***************************
  
  //************************ */
      
    //Create constructor to register interface for the erc721 contract so that it includes
    // some functions: balanceOf, owwnerOf , transferFrom

    //Register the interface for the ERC721Enumerable contract so that it includes
    //Supply, tokenByIndex , tokenOfOwnersByIndex 

    //Register the inteeface for the ERC721Metadata contract so that includes 
    //name and symbol functions.
       constructor () {
       _registerInterface(bytes4(keccak256('supportedInterfaces(bytes)')^
       keccak256('ownerOf(bytes4)')^keccak256('transferFrom(bytes4')));
      }

  
   function balanceOf(address _owner) public view returns(uint256) {
     require(_owner != address(0), 'Token does not exist');
     return _OwnedTokensCount[_owner];
   } 




 ///   @notice Finding the Owner of an NFT
 ///   @dev
 ///   @param _tokenId the id for an NFT
 ///   @return

     function ownerOf(uint256 _tokenId) public view returns(address) {
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

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal
    {
     //add the safe functionality
     //A. require that the address receiving s tokein is not a zero
          require(_to != address(0), 'Error - ERC721 Transfer to the zero address');

     //B. require the address transferring the token actually owns the token
            require(ownerOf(_tokenId) == _from, 'Trying to transfer a token the address does not own!');
      //add the token id to the address receiving the token
   
      
      //update the balance of the address _from token
          _OwnedTokensCount[_from] -=1;
          _OwnedTokensCount[_to] +=1;

      //update the balance of the address _to
        _tokenOwner[_tokenId] = _to;
  
      emit Transfer(_from, _to, _tokenId);    
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        require(isApprovedOrOwner(msg.sender, _tokenId));
        _transferFrom(_from, _to, _tokenId);
    }

//we want to approve an Id or tokenID
//we want to be sure the person approving is the owner
//use mapping to update the map of the approval addresses
    function approve(address _to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(_to != owner, 'Error - approval to current owner');
        require(msg.sender == owner, 'Current Caller is not the owner of the token');
        _tokenApprovals[tokenId] = _to;
        emit Approval(owner, _to, tokenId);
    }

     function isApprovedOrOwner (address spender , uint256 tokenId) internal {
       return(_exists(tokenId), 'Token does not exist');
       address owner = ownerOf(tokenId);
       return(spender == owner);

     }
}



