import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { DeployFunction, DeployResult } from "hardhat-deploy/types";

const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  const res: DeployResult = await deploy("BridgeUtils", {
    from: deployer,
    args: [],
    log: true,
  });
};

export default func;
func.tags = ['BridgeUtils', 'live'];
