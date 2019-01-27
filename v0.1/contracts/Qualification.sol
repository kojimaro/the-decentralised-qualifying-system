pragma solidity ^0.5.0;

import "./SafeMath.sol";

contract Qualification {
    event Transfer(address indexed from, address indexed to, uint256 indexed credentialId);

    event Approval(address indexed owner, address indexed approved);

    using SafeMath for uint256;

    // Mapping from credential ID to owner
    mapping (uint256 => address) private _credentialOwner;

    // Mapping from owner to number of owned credential
    mapping (address => uint256) private _ownedCredentialCount;

    mapping (address => mapping(address => bool)) private _approvals;

    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0));
        return _ownedCredentialCount[owner];
    }

    function ownerOf(uint256 credentialId) public view returns (address) {
        address owner = _credentialOwner[credentialId];
        require(owner != address(0));
        return owner;
    }

    function isAccess(address owner, address verifier) public view returns(bool) {
        return _approvals[owner][verifier];
    }

    function approve(address verifier) public {
        require(verifier != msg.sender);

        _approvals[msg.sender][verifier] = true;
        emit Approval(msg.sender, verifier);
    }

    function getApproved(address verifier) public view returns (bool) {
        require(verifier != address(0));
        return _approvals[msg.sender][verifier];
    }

    function _exists(uint256 credentialId) internal view returns (bool) {
        address owner = _credentialOwner[credentialId];
        return owner != address(0);
    }

    function _grant(address to, uint256 credentialId) internal {
        require(to != address(0));
        require(!_exists(credentialId));

        _credentialOwner[credentialId] = to;
        _ownedCredentialCount[to] = _ownedCredentialCount[to].add(1);

        emit Transfer(address(0), to, credentialId);
    }
}