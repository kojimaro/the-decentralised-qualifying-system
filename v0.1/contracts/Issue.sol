pragma solidity ^0.5.0;

import "./Qualification.sol";
import "./QualificationMetadata.sol";
import "./QualificationGrantable.sol";
import "./SafeMath.sol";

contract Issue is Qualification, QualificationMetadata, QualificationGrantable {

    using SafeMath for uint256;

    constructor(string memory name, string memory symbol)
    QualificationMetadata(name, symbol)
    public{}

    struct Credential {
        address qualifer;
        string receiverName;
        string name;
        string description;
        string timestamp;
    }

    Credential[] public credentials;

    function write(
        address qualifer, 
        string calldata receiverName, 
        string calldata name, 
        string calldata description,
        string calldata timestamp
    ) external {
        uint credentialId = credentials.push(
            Credential(
                qualifer,
                receiverName,
                name,
                description,
                timestamp
            )
        )-1;

        grant(msg.sender, credentialId);
    }

    function getCredentialIdByVerifier(address owner, address verifier) external view returns(uint[] memory) {
        require(owner != address(0) && verifier != address(0));
        require(isAccess(owner, verifier));
        return _getCredentialId(owner);
    }

    function getCredentialIdByOwner() external view returns(uint[] memory) {
        require(msg.sender != address(0));
        return _getCredentialId(msg.sender);
    }

    function _getCredentialId(address owner) internal view returns(uint[] memory) {
        uint[] memory result = new uint[](balanceOf(owner));
        
        uint256 counter = 0;
        for (uint i = 0; i < credentials.length; i++) {
            if(ownerOf(i) == owner) {
                result[counter] = i;
                counter.add(1);
            }
        }

        return result;
    }
}