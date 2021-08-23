pragma solidity >=0.4.22 <0.9.0;

/**
 * @title Item
 * @dev Declares an Item struct
 */
struct Item {
    uint256 uid;
    uint256 price;
    uint256 preview_img_idx;
    uint256 attached_media;
    uint256 title;
    uint256 description;
    uint256 list_date;
    address owner;
    string tags;
}
