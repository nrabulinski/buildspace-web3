open Binds
open Promise

ethers
	->getSigners
	->then(((owner, _)) => owner->getBalance->thenResolve(balance => (owner, balance)))
	->then(((owner, balance)) => {
		Js.log2("Deploying contracts with account:", owner.address)
		Js.log2("Account balance:", balance->toString)

		ethers->getWaveContractFactory
			->then(factory => factory->deploy)
	})
	->thenResolve(contract => Js.log2("WavePortal address:", contract.address))
	->ignore
