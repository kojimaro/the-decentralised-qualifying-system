pragma solidity ^0.5.0;

contract QualificationMetadata {
    string private _name;
    string private _symbol;

    constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;
    }

    function name() external view returns(string memory) {
        return _name;
    }

    function symbol() external view returns(string memory) {
        return _symbol;
    }
}
