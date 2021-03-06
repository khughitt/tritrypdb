\name{parse_gene_info_table}
\alias{parse_gene_info_table}
\title{TriTrypDB gene information table parser}
\usage{
  parse_gene_info_table(filepath, verbose = FALSE)
}
\arguments{
  \item{filepath}{Location of TriTrypDB gene information
  table.}

  \item{verbose}{Whether or not to enable verbose output.}
}
\value{
  Returns a dataframe of gene info.

  An example input file is the T. brucei Lister427 gene
  information table available at:
  http://tritrypdb.org/common/downloads/Current_Release/TbruceiLister427/txt/data/TriTrypDB-5.0_TbruceiLister427Gene.txt
}
\description{
  TriTrypDB gene information table parser
}
\author{
  Keith Hughitt
}

