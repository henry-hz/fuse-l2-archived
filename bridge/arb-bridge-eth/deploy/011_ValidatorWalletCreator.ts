import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { DeployFunction, DeployResult } from "hardhat-deploy/types";

const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
  const { deployments, ethers } = hre;
  const { deploy } = deployments;
  const [deployer] = await ethers.getSigners();

  const res: DeployResult = await deploy("ValidatorWalletCreator", {
    from: await deployer.getAddress(),
    log: true,
    args: [],
  });
};

export default func;
func.tags = ['ValidatorWalletCreator', 'live', 'test'];
func.dependencies = [];
