const Issue = artifacts.require('Issue.sol');

contract('Issue', function ([receiver, qualifier, verifier, verifier2,outsider, ...accounts]) {
    const name = "KojiryoLaboratory";
    const symbol = "KL";

    it("...is going to confirm a name and a symbol.", async () => {
        const instance = await Issue.deployed();
        let credentialName = await instance.name();
        let credentialSymbol = await instance.symbol();

        assert.equal(credentialName, name, "Name isn't the same.");
        assert.equal(credentialSymbol, symbol, "Symbol isn't the same.");
    });

    it("...is going to grant.", async () => {
        const timestamp = new Date().getTime() / 1000;
        const instance = await Issue.deployed();
        
        await instance.write(
            qualifier,
            "YamadaTarou",
            "SimpleStorageの実装",
            "SimpleStorageの実装をクリアしたことを認定します。",
            timestamp.toString()
        );

        const owner = await instance.ownerOf(0);

        assert.equal(receiver, owner, "receiver isn't the same.");
    });

    it("...is going to approve.", async () => {
        const instance = await Issue.deployed();

        await instance.approve(verifier);
        await instance.approve(verifier2);
        const getVerifier = await instance.getApproved(verifier);
        const getVerifier2 = await instance.getApproved(verifier2);

        assert.equal(getVerifier, true, "verifier don't apploved.");
        assert.equal(getVerifier2, true, "verifier don't apploved.");
    });

    it("...is going to getCredentialIdByVerifier().", async () => {        
        const instance = await Issue.deployed();

        const ids = await instance.getCredentialIdByVerifier(receiver, verifier);

        assert.equal(ids[0], 0, "verifier don't applove.");
    });

    it("...is going to getCredentialIdByOwner().", async () => {        
        const instance = await Issue.deployed();

        const ids = await instance.getCredentialIdByOwner();

        assert.equal(ids[0], 0, "owner wasn't given credeintial.");
    });
});