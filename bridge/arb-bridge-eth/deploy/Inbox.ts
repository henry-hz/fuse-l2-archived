import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { DeployFunction } from 'hardhat-deploy/types';

const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy('Inbox', {
    from: deployer,
    //args: [],
    log: true,
  });
};

export default func;

module.exports = func
func.id = 'deploy inbox';  // id to prevent reexecution
func.tags = ['Inbox', 'patch2'];
