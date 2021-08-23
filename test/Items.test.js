const Items = artifacts.require("Items");
const { sampleItem, noItems } = require("./TestData.js");

contract("Items", (accounts) => {
    let itemsContract;

    // Get the contract
    before(async () => {
        itemsContract = await Items.deployed();
    });

    // Check getItems() iff no items, iff > 0 items
    it("can fetch the list of items", async () => {
        const items = await itemsContract.getItems();
        assert.equal(items, [], "The items list should be empty if none have been added");
    });


    describe('creating an item', async () => {
        before("create an item using accounts[0]", async () => {
            const i = sampleItem;
            await itemsContract.create(_title = i.title, _description = i.description, _price = i.price, _attached_media = i.attached_media, _tag = i.tag, {
                from: accounts[0]
            }); // This acount should come from ganache.
            expectedUser = accounts[0];
        });
        // it("can fetch the items of a user by item id", async () => {
        //     const user = await itemsContract.users(9);
        //     assert.equal(user, expectedUser, " The owner of the item should be the first account.");
        // });
    });
});