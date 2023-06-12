const DataAssetFactory = artifacts.require("DataAssetFactory");

module.exports = function(deployer) {
  deployer.deploy(DataAssetFactory);
};
