# The GAP package GRPS1024

###Description:
--------------------

This package provides:

 - Access to the groups of order 1024 and $p$-class 3 and greater

For further information see:
   - [Documentation](https://davidburrell.github.io/GRPS1024/doc/chap0.html)
   - [PackageSite](https://davidburrell.github.io/GRPS1024/)

###Installation
--------------------

1. Clone the repo or download a version via releases and unpack to the "pkg" subdirectory of your GAP installation (i.e. ../gap/pkg)
2. Setup the lib directory:
	1. Download descendants-lib.tar.gz from <https://www.dropbox.com/s/sphgl7zk123efdi/descendants-lib-1024.tar.gz?dl=0>	
	2. Unpack archive into package forlder via:
	 `tar -xvf descendants-lib.tar.gz -C ~/gap/pkg/GRPS1024` 
	 (change to match your gap installation if necessary)
	3. The package directory should now resemble the following
```bash
../gap/pkg/GRPS1024

├── doc
├── gap
├── lib
│   ├── Desc_2
│   ├── Desc_4
│   ├── Desc_8
│   ├── Desc_16
│   ├── Desc_32
│   ├── Desc_64
│   ├── Desc_128
│   ├── Desc_256
│   ├── Desc_512
│   ├── Enum_2
│   ├── Enum_4
│   └── Enum_8
│   ├── Enum_16
│   ├── Enum_32
│   ├── Enum_64
│   ├── Enum_128
│   ├── Enum_256
│   ├── Enum_512
└── tst
```
## Contact
For questions, comments and or issues contact <Davidburrell@ufl.edu>


## License
The GRPS1024 is free software distributed under the [Artistic License 2.0](https://opensource.org/licenses/Artistic-2.0).

For details see the files `LICENSE` and `COPYRIGHT.md`.


