// SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

/**
 * @title Item
 * @dev Declares an Item struct
 */
struct Item {
    // TODO - see if there are optimizations or potential to reduce storage
    string title;
    string description;
    address owner;
    uint256 price;
    // TODO: - are IPFS hashes uint256, address or something else
    uint256[] attached_media;
    // uint256 creation_date;
    bytes32[] tags;
}
