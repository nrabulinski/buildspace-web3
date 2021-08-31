open Ethers
open Promise
open Belt
@module external s: {..} = "./App.module.css"

@scope("window") @val
external alert: 'a => unit = "alert"

let noop = (_) => { () }

@react.component
let default = () => {
	let lazy(ethereum) = ethereum
	let address = "0xb4fA90789212e2851A96274226A00e22d020041F"
	let (wallet, setWallet) = React.useState(() => None)
	let (loading, setLoading) = React.useState(() => false)
	let (count, setCount) = React.useState(() => None)

	let updateCount = React.useCallback1(contract => contract
		->getTotalWaves
		->thenResolve(count => setCount(_ => Some(count->toString))), [setCount])

	React.useEffect4(() => {
		switch (wallet, ethereum) {
			| (Some(_), Some(ethereum)) => {
				let signer = web3Provider(ethereum)->getSigner
				let contract = contract(address, abi["abi"], signer)

				updateCount(contract)
					->ignore
			}
			| _ => ()
		}

		None
	}, (wallet, address, ethereum, updateCount))

	React.useEffect2(() => {
		switch ethereum {
			| None => ()
			| Some(ethereum) => ethereum
				->request("eth_accounts")
				->thenResolve(accounts => setWallet(_ => accounts->Array.get(0)))
				->ignore
		}

		None
	}, (ethereum, setWallet))

	let connectWallet = (_) => {
		switch ethereum {
			| None => alert("Get metamask!")
			| Some(ethereum) => ethereum
				->request("eth_requestAccounts")
				->thenResolve(accounts => setWallet(_ => accounts->Array.get(0)))
				->catch(e => e->alert->resolve)
				->ignore
		}
	}

	let wave = (_) => switch ethereum {
		| None => ()
		| Some(ethereum) => Promise.resolve(setLoading(_ => true))
			->then(() => {
				let signer = web3Provider(ethereum)->getSigner
				let contract = contract(address, abi["abi"], signer)

				contract->wave->thenResolve(txn => (txn, contract))
			})
			->then(((txn, contract)) => {
				Js.log2("Mining", txn->hash)
				txn->wait->thenResolve(() => contract)
			})
			->then(updateCount)
			->thenResolve(() => setLoading(_ => false))
			->ignore
	}

	<div className={s["main"]}>
		<div className={s["header"]}>
			<h1 className={s["h"]}>{React.string(`Hello there!`)}</h1>
			<div>
				<button className={`${s["btn"]} ${wallet->Option.isSome ? loading ? s["loading"] : "" : s["disabled"]}`} onClick={wallet->Option.isSome ? wave : noop}>
					<span className={s["hand"]}>{React.string(`👋`)}</span>{React.string(" Wave at me")}
				</button>
				<button className={s["btn"]} onClick={connectWallet}>
					<span className={s["hand"]}>{React.string(`💳`)}</span>{React.string(" Connect your wallet")}
				</button>
			</div>
			<p className={`${s["counter"]} ${count->Option.isSome ? "" : s["hidden"]}`}>{React.string(`I've been waved at ${count->Option.getWithDefault("0")} times`)}</p>
		</div>
		<div className={s["content"]}>
			<h2>{React.string(`What is this? 🤔`)}</h2>
			<p>{React.string(`I don't know yet 🤷, we'll see as the course progresses`)}</p>
		</div>
	</div>
}
