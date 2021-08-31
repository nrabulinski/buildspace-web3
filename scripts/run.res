open Promise
open Binds

hre.ethers
	->getWaveContractFactory
	->then(factory => factory->deploy)
	->then(contract => 
		contract->deployed
		->then(() => ethers->getSigners)
		->thenResolve(signers => (contract, signers))
	)
	->then(((contract, signers)) => {
		let (owner, other) = signers
		Js.log("Contract deployed to:" ++ contract.address)
		Js.log("Contract deployed by:" ++ owner.address)

		all2((contract->getTotalWaves, contract->connect(other)))
			->thenResolve(((waves, other)) => (contract, waves, other))
	})
	->then(((contract, waves, other)) => {
		Js.log2("Wave count before", waves->toString)

		all2((contract->wave, other->wave))
			->then(((tx1, tx2)) => all2((tx1->wait, tx2->wait)))
			->thenResolve(_ => contract)
	})
	->then(contract => contract->getTotalWaves)
	->thenResolve(waves => Js.log2("Wave count after", waves->toString))
	->ignore
