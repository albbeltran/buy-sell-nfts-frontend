// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyNFT is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    mapping(uint => uint) public salePrice;
    // uint[] tokensForSale;

    constructor() ERC721("TestingNFTs", "NFT") {}

    function safeMint(address to, string memory tokenURI) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
    }

    function setForSale(uint256 _tokenId) external {
        address owner = ownerOf(_tokenId);
        require(owner == msg.sender);

        salePrice[_tokenId] = 1 ether;

        // tokensForSale.push(_tokenId);

        emit Approval(owner, address(this), _tokenId);
    }

    function buy(uint256 _tokenId) external payable {
        address buyer = msg.sender;
        uint payedPrice = msg.value;

        require(getApproved(_tokenId) == address(this));
        require(payedPrice >= salePrice[_tokenId], "Insufficient funds");

        // pay the seller
        (bool sent, /* memory data */) = buyer.call{value: msg.value}("");
        require(sent, "Failure! Ether not sent");

        safeTransferFrom(ownerOf(_tokenId), buyer, _tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
} 