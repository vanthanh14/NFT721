const { expect } = require('chai')
const { ethers } = require("hardhat")

describe("Test NFT721", function() {

  let owner, addr1, addr2, addr3, addrs;
  
  this.beforeEach(async function() {
    // This is executed before each test
    // Deploying the smnart contract
    [owner, addr1, addr2, addr3, addrs] = await ethers.getSigners();
    const NFT = await ethers.getContractFactory("ThanhNFT");
    nft = await NFT.deploy("Luna", "TR");
  });

  describe("Testing for deployment", function() {
    it ("Deploy complete", async function() {
      expect(await nft.ownerOf()).to.equal(owner);
    });
  });

  de
});