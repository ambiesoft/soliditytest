// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract SimpleStorage {
    uint256 favoriteNumber;
    // bool favoriteBool = false;
    // string favoriteString = "String";
    // int256 favoriteInt = -5;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // People public person = People({ favoriteNumber:2 ,name: "Patrick"});
    People[] public people;
    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    // momery: dualing execution
    // storage: keep it
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
