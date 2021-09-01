const contractName = artifacts.require("ItemNft");

contract(contractName.name, (accounts) => {
    const [alice, bob] = accounts;
    let contract;
    let tokenID;
    let totalSupply;
    before('deploy cotract', async () => {
        contract = await contractName.deployed();
    });

    describe('deployment', async () => {
        it('deploys successfully', async () => {

            const address = contract.address;
            console.log(address);
            assert.notEqual(address, '');
            assert.notEqual(address, 0x0);
            assert.notEqual(address, undefined);
            assert.notEqual(address, null);
        });
        it('has a name', async () => {
            const name = await contract.name();
            assert.equal(name, 'Our MarketPlace')
        }); it('has a symbol', async () => {
            const symbol = await contract.symbol();
            assert.equal(symbol, 'OMP')
        });
    })

    describe('createToken', async () => {

        before(`Create a token using alice account: ${alice}`, async () => {
            tokenID = await contract.createToken('google.com', { from: alice });
            // totalSupply = await contract.
            // console.log(tokenID);
            // const event = tokenID.logs[0].args;
            // console.log(event);
            // console.log(event.tokenId.toNumber());
        });
        it('Can get token ID', async () => {
            const tokenEvent = tokenID.logs[0].args;
            const id = tokenEvent.tokenId.toNumber()
            const to = tokenEvent.to;
            const from = tokenEvent.from;
            assert.equal(id, 1);
            assert.equal(to, alice, 'the correct address was not found');
            assert.equal(from, 0x0);

        });
    });
});