require('@nomiclabs/hardhat-waffle');
require('dotenv').config({path:__dirname+'/.env'})

module.exports = {
  solidity: '0.8.1',
  networks: {
    rinkeby: {
      url: process.env.HTTP,
      accounts: [process.env.METAMASK_PRIVATE_KEY],
    },
  },
};