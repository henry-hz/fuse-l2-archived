
got stuck trying to start the sequencer when the RollupCreator stuck:

RollupCreator: 0xEEf843d2A86EE6D746f4b79f8A8eECF5459e7FB7



{"level":"warn","component":"transactauth","stack":[{"func":"waitForReceiptWithResultsSimpleInternal","line":"120","source":"chain.go"},{"func":"WaitForReceiptWithResultsAndReplaceByFee","line":"224","source":"chain.go"},{"func":"WaitForReceiptWithResults","line":"250","source":"chain.go"},{"func":"startup","line":"214","source":"arb-dev-sequencer.go"},{"func":"main","line":"79","source":"arb-dev-sequencer.go"},{"func":"main","line":"225","source":"proc.go"},{"func":"goexit","line":"1371","source":"asm_amd64.s"}],"error":"receipt not found","tx":"f451631f5944020a0bfa5717feb4bd8920f401e831be0fd98ebbf23e32073a79","time":"2022-02-27T11:48:48+02:00","caller":"/home/henry/fuse-arb/validator/arb-util/transactauth/chain.go:226","message":"error while waiting for transaction receipt"}
{"component":"arb-node","time":"2022-02-27T11:48:48+02:00","caller":"/home/henry/fuse-arb/validator/arb-rpc-node/cmd/arb-dev-sequencer/arb-dev-sequencer.go:216","message":"Cleanly shutting down node"}
{"level":"error","component":"arb-node","stack":[{"func":"startup","line":"216","source":"arb-dev-sequencer.go"},{"func":"main","line":"79","source":"arb-dev-sequencer.go"},{"func":"main","line":"225","source":"proc.go"},{"func":"goexit","line":"1371","source":"asm_amd64.s"}],"error":"error getting transaction receipt: receipt not found","time":"2022-02-27T11:48:48+02:00","caller":"/home/henry/fuse-arb/validator/arb-rpc-node/cmd/arb-dev-sequencer/arb-dev-sequencer.go:80","message":"Error running node"}



Now, fixed the RollupCreator,




{"level":"info","component":"arb-node","chainaddress":"1d0decff9c3a5f6d3c5635411441b7502a14ab55","chainid":"68799","time":"2022-02-27T12:03:20+02:00","caller":"/home/henry/fuse-arb/validator/arb-rpc-node/cmd/arb-dev-sequencer/arb-dev-sequencer.go:232","message":"Launching arbitrum node"}
{"level":"info","component":"monitor","directory":"arbitrum102695120","time":"2022-02-27T12:03:21+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/monitor/monitor.go:57","message":"database opened"}
Reloading chain to the last message saved
Initial machine load
{"level":"info","component":"monitor","time":"2022-02-27T12:03:21+02:00","caller":"/home/henry/fuse-arb/validator/arb-node-core/monitor/monitor.go:64","message":"storage initialized"}
{"level":"warn","component":"arb-node","stack":[{"func":"(*Monitor).StartInboxReader","line":"102","source":"monitor.go"},{"func":"startup","line":"254","source":"arb-dev-sequencer.go"},{"func":"main","line":"79","source":"arb-dev-sequencer.go"},{"func":"main","line":"225","source":"proc.go"},{"func":"goexit","line":"1371","source":"asm_amd64.s"}],"error":"error checking initial chain state: rollup not created","url":"https://rpc.fusespark.io","rollup":"0x1d0decff9c3a5f6d3c5635411441b7502a14ab55","bridgeUtils":"0xc6ec791f3f9a83a88b01a8793ed3055ac3016da6","time":"2022-02-27T12:03:21+02:00","caller":"/home/henry/fuse-arb/validator/arb-rpc-node/cmd/arb-dev-sequencer/arb-dev-sequencer.go:271","message":"failed to start inbox reader, waiting and retrying"}
{"level":"warn","component":"arb-node","stack":[{"func":"(*Monitor).StartInboxReader","line":"102","source":"monitor.go"},{"func":"startup","line":"254","source":"arb-dev-sequencer.go"},{"func":"main","line":"79","source":"arb-dev-sequencer.go"},{"func":"main","line":"225","source":"proc.go"},{"func":"goexit","line":"1371","source":"asm_amd64.s"}],"error":"error checking initial chain state: rollup not created","url":"https://rpc.fusespark.io","rollup":"0x1d0decff9c3a5f6d3c5635411441b7502a14ab55","bridgeUtils":"0xc6ec791f3f9a83a88b01a8793ed3055ac3016da6","time":"2022-02-27T12:03:26+02:00","caller":"/home/henry/fuse-arb/validator/arb-rpc-node/cmd/arb-dev-sequencer/arb-dev-sequencer.go:271","message":"failed to start inbox reader, waiting and retrying"}
^C{"level":"warn","component":"arb-node","stack":[{"func":"(*Monitor).StartInboxReader","line":"102","source":"monitor.go"},{"func":"startup","line":"254","source":"arb-dev-sequencer.go"},{"func":"main","line":"79","source":"arb-dev-sequencer.go"},{"func":"main","line":"225","source":"proc.go"},{"func":"goexit","line":"1371","source":"asm_amd64.s"}],"error":"error checking initial chain state: Post \"https://rpc.fusespark.io\": context canceled","url":"https://rpc.fusespark.io","rollup":"0x1d0decff9c3a5f6d3c5635411441b7502a14ab55","bridgeUtils":"0xc6ec791f3f9a83a88b01a8793ed3055ac3016da6","time":"2022-02-27T12:03:31+02:00","caller":"/home/henry/fuse-arb/validator/arb-rpc-node/cmd/arb-dev-sequencer/arb-dev-sequencer.go:271","message":"failed to start inbox reader, waiting and retrying"}

