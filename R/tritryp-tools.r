#'
#' TriTrypDB gene information table parser
#'
#' @author [Keith Hughitt](khughitt@umd.edu)
#'
#' @param filepath Location of TriTrypDB gene information table.
#' @return Returns a dataframe of gene info.
#'
#' An example input file is the T. brucei Lister427 gene information table
#' available at:
#' http://tritrypdb.org/common/downloads/Current_Release/TbruceiLister427/txt/data/TriTrypDB-5.0_TbruceiLister427Gene.txt
#'
parse_gene_info_table = function(filepath, verbose=FALSE) {
    fp = file(filepath, open='r')

    # Create empty vector to store dataframe rows
    N = 2e4
    genes = data.frame(gene_id=rep("", N), chromosome=rep(NA, N),
                       start=rep(NA, N), stop=rep(NA, N),
                       strand=rep("", N), type=rep("", N),
                       transcript_length=rep(NA, N),
                       cds_length=rep(NA, N), pseudogene=rep(NA, N),
                       description=rep("", N), stringsAsFactors=FALSE)

    # Regular expression to extract location info
    location_regex = '([0-9,]*) - ([0-9,]*) \\(([-+])\\)'

    # Counter to keep track of row number
    i = 1

    # Iterate through lines in file
    while (length(x <- readLines(fp, n=1, warn=FALSE)) > 0) {
        # Gene ID
        if(grepl("^Gene ID", x)) {
            gene_id = .get_value(x)
            if (verbose) {
                print(sprintf('Processing gene %d: %s', i, gene_id))
            }
        }

        # Chromosome number
        else if(grepl("^Chromosome", x)) {
            if (grepl("^Chromosome: Not Assigned", x)) {
                chromosome = NA
            } else {
                chromosome = as.numeric(.get_value(x))
            }
        }

        # Genomic location
        else if (grepl("^Genomic Location", x)) {
            result = unlist(regmatches(x, regexec(location_regex, x)))
            gene_start = as.numeric(gsub(",", "", result[2], fixed=TRUE))
            gene_stop  = as.numeric(gsub(",", "", result[3], fixed=TRUE))
            strand = result[4]
        }

        # Gene type
        else if (grepl("^Gene Type", x)) {
            gene_type = .get_value(x)
        }

        # Product Description
        else if (grepl("^Product Description", x)) {
            description = .get_value(x)
        }

        # Transcript length
        else if (grepl("^Transcript Length", x)) {
            transcript_length = as.numeric(.get_value(x))
        }

        # CDS length
        else if (grepl("^CDS Length", x)) {
            val = .get_value(x)
            if (val == 'null') {
                cds_length = NA
            } else {
                cds_length = as.numeric(val)
            }
        }
        # Pseudogene
        else if (grepl("^Is Pseudo:", x)) {
            is_pseudo = if(.get_value(x) == "Yes") TRUE else FALSE
        }

        # End of gene description
        else if (grepl("^---", x)) {
            # Skip gene if it is not assigned to a chromosome
            if (is.na(chromosome)) {
                next
            }

            # Otherwise add row to dataframe
            genes[i,] = c(gene_id, chromosome, gene_start, gene_stop, strand,
                          gene_type, transcript_length, cds_length, is_pseudo,
                          description)
            i = i + 1
        }
    }

    # close file pointer
    close(fp)

    # get ride of unallocated rows
    genes = genes[1:i-1,]

    # use gene id as row name
    rownames(genes) = genes$gene_id

    # sort data frame
    genes = genes[with(genes, order(chromosome, start)),]

    return(genes)
}

#'
#' TriTrypDB gene information table GO term parser
#'
#' @author [Keith Hughitt](khughitt@umd.edu)
#'
#' @param filepath Location of TriTrypDB gene information table.
#' @return Returns a dataframe where each line includes a gene/GO terms pair
#'         along with some addition information about the GO term. Note that
#'         because each gene may have multiple GO terms, a single gene ID may
#'         appear on multiple lines.
#'
parse_gene_go_terms = function () {
}

#
# Parses a key: value string and returns the value
#
.get_value = function(x) {
    return(gsub(" ","", tail(unlist(strsplit(x, ': ')), n=1), fixed=TRUE))
}
