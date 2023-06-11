const DataAsset = artifacts.require("DataAsset");

module.exports = function (deployer) {
  deployer.deploy(DataAsset);
};
