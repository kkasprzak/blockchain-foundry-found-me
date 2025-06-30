# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is a Solidity smart contract project built with Foundry that implements a crowdfunding contract (FundMe). The contract allows users to fund it with ETH while enforcing a minimum USD contribution via Chainlink price feeds. Only the contract owner can withdraw the accumulated funds.

## Key Commands

### Build & Testing
- `forge build` - Compile contracts
- `forge test` - Run full test suite
- `forge test --match-test testFunctionName` - Run specific test
- `forge test --match-contract ContractName` - Run tests for specific contract
- `forge test --fork-url $SEPOLIA_RPC_URL` - Run tests against forked network
- `forge snapshot` - Generate gas usage snapshots
- `forge fmt` - Format Solidity code

### Deployment
- `make deploy-sepolia` - Deploy to Sepolia testnet (uses Makefile)
- `forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> --broadcast` - Manual deployment

### Interactions
- `forge script script/Interactions.s.sol:FundFundMe --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> --broadcast` - Fund the contract
- `forge script script/Interactions.s.sol:WithdrawFundMe --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> --broadcast` - Withdraw funds

## Architecture

### Core Contracts
- **FundMe.sol**: Main crowdfunding contract with minimum USD threshold enforcement
- **PriceConverter.sol**: Library for ETH/USD price conversions using Chainlink price feeds

### Configuration & Deployment
- **HelperConfig.s.sol**: Network configuration abstraction with inheritance pattern
  - Supports Sepolia, Mainnet, and local Anvil networks
  - Uses MockV3Aggregator for local testing
  - Implements abstract NetworkConfig pattern for multi-chain deployment
- **DeployFundMe.s.sol**: Deployment script that uses HelperConfig for network-specific configurations

### Testing Architecture
- **Unit Tests** (`test/unit/`): Test individual contract functionality in isolation
- **Integration Tests** (`test/integration/`): Test interactions between contracts
- **Mock Contracts** (`test/mocks/`): MockV3Aggregator for price feed simulation

### Key Design Patterns
1. **Library Pattern**: PriceConverter is a library attached to uint256
2. **Configuration Inheritance**: NetworkConfig abstract contract with network-specific implementations
3. **Multi-network Support**: Chain ID-based configuration selection
4. **Foundry DevOps Integration**: Uses foundry-devops for deployment address tracking

## Dependencies
- **Chainlink Contracts**: For AggregatorV3Interface and price feeds
- **Forge-std**: Standard Foundry testing and scripting utilities
- **Foundry DevOps**: For deployment management and address tracking

## Environment Setup
- Environment variables are loaded from `.env` file via Makefile
- Required variables: `SEPOLIA_RPC_URL`, `PRIVATE_KEY`, `ETHERSCAN_API_KEY`
- Uses `ffi = true` in foundry.toml for external function calls

## Testing Patterns
- Uses `makeAddr("user")` for test user addresses
- Implements `funded` modifier for common test setup
- Uses `vm.deal()` for giving test accounts ETH
- Tests include gas price considerations and multi-funder scenarios