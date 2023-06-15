const DataAsset = artifacts.require("DataAsset");
const DataAssetFactory = artifacts.require("DataAssetFactory");
const IERC20 = artifacts.require("MockUSDC");

contract("DataAsset and DataAssetFactory", function (accounts) {
  const [owner, buyer] = accounts;
  const tokenId = 1;
  const tokenPrice = 5;
  let factory;
  let USDC;
  let token_address = "";

  before(async function () {
    let createERC20 = await IERC20.new();
    token_address = createERC20.address;
    factory = await DataAssetFactory.new(token_address, { from: owner });
    USDC = await IERC20.at(token_address);
  });

  it("creates a new DataAsset and lists it for sale", async function () {
    await factory.CreateDataAsset(tokenId, { from: owner });
    const ownerAssets = await factory.GetOwnerAssets(owner);
    assert.equal(ownerAssets.length, 1, "Owner should have one asset");
    const dataAssetAddress = ownerAssets[0];
    const dataAsset = await DataAsset.at(dataAssetAddress);
    const assetData = await dataAsset.dataNFTs(tokenId);
    assert.equal(assetData.owner, owner, "Asset owner should be the creator");
    assert.equal(assetData.price, tokenPrice, "Asset price should be correct");
  });

  it("allows a user to purchase a DataAsset", async function () {
    await factory.CreateDataAsset(tokenId, { from: owner });
    const ownerAssets = await factory.GetOwnerAssets(owner);
    const dataAssetAddress = ownerAssets[0];
    const dataAsset = await DataAsset.at(dataAssetAddress);

    const assetPrice = web3.utils.toWei(tokenPrice.toString(), "ether");

    await USDC.transfer(buyer, assetPrice, { from: owner });

    await USDC.approve(dataAssetAddress, assetPrice, { from: buyer });

    await dataAsset.PurchaseAsset(tokenId, { from: buyer });
  });
  it("should give data asset", async function () {
    await factory.CreateDataAsset(tokenId, { from: owner });
    const ownerAssets = await factory.GetOwnerAssets(owner);
    const dataAssetAddress = ownerAssets[0];
    const dataAsset = await DataAsset.at(dataAssetAddress);
    const DDO = await dataAsset.GetDataDDO(tokenId, { from: buyer });
    assert.equal(DDO[0], 'Fake Metadata', 'Metadata should be correct');
    assert.equal(DDO[1], 'https://fakeurl.com', 'URL should be correct');
  });
});
