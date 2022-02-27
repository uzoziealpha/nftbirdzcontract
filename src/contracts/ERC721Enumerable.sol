// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';



contract ERC721Enumerable is IERC721Enumerable, ERC721{

    uint256[] private _allTokens;
    

    //1st mapping from tokenID to position in _allTokens Array 
   mapping(uint256 => uint256) private _allTokensIndex;


    //2nd mapping of owner to list of all token ids
   mapping(address => uint256[]) private _ownedTokens;


//3rd mapping from token ID to index of the owner tokens list
   mapping(uint256 => uint256) private _ownedTokensIndex;


    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        /**
        
            When minting
            1- Add tokens to the owner
            2- All tokens to our totalsupply
         */
         _addTokensToAllTokenEnumeration(tokenId);
         _addTokensToOwnerEnumeration(to, tokenId);
    }


   //function returns tokenns to the _alltokens array and set the position of the enumeration
    function _addTokensToAllTokenEnumeration(uint256 tokenId) private{
         _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    // function that returns tokenbyIndex 
     function tokenByIndex(uint256 index) public view returns(uint256) {
         //making sure the index is not out of bound. 
      require(index < totalSupply(), 'global index is out of bound!');   
      return _allTokens[index];
     }


    //function that returns tokenByOwnerIndex
    function tokenOfOwnerByIndex(address owner, uint index) public view returns(uint256){
        require(index < balanceOf(owner), 'global index is out of bound');
        return _ownedTokens[owner][index];
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        // 1. add address and token id the ownerTokens 
        //2. ownedTokenIndex tokenID set to address of ownedTokens positiion
        //3. We want to execute the function with minting
      _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
      _ownedTokens[to].push(tokenId);
    }

   // returns total suply of all the _all tokens arrsy 
    function totalSupply() public override view returns (uint256) {
        return _allTokens.length;
    }

}