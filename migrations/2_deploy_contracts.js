var Marketplace = artifacts.require("Marketplace");
var ItemNFT = artifacts.require("ItemNft");

module.exports = function (deployer) {
    deployer.deploy(Marketplace).then(function () {
        return deployer.deploy(ItemNFT, Marketplace.address);
    });

}