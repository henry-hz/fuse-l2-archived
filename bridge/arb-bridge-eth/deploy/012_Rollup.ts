import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { DeployFunction } from 'hardhat-deploy/types';

const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy('Rollup', {
    from: deployer,
    args: [1],
    log: true,
  });

  await deploy('RollupUserFacet', {
    from: deployer,
    args: [],
    log: true,
  });

  await deploy('RollupAdminFacet', {
    from: deployer,
    args: [],
    log: true,
  });
};

export default func;
func.tags = ['Rollup', 'live', 'test']
