# 👋 Wave portal
This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

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

## Running

### Development mode
```bash
pnpm start
```
For initial build and to start the development server.  
While the server is running you can execute `pnpm re:build` in this folder to re-build frontend ReScript code.

### Production
```bash
pnpm build
```
Will produce the production build
