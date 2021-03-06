\name{parse_gene_go_terms}
\alias{parse_gene_go_terms}
\title{TriTrypDB gene information table GO term parser}
\usage{
  parse_gene_go_terms(filepath, verbose = FALSE)
}
\arguments{
  \item{filepath}{Location of TriTrypDB gene information
  table.}

  \item{verbose}{Whether or not to enable verbose output.}
}
\value{
  Returns a dataframe where each line includes a gene/GO
  terms pair along with some addition information about the
  GO term. Note that because each gene may have multiple GO
  terms, a single gene ID may appear on multiple lines.
}
\description{
  TriTrypDB gene information table GO term parser
}
\author{
  Keith Hughitt
}

