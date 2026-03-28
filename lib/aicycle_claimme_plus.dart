/// The public API for the AiCycle ClaimMe SDK.
///
/// This file explicitly exports only what the client application is allowed to see and interact with.
/// Everything inside the `src/` folder remains private unless exported here.

library;

// 1. Export the main SDK entry point
export 'src/aicycle_claimme_plus_impl.dart';

// 2. Export Configuration Models
export 'src/config/aicycle_config.dart';
