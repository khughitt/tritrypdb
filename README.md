tritrypdb
=========
Overview
--------
A few small R functions for working with [TriTrypDB](http://tritrypdb.org/tritrypdb/)
data files. An alternate version written for the Python programming language is 
available at
[github.com/khughitt/tritrypdb-python](https://www.github.com/khughitt/tritrypdb-python).

Installation
------------
To install the latest version of tritrypdb using [devtools](https://github.com/hadley/devtools), 
run:
```r
require(devtools)
install_github("tritrypdb", user="khughitt")
```

Usage
-----
```r
require(tritrypdb)
df = parse_gene_info_table('TriTrypDB-5.0_TbruceiLister427Gene.txt')
```

