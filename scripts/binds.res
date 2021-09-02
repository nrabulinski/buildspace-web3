type ethers
@val external ethers: ethers = "ethers"

type hre = {
	ethers: ethers
}
@val external hre: hre = "hre"

type bigNumber
@send external toString: bigNumber => string = "toString"

type signer = {
	address: string
}
@send external getSigners: ethers => Js.Promise.t<(signer, signer)> = "getSigners"
@send external getBalance: signer => Js.Promise.t<bigNumber> = "getBalance"

type waveContractFactory
@send external getWaveContractFactory: (ethers, @as("WavePortal") _) => Js.Promise.t<waveContractFactory> = "getContractFactory"

type waveContract = {
	address: string
}
@send external deploy: waveContractFactory => Js.Promise.t<waveContract> = "deploy"

@send external deployed: waveContract => Js.Promise.t<unit> = "deployed"

@send external connect: (waveContract, signer) => Js.Promise.t<waveContract> = "connect"

// Bindings to WavePortal.sol
type wave = {
	waver: string,
	message: string,
	timestamp: bigNumber
}
type waveTxn
@send external wait: waveTxn => Js.Promise.t<unit> = "wait"

@send external wave: (waveContract, string) => Js.Promise.t<waveTxn> = "wave"
@send external getTotalWaves: waveContract => Js.Promise.t<bigNumber> = "getTotalWaves"
@send external getAllWaves: waveContract => Js.Promise.t<array<wave>> = "getAllWaves"
