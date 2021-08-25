// SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./ItemStruct.sol";

/**
 * @title Items
 * @dev Implements items
 */
contract Items is Ownable {
    Item[] public items;
    address[] public user;

    event NewItem(uint256 id);

    /**
     * @dev creates a new item
     * @param _title as defined in ItemStruct
     */
    function create(
        string memory _title,
        string memory _description,
        uint256 _price,
        uint256[] memory _attached_media,
        bytes32[] memory _tags
    ) public {
        Item memory newItem = Item({
            owner: msg.sender,
            title: _title,
            description: _description,
            price: _price,
            attached_media: _attached_media,
            tags: _tags
        });

        items.push(newItem);

        // Note - assumes list doesn't get reordered...not a hardened solution
        emit NewItem(items.length);
    }

    /**
     * @dev removes items owned by msg.sender
     * @param _item_id something
     */
    function remove(uint256 _item_id) public onlyOwner {
        // remove items that you own
    }

    /**
     * @dev
     * @param
     */
    function update() public onlyOwner {
        // update the params of the item struct
    }

    /**
     * @dev gets all items
     */
    function getItems() public view returns (Item[] memory) {
        return items;
    }
}
