# garlicoin-dockerfile (dmerrick edition)
Dockerfile for Garlicoin Daemon Linux

### Testing via CLI
    $ docker exec -it garlicoin /bin/bash
    # garlicoin-cli getblockchaininfo
    # garlicoin-cli getaddressesbyaccount ""
    # garlicoin-cli getbalance
    
You should see `getblockchaininfo` return a non-zero `blocks` field. This indicators which block your local wallet is on when syncing (it should eventually match the current head block number).
