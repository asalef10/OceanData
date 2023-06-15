const DataAssetFactory = artifacts.require("DataAssetFactory");
const USDC_TOKEN_ADDRESS = "0x233175cecC981aedDcFbe4fB15A462B221f3C8C0";
module.exports = function (deployer) {
  deployer.deploy(DataAssetFactory, USDC_TOKEN_ADDRESS);
};
