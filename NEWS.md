# NEWS juggler

#### v0.1.6

- update NAMESPACE

#### v0.1.5

- added `comment = "[$][^\n]+[$]"` argument to `jg_nodes` to pull latex expression comments

#### v0.1.4

- added `in` as function to deal with case where `for(i in (0+1):2)`

#### v0.1.3

- fixed bug internal function `jags_functions` not returning all combinations of
`p, d, q` and distributions

#### v0.1.2

- moved `reverse_strings` and `paste_names` to `tulip` package which is now imported

#### v0.1.1

- fixed bug in `jg_check` where giving warning error if just model block

### v0.1.0

- added `jg_rm comments(x)`: removes comments and now called
by all exported functions so working on non-commented code
which means that using `jg_block_names(x)<-` to set
block names removes comments.

## v0.0.1

Initial Release

- created `jg_block_names(x)`: block names
- created `jg_block_names(x)<-`: set block names
- created `jg_blocks(x)`: blocks
- created `jg_check(x)`: basic checking of JAGS model code       
- created `jg_dists(x)`: distribution names 
- created `jg_funcs(x)`: function names
- created `jg_nblock(x)`: number of blocks
- created `jg_vnodes(x)`: variable node names
