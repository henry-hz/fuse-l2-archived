package main

import (
	"context"
	"fmt"
	"time"

	"github.com/offchainlabs/arbitrum/packages/arb-util/broadcaster"
	"github.com/offchainlabs/arbitrum/packages/arb-util/configuration"
	"github.com/rs/zerolog"
)

var logger zerolog.Logger

func main() {
	// Enable line numbers in logging

	// Print stack trace when `.Error().Stack().Err(err).` is added to zerolog call
	// zerolog.ErrorStackMarshaler = pkgerrors.MarshalStack
	//
	// zerolog.SetGlobalLevel(zerolog.InfoLevel)
	//
	// // Print line number that log was created on
	// logger = log.With().Caller().Stack().Str("component", "arb-node").Logger()

	startup()
	// if err := startup(); err != nil {
	// 	logger.Error().Err(err).Msg("Error running node")
	// }
}

func startup() {

	ctx := context.Background()
	broadcasterSettings := configuration.FeedOutput{
		Addr:          "0.0.0.0",
		IOTimeout:     2 * time.Second,
		Port:          "9642",
		Ping:          5 * time.Second,
		ClientTimeout: 20 * time.Second,
		Queue:         1,
		Workers:       128,
	}

	b := broadcaster.NewBroadcaster(broadcasterSettings)
	err := b.Start(ctx)

	if err != nil {
		fmt.Print("pau")
		// log.Error().Err(err).Msg("profiling server failed")
		//return errors.Wrap(err, "pau")
	}

	defer b.Stop()

	time.Sleep(5 * time.Minute)
}
