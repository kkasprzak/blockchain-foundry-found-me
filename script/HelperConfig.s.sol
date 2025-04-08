// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

abstract contract NetworkConfig is Script {
    struct Config {
        address priceFeed;
    }

    function getConfig() public virtual returns (Config memory);
}

contract SepoliaNetworkConfig is NetworkConfig {
    function getConfig() public pure override returns (Config memory) {
        return Config({priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
    }
}

contract MainnetNetworkConfig is NetworkConfig {
    function getConfig() public pure override returns (Config memory) {
        return Config({priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419});
    }
}

contract AnvilNetworkConfig is NetworkConfig {
    uint8 private constant DECIMALS = 8;
    int256 private constant INITIAL_PRICE = 2000e8; // 2000 USD with 8 decimals
    Config private s_config;

    function getConfig() public override returns (Config memory) {
        if (s_config.priceFeed != address(0)) {
            return s_config;
        }

        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();

        s_config = Config({priceFeed: address(mockPriceFeed)});

        return s_config;
    }
}

contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = new SepoliaNetworkConfig();
        } else if (block.chainid == 1) {
            activeNetworkConfig = new MainnetNetworkConfig();
        } else {
            activeNetworkConfig = new AnvilNetworkConfig();
        }
    }

    function getActiveNetworkConfig() public returns (NetworkConfig.Config memory) {
        return activeNetworkConfig.getConfig();
    }
}
