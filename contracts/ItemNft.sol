// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

import "./ItemsManager.sol";

/**
 * @title manages item as ERC721 token (NFT)
 * @dev use ERC721Storage to allow storing the IPFS URI of item NFT
 */
contract ItemOwnership is ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    address contractAddress;

    /**
     * @dev mp contract address required because we will need to give mp contract
     * permission to transfer ownership of items
     * @param marketplaceContractAddress is the marketplace contract address
     */
    constructor(address marketplaceContractAddress)
        ERC721("Our MarketPlace", "OMP")
    {
        //sets the contract addr to the marketplace addr
        contractAddress = marketplaceContractAddress;
    }

    /**
     * @notice create an nft token (item)
     * @param tokenURI is the uri to your ipfs storage
     * @return id of the new item
     */
    function createToken(string memory tokenURI) public returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        setApprovalForAll(contractAddress, true);

        return newItemId;
    }
}
