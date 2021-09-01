const contractName = artifacts.require("Marketplace");
const { sampleItem, noItems } = require("./testData.js");

contract(contractName.name, (accounts) => {
    let contractInstance;
    let result;
    let expected;
    const [alice, bob] = accounts;


    // PRE-DEPLOYMENT TESTS

    // POST-DEPLOYMENT TESTS
    // contractInstance = await contractName.deployed();

    before(async () => {
        contractInstance = await contractName.new();
    });

    it("can fetch the list of items", async () => {
        result = await contractInstance.getItems();
        expect(result).to.be.empty;
        // assert.deepEqual(result, expected, "No items should be shown.");
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
        it("can get items with one item in list", async () => {
            result = await contractInstance.getItems();
            expected = [newItem];
            expect(result).to.deep.equal(expected);
            // assert.deepEqual(result, expected, "The owner of the item should be the first account.");
        });
    });
});