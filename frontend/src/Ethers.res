@module external _abi: {..} = "./utils/WavePortal.json"
let abi: {..} = _abi["default"]

type ethereum
@scope("window") @val
external _ethereum: Js.Nullable.t<ethereum> = "ethereum"

let ethereum = lazy(Js.Nullable.toOption(_ethereum))

type account
@send external _request: (ethereum, {..}) => Js.Promise.t<array<account>> = "request"

let request = (ethereum, method) => {
	ethereum->_request({ "method": method })
}

type provider
@module("ethers") @scope("providers") @new 
external web3Provider: ethereum => provider = "Web3Provider"

type signer
@send external getSigner: provider => signer = "getSigner"

type contract
@module("ethers") @new 
external contract: (string, string, signer) => contract = "Contract"

type bigNumber
@send external toString: bigNumber => string = "toString"

@send external getTotalWaves: contract => Js.Promise.t<bigNumber> = "getTotalWaves"

type waveTxn
@send external wait: waveTxn => Js.Promise.t<unit> = "wait"
@get external hash: waveTxn => string = "hash"

@send external wave: contract => Js.Promise.t<waveTxn> = "wave"
