const contractName = artifacts.require("Items");
const { sampleItem, noItems } = require("./TestData.js");

contract("Items", (accounts) => {
    let contractInstance;
    let result;
    let expected;
    const [alice, bob] = accounts;
    const empty = (null || '' || [] || '[]');

    // Get the contract
    before(async () => {
        result = null;
        expected = null;
        // contractInstance = await contractName.deployed();

        // Test contract without deploying
        contractInstance = await contractName.new();
    });

    it("can fetch the list of items", async () => {
        result = await contractInstance.getItems();
        expected = empty;
        assert.deepEqual(result, expected, "No items should be shown.");
    });


    describe('creating an item', async () => {
        before(`create an item using alice's account (${alice})`, async () => {
            result = await contractInstance.create(
                sampleItem.title,
                sampleItem.description,
                sampleItem.price,
                sampleItem.attached_media,
                sampleItem.tag,
                { from: alice }
            ); // This acount should come from ganache.
        });
        // expected = alice;
        // it("can fetch the items of a user by item id", async () => {
        //     let items = await contractInstance.items(0);
        //     assert.equal(items.owner, expectedUser, "The owner of the item should be the first account.");
        // });
    });
});