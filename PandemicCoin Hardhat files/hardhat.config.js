require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config()
/** @type import('hardhat/config').HardhatUserConfig */
const MUMBAI_API_KEY = "tMXNMqXM6uir3cg3stybGsmPM6h0vtIY";
const MUMBAI_PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
  solidity: "0.8.19",

  networks: {
    mumbai:{
      url: `https://polygon-mumbai.g.alchemy.com/v2/${MUMBAI_API_KEY}`,
      accounts: [`${MUMBAI_PRIVATE_KEY}`], 
    }
  }
};
