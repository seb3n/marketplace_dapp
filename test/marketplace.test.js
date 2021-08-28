const contractName = artifacts.require("Marketplace");
const nftContract = artifacts.require("./ItemNft.sol");
const { sampleItem, noItems } = require("./testData.js");

contract(contractName.name, (accounts) => {
    let contractInstance;
    let result;
    let expected;
    const [alice, bob] = accounts;
    let nftContractAddress;


    // PRE-DEPLOYMENT TESTS

    // POST-DEPLOYMENT TESTS
    // contractInstance = await contractName.deployed();

    before(async () => {
        contractInstance = await contractName.deployed();//.new();
        nftcContractInstance = await nftContract.deployed();
        nftContractAddress = nftcContractInstance.address

    });

    // it("can fetch the list of items", async () => {
    //     // result = await contractInstance.getItems();
    //     // contractInstance.idToMarketIte
    //     expect(result).to.be.empty;
    //     // assert.deepEqual(result, expected, "No items should be shown.");
    // });


    describe('creating an item', async () => {
        before(`create an item using alice's account (${alice})`, async () => {
            // result = await contractInstance.createMarketItem(
            //     address(0x0),
            //     1,
            //     10,
            //     { from: alice }
            // ); // This acount should come from ganache.
            // console.log(result);
        });
        it("can transfer ownership to contract", async () => { 
            console.log(nftContractAddress);
            // console.log(nftcContractInstance);
            result = await contractInstance.createMarketItem(
                nftcContractInstance.address,
                1,
                10,
                { from: alice }
            ); // This acount should come from ganache.
            console.log(result);
        });
        // it("can get items with one item in list", async () => {
        //     result = await contractInstance.getItems();
        //     expected = [newItem];
        //     expect(result).to.deep.equal(expected);
        //     // assert.deepEqual(result, expected, "The owner of the item should be the first account.");
        // });
    });
});