const hre = require("hardhat");

async function main() {
  const ThanhNFT = await ethers.getContractFactory("ThanhNFT");
  const nft = await ThanhNFT.deploy("Luna", "TR");

  await nft.deployed();
  console.log("Successfully deployed smart contract to: ", nft.address);

  await nft.mint("https://ipfs.io/ipfs/QmWQviFmvbiza5BRdttazctFpCBAXwnzvdB2KwvAXuV4ws");
  console.log("NFT successfully minted");
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });