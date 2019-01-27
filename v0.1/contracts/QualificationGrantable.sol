pragma solidity ^0.5.0;

import "./Qualification.sol";

contract QualificationGrantable is Qualification {
    function grant(address to, uint256 credentialId) public returns(bool) {
        _grant(to, credentialId);
        return true;
    }
}