const Issue = artifacts.require("./Issue.sol");

module.exports = async(deployer, network, accounts) => {
    const name = "KojiryoLaboratory";
    const symbol = "KL";

    await deployer.deploy(
        Issue,
        name,
        symbol
    );
};
