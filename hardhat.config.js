require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-waffle");
require('dotenv').config();

const ROPSTEN_PRIVATE_KEY = "8f171d0ba3541dad5e3b09c8ee22a367c3c01dbd038e3ed8e7d2469ae132ae0e";
const ETHERSCAN_API_KEY = "6WFC9K5C8E2RC9UF1XIM6ZUG17DHWPIX3N";

module.exports = {
  defaultNetwork: "matic",
  networks: {
    hardhat: {
    },
    matic: {
      url: "https://matic-mumbai.chainstacklabs.com",
      accounts: [ROPSTEN_PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY
  },
  solidity: {
    version: "0.8.0",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
};
