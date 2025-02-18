# Decentralized Prediction Market for Sports Betting

A blockchain-based platform that enables transparent, trustless sports betting through smart contracts.

## Overview

This decentralized application (DApp) allows users to place bets on sports events without relying on centralized bookmakers. The system uses smart contracts to create events, manage bets, verify results, and distribute winnings automatically.

## Architecture

The platform consists of four main smart contracts:

1. **Event Contract:** Creates and manages sports events for betting
    - Defines event parameters (teams, date, sport type)
    - Handles event lifecycle (open, in progress, finalized)
    - Provides event verification

2. **Betting Contract:** Handles user bets and odds calculation
    - Manages bet placement
    - Calculates dynamic odds based on betting pool
    - Tracks user positions
    - Implements risk management

3. **Oracle Contract:** Provides verified sports results
    - Integrates with trusted data providers
    - Implements consensus mechanism for result verification
    - Resolves disputes when results are contested

4. **Payout Contract:** Manages winnings distribution
    - Calculates winnings based on odds and bet amount
    - Handles automatic payouts to winning wallets
    - Manages platform fees
    - Handles escrow for disputed results

## Features

- **Trustless Betting:** No central authority controls funds or results
- **Transparent Odds:** All odds calculation happens on-chain
- **Verifiable Results:** Multi-oracle consensus for result reporting
- **Automated Payouts:** Smart contracts distribute winnings immediately after events conclude
- **Low Fees:** Eliminates middlemen to reduce betting costs
- **Global Access:** Available to anyone with a crypto wallet

## Getting Started

### Prerequisites

- Ethereum wallet (MetaMask recommended)
- Some ETH for gas fees
- Test tokens for betting (on testnet)

### Installation

1. Clone the repository
   ```
   git clone https://github.com/yourusername/decentral-sports-betting.git
   cd decentral-sports-betting
   ```

2. Install dependencies
   ```
   npm install
   ```

3. Configure environment variables
   ```
   cp .env.example .env
   # Edit .env with your configuration
   ```

4. Run local development environment
   ```
   npm run dev
   ```

### Smart Contract Deployment

1. Deploy to testnet
   ```
   npx hardhat run scripts/deploy.js --network ropsten
   ```

2. Verify contracts on Etherscan
   ```
   npx hardhat verify --network ropsten DEPLOYED_CONTRACT_ADDRESS
   ```

## Usage

1. Connect your wallet to the DApp
2. Browse available sports events
3. Place bets on your chosen outcomes
4. Wait for event results to be reported by oracles
5. Claim winnings automatically sent to your wallet

## Security Considerations

- **Smart Contract Audits:** All contracts have been audited by [Audit Firm]
- **Oracle Redundancy:** Multiple data sources prevent manipulation
- **Emergency Pause:** Admin can pause contracts in case of critical bugs
- **Phased Rollout:** Limited betting amounts during initial launch

## Roadmap

- **Q1 2023:** Launch on testnet with football events
- **Q2 2023:** Mainnet launch with major sports leagues
- **Q3 2023:** Add DAO governance for platform parameters
- **Q4 2023:** Integrate layer 2 scaling solution for lower gas fees
- **Q1 2024:** Support for esports and special events betting

## Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

Project Link: [https://github.com/yourusername/decentral-sports-betting](https://github.com/yourusername/decentral-sports-betting)

## Acknowledgements

- [Chainlink](https://chain.link/) for oracle services
- [OpenZeppelin](https://openzeppelin.com/) for smart contract templates
- [Ethereum Foundation](https://ethereum.org/) for blockchain infrastructure
