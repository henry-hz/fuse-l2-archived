import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { DeployFunction, DeployResult } from "hardhat-deploy/types";

const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  const osp1 = await deployments.get('OneStepProof');
  const osp2 = await deployments.get('OneStepProof2');
  const osp3 = await deployments.get('OneStepProofHash');

  const proxyAdmin = await deploy('ProxyAdmin', {
    from: deployer,
    args: [],
    log: true,
  });

  const osp1Proxy = await deploy('TransparentUpgradeableProxy', {
    from: deployer,
    args: [osp1.address, proxyAdmin.address, '0x'],
    log: true,
  });

  const osp2Proxy = await deploy('TransparentUpgradeableProxy', {
    from: deployer,
    args: [osp2.address, proxyAdmin.address, '0x'],
    log: true,
  });

  const osp3Proxy = await deploy('TransparentUpgradeableProxy', {
    from: deployer,
    args: [osp3.address, proxyAdmin.address, '0x'],
    log: true,
  });

  await deploy('ChallengeFactory', {
    from: deployer,
    args: [[osp1Proxy.address, osp2Proxy.address, osp3Proxy.address]],
    log: true,
  });
};

export default func;
func.tags = ['ChallengeFactory', 'live', 'test'];
func.dependencies = [
  'OneStepProof',
  'OneStepProof2',
  'OneStepProofHash',
];
