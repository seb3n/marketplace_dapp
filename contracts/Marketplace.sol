// SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "./MarketItem.sol";

/**
FE -> list items for sale (but keep ownership in the owners name)
marketplace methods
- listing service (eg craigslist) - marketplace just lists items and connects buyers and sellers
- single price marketplace (eg amazon) - marketplace lists assets and facilitates purchase without bids/auctions
- bidding marketplace (eg ebay) - marketplace lists assets and facilitates auctions
- market place for NFTs (eg opensea) (not physical items)
- marketplace for exchange of goods 

Developing countries need to buy/sell physical goods more than digital ones
- but one of the problems is security/safety
- so, what if you had a marketplace for people to sell physical things where they could each confirm the exchange
like this

1) seller list items to sell (bananas, etc) and price and location(s) of goods
2) buyer requests purchase and puts funds in escrow
3) seller accepts/rejects purchase request (this is them putting their goods in "escrow" / giving their guaruntee)
4) buyer and seller chat opens and they coordinate time for exchance (if necessary) (chat is safed to ipfs)
5) buyer and seller meet and buyer accepts or rejects the goods (rejections go to dispute mgmt)
to accept, li takes a pic of the goods and marks accept
to reject, li takes a pic of the goods and marks reject with reason (gets all money back except seller travel fee and they vote on what to do with the dispute fee, if different they handle it with a 3rd party)


 */



/**
 * @title Items
 * @dev Implements Marketplace
 */
contract MarketPlace is ReentrancyGuard {
    using Counters for Counters.Counter;

    Counters.Counter private _itemIds; // unik identifer for marketplace item
    Counters.Counter private _itemsSold; // items sold on the market place

    mapping(uint256 => MarketItem) private idToMarketItem; // given item id, what is market item?

    event MarketItemCreated(
        uint256 itemId,
        address nftContract,
        uint256 tokenId,
        address seller,
        address owner,
        uint256 price
    ); // used to trigger event listenners on Front end & || index with the GRAPH when a transaction occured

    /**
     * @notice creates a new item
     * @dev This function is uses nonReentrant to prevent reEntry attacks
     * @dev This function is also payable because we transfer the nft to the contract
     * @param nftContract Contract address that will hold the NFT to be sold.
     * @param tokenId ID of the nft being sold.
     * @param price Price of the nft to be sold.
     */
    function createMarketItem(
        address nftContract,
        uint256 tokenId,
        uint256 price
    ) public payable nonReentrant {
        require(price > 0, "Price must be at least 1 wei");
        _itemIds.increment();
        uint256 itemId = _itemIds.current();
        idToMarketItem[itemId] = MarketItem(
            itemId,
            nftContract,
            tokenId,
            payable(msg.sender),
            payable(address(0)),
            price
        );

        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId); // transfer ownership of NFTtoken to contract

        emit MarketItemCreated(
            itemId,
            nftContract,
            tokenId,
            msg.sender,
            address(0),
            price
        );
    }

    /**
     * @notice creates a market sale
     * @param nftContract provide the contract address of the nft tied to the item being sold.
     * @param itemId provide the item ID of the item being sold.
     */
    function createMarketSale(address nftContract, uint256 itemId)
        public
        payable
        nonReentrant
    {
        uint256 price = idToMarketItem[itemId].price;
        uint256 tokenId = idToMarketItem[itemId].tokenId;
        require(msg.value == price, "Please provide appropriate amount");
        idToMarketItem[itemId].seller.transfer(msg.value); // transfer the funds to owner
        IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId); // transfer ownership of NFTtoken to buyer.
        idToMarketItem[itemId].owner = payable(msg.sender); //transfert market item ownership
        _itemsSold.increment(); // items sold on the market place.
    }

    /**
     * @notice fetch a market place item
     * @dev hint
     */
    function fetchMarketItems() public view returns (MarketItem[] memory) {}

    // /**
    //  * @dev removes items owned by msg.sender
    //  * @param _item_id something
    //  */
    // function removeItem(uint256 _item_id) public  {
    //     // remove items that you own
    // }

    // /**
    //  * @dev
    //  * @param
    //  */
    // function updateItem() public  {
    //     // update the params of the item struct
    // }

    // /**
    //  * @dev gets all items
    //  */
    // function getItems() public view returns (MarketItem[] memory) {
    //     return items;
    // }
    // /**
    //  * @dev transfer ownership of Item(s)
    //  */
    // function transferItems() private view  returns (MarketItem[] memory) {
    //     return items;
    // }
    // /**
    //  * @dev request ownership of Items(s)
    //  */
    // function requestItems() public view returns (MarketItem[] memory) {
    //     return items;
    // }
}
