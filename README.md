# FundMe

FundMe is a Solidity smart contract built with Foundry that allows users to fund the contract with ETH, enforcing a minimum USD contribution via Chainlink price feeds. Each funder's contribution is recorded, and only the contract owner can withdraw the accumulated funds.

## Prerequisites

- [Foundry](https://book.getfoundry.sh/) (forge, cast, anvil)
- An RPC endpoint (Infura, Alchemy, etc.) and a funded private key for deployments

## Installation

1. Clone the repository
   ```bash
   git clone https://github.com/your-username/foundry-found-me-f23.git
   cd foundry-found-me-f23
   ```
2. Install dependencies
   ```bash
   forge install
   ```

## Usage

### Build

Compile the contracts:
```bash
forge build
```

### Test

Run the full test suite:
```bash
forge test
```

Generate gas-usage snapshots:
```bash
forge snapshot
```

### Deploy

Deploy to your target network (e.g. Sepolia):
```bash
forge script script/DeployFundMe.s.sol:DeployFundMe \
  --rpc-url <YOUR_RPC_URL> \
  --private-key <YOUR_PRIVATE_KEY> \
  --broadcast
```

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you'd like to change.
Ensure any new code is covered by tests and that `forge fmt` and `forge lint` pass before submitting.

## License

MIT
