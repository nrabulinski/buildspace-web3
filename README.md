# 👋 Wave portal
Toy project for learning about smart contracts, Ethereum and web3.  
Following course by https://buildspace.so

You can see live deployed version over on https://waveportal.vercel.app/

## Project structure
The root folder contains the source for smart contracts related to this project.

Folder `frontend` contains React web app for interacting with the contract.  
For build instructions on the frontend consuld `frontend/README.md`

## Dependencies
This project is developed with Node v16.4.0 and pnpm 6.12.0.  
Older Node version or other package managers should work, but I don't guarantee anything.

## Setup
```bash
git clone git@github.com:nrabulinski/buildspace-web3.git
pnpm install
```

## Building
```bash
pnpm re:build
pnpx hardhat run scripts/run.bs.js
```
