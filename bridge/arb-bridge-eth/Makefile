

include .env


deploy:
	export SPARKNET_PRIVKEY=$(KEY) && \
	npx hardhat run scripts/deploy.ts --network sparknet


help:
	npx hardhat help

node:
	npx hardhat node

accounts:
	npx hardhat accounts

compile:
	npx hardhat compile

clean:
	npx hardhat clean

test:
	npx hardhat test

test-gas:
	REPORT_GAS=true npx hardhat test

lint:
	npx eslint '**/*.{js,ts}'
	npx eslint '**/*.{js,ts}' --fix
	npx prettier '**/*.{json,sol,md}' --check
	npx prettier '**/*.{json,sol,md}' --write
	npx solhint 'contracts/**/*.sol'
	npx solhint 'contracts/**/*.sol' --fix
