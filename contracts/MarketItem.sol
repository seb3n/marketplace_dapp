// SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

/**
 * @title Item
 * @dev Declares an Item struct
 */
struct MarketItem {
    uint256 itemId;
    address nftContract;
    uint256 tokenId;
    address payable seller;
    address payable owner;
    uint256 price;
}
