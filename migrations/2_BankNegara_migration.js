var BankNegara = artifacts.require("./BankNegara.sol");

module.exports = function (deployer) {
  deployer.deploy(BankNegara);
};
