Fuse L2
=======



## Dir structure

* arb: arbitrum stuff
* seq: sequencer [receives RPC calls and batche them to L1]
* val: validator [get messages from sequencer inbox, generate new state and post to rollup]
* util: common code



## ArbOS Flow

1. The basic workflow begins with users sending L2 transactions to a batcher node, usually the sequencer.
2. Once the sequencer receives enough transactions, it will post them into an L1 smart contract as a batch.
3. A validator [there are 3 types of validators, Defensive, StakeLatest, and MakeBlocks] node will read these transactions from the L1 smart contract and process them on their local copy of the L2 state.
4. Once processed, a new L2 state is generated locally and the validator will post this new state root into an L1 smart contract.
5. Then, all other validators will process the same transactions on their local copies of the L2 state.
6. They will compare their resultant L2 state root with the original one posted to the L1 smart contract.
7. If one of the validators gets a different state root than the one posted to L1, they will begin a challenge on L1 (explained in more detail in the ‘Challenges’ section).
8. The challenge will require the challenger and the validator that posted the original state root to take turns proving what the correct state root should be.
9. Whichever user loses the challenge, gets their initial deposit (stake) slashed. If the original L2 state root posted was invalid, it will be destroyed by future validators and will not be included in the L2 chain.





## New Flow

The new flow starts from the premise that small and frequency transactions need low latency and are accpeted to be centralized, under Fuse team management.

1. The basic workflow begins with users sending L2 transactions to the sequencer.
2. Once the sequencer receives enough transactions, it will post them into an L1 smart contract as a batch.
3. A validator [only MakeBlock strategy] node will read these transactions from the L1 smart contract and process them on their local copy of the L2 state.
4. Once processed, a new L2 state is generated locally and the validator will post this new state root into an L1 smart contract and store the hash on the storage.


There are two different L1 smart contracts that batcher nodes will use to post the transaction data. One is known as the ‘delayed inbox’ while the other is known as the ‘sequencer inbox’. Anyone can send transactions to the delayed inbox, whereas only the sequencer can send transactions to the sequencer inbox. The sequencer inbox pulls in transaction data from the delayed inbox and interweaves it with the other L2 transactions submitted by the sequencer. We have to clean this also from the Sequencer Inbox.



## Resources

* [arbitrum-tech-intro](https://medium.com/privacy-scaling-explorations/a-technical-introduction-to-arbitrums-optimistic-rollup-860955ea5fec)
