open Promise
open Binds

hre.ethers
	->getWaveContractFactory
	->then(factory => factory->deploy)
	->then(contract => {
		Js.log2("Contract address:", contract.address)
		contract->getTotalWaves->thenResolve(count => (contract, count))
	})
	->then(((contract, count)) => {
		Js.log(count->toString)
		contract->wave("hello world")
			->then(txn => txn->wait)
			->then(() => contract->wave("another one"))
			->then(txn => txn->wait)
			->then(() => contract->getAllWaves)
	})
	->thenResolve(waves => Js.log2("All waves:", waves))
	->ignore
