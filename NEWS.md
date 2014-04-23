# NEWS

## juggler 0.1.0

- added `jg_rm comments(x)`: removes comments and now called
by all exported functions so working on non-commented code
which means that using `jg_block_names(x)<-` to set
block names removes comments.


## juggler 0.0.1

- created `jg_block_names(x)`: block names
- created `jg_block_names(x)<-`: set block names
- created `jg_blocks(x)`: blocks
- created `jg_check(x)`: basic checking of JAGS model code       
- created `jg_dists(x)`: distribution names 
- created `jg_funcs(x)`: function names
- created `jg_nblock(x)`: number of blocks
- created `jg_vnodes(x)`: variable node names
