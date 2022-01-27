// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;


import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

// interface AggregatorV3Interface {
//   function decimals() external view returns (uint8);

//   function description() external view returns (string memory);

//   function version() external view returns (uint256);

//   // getRoundData and latestRoundData should both raise "No data present"
//   // if they do not have data to report, instead of returning unset values
//   // which could be misinterpreted as actual reported values.
//   function getRoundData(uint80 _roundId)
//     external
//     view
//     returns (
//       uint80 roundId,
//       int256 answer,
//       uint256 startedAt,
//       uint256 updatedAt,
//       uint80 answeredInRound
//     );

//   function latestRoundData()
//     external
//     view
//     returns (
//       uint80 roundId,
//       int256 answer,
//       uint256 startedAt,
//       uint256 updatedAt,
//       uint80 answeredInRound
//     );
// }
contract FundMe {
    using SafeMathChainlink for uint256;

    mapping(address => uint256) public addressToAmoundFunded;

    address public owner;
    constructor() public {
      owner = msg.sender;
    }

    function fund() public payable {
        // msg is a keyword 
        // msg.sender is as sender of this function call
        // msg.value is how much they sent

        // $50
        uint256 minimumUSD = 50 * 10 ** 18;
        require(getConversionRate(msg.value) >= minimumUSD,
          "You need to spend more ETH!");

        addressToAmoundFunded[msg.sender] += msg.value;

        // what the ETH -> USD conversion rate
    }

    function getVersion() public view returns(uint256) {
        // https://docs.chain.link/docs/ethereum-addresses/
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }
    function getDecimals() public view returns(uint256) {
        // https://docs.chain.link/docs/ethereum-addresses/
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

        // 8
        return priceFeed.decimals();
    }


    function getPrice() public view returns(uint256) {
      // https://docs.chain.link/docs/ethereum-addresses/
      AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
      (,int256 answer,,,) = priceFeed.latestRoundData();

      // eight decimals
      return uint256(answer * 10000000000);
    }
    
    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
      uint256 ethPrice = getPrice();
      // 1000000000000000000 18 0s
      uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
      return ethAmountInUsd;
    }

    function withdraw() payable public {
      // requiere msg.sender = owner
      require(msg.sender == owner);
      // transfer to sender
      // 'this' is this contract
      msg.sender.transfer(address(this).balance);
    }
}