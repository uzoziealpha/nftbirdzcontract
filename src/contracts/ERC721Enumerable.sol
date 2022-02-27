// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import './ERC721.sol';



contract ERC721Enumerable is ERC721{

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
         _addTokensToTotalSupply(tokenId);
    }

    function _addTokensToTotalSupply(uint256 tokenId) private{

        _allTokens.push(tokenId);
    }

    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }

}