open Promise
open Binds

hre.ethers
	->getWaveContractFactory
	->then(factory => factory->deployWithValue(0.1))
	->then(contract => {
		Js.log2("Contract address:", contract.address)
		all2((
			contract->getTotalWaves,
			Utils.getBalance(contract.address)
		))
		->thenResolve(((count, balance)) => (contract, count, balance))
	})
	->then(((contract, count, balance)) => {
		Js.log2("Wave count:", count->toString)
		Js.log2("Contract balance:", Utils.formatEther(balance))

		contract->wave("hello world")
			->then(txn => txn->wait)
			->then(() => contract->wave("another one"))
			->then(txn => txn->wait)
			->thenResolve(() => contract)
	})
	->then(contract => all2((
		contract->getAllWaves,
		Utils.getBalance(contract.address)
	)))
	->thenResolve(((waves, balance)) => {
		Js.log2("All waves:", waves)
		Js.log2("Contract balance:", Utils.formatEther(balance))
	})
	->ignore
