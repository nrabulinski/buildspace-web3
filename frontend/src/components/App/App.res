open Ethers
open Promise
open Belt
@module external s: {..} = "./App.module.css"

@scope("window") @val
external alert: 'a => unit = "alert"

@react.component
let default = () => {
	let lazy(ethereum) = ethereum
	let address = "0x5E6ff6E0Fc04265EBD102bf16A89Cc3892135a85"
	let (modal, setModal) = React.useState(() => false)
	let (wallet, setWallet) = React.useState(() => None)
	let (transactionPending, setTransactionPending) = React.useState(() => 0)
	let (waves, setWaves) = React.useState(() => [])

	let (message, setMessage) = React.useState(() => "")

	React.useEffect4(() => switch (wallet, ethereum) {
		| (Some(_), Some(ethereum)) => {
			let signer = web3Provider(ethereum)->getSigner
			let contract = contract(address, abi["abi"], signer)

			let handleWave = (waver, timestamp, message) => 
				setWaves(arr => Array.concat(
					[{ waver, timestamp, message }],
					arr
				))

			contract->on(#newWave(handleWave))->ignore

			contract->getAllWaves
				->thenResolve(arr => setWaves(_ => arr->Array.reverse))
				->ignore

			Some(() => {
				contract->off(#newWave(handleWave))
					->ignore
			})
		}
		| _ => None
	}
	, (wallet, address, ethereum, setWaves))

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

	let connectWallet = (_) => switch ethereum {
		| None => alert("Get metamask!")
		| Some(ethereum) => ethereum
			->request("eth_requestAccounts")
			->thenResolve(accounts => setWallet(_ => accounts->Array.get(0)))
			->catch(e => e->alert->resolve)
			->ignore
	}

	let openModal = (_) => switch (ethereum, wallet) {
		| (Some(_), Some(_)) => setModal(_ => true)
		| _ => ()
	}

	let submitMessage = (_) => switch (ethereum, wallet) {
		| (Some(ethereum), Some(_)) => Promise.resolve(setTransactionPending(x => x + 1))
			->then(() => {
				let signer = web3Provider(ethereum)->getSigner
				let contract = contract(address, abi["abi"], signer)

				contract->wave(message)
			})
			->then(txn => txn->wait)
			->thenResolve(() => {
				setTransactionPending(x => x - 1)
				setModal(_ => false)
			})
			->ignore
		| _ => ()
	}

	<div className={s["main"]}>
		<Modal handleClose={() => setModal(_ => false)} isOpen={modal}>
			<h3>{React.string("Drop me a message if you'd like")}</h3>
			<textarea value={message} onChange={e => setMessage(_ => ReactEvent.Synthetic.target(e)["value"])} className={s["message"]}></textarea>
			<button onClick={submitMessage} className={s["message_btn"]}>{React.string(`👋 Wave`)}</button>
		</Modal> 
		<div className={s["header"]}>
			<h1 className={s["h"]}>{React.string(`Hello there!`)}</h1>
			<div className={s["header_btns"]}>
				<button className={`${s["btn"]} ${transactionPending > 0 ? s["loading"] : ""} ${wallet->Option.mapWithDefault(s["disabled"], _ => "")}`} onClick={openModal}>
					<span className={s["hand"]}>{React.string(`👋`)}</span>{React.string("Wave at me")}
				</button>
				<button className={`${s["btn"]} ${transactionPending > 0 ? s["disabled"] : ""}`} onClick={connectWallet}>
					<span className={s["card"]}>{React.string(`💳`)}</span>{React.string("Connect your wallet")}
				</button>
			</div>
			<p className=s["counter"]>{React.string(`I've been waved at ${waves->Array.length->Int.toString} times`)}</p>
		</div>
		<div className={s["content"]}>
			<h2>{React.string("Latest waves")}</h2>
			<>
			...{React.array(waves->Array.map(wave => {
				<Card 
					address={wave.waver}
					content={wave.message}
					timestamp={wave.timestamp}
				/>
			}))}
			</>
		</div>
		<footer>
			{React.string(`© 2021 Nikodem Rabuliński`)}
		</footer>
	</div>
}
