% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tcm.R
\name{create_tcm}
\alias{create_tcm}
\alias{create_tcm.itoken}
\alias{create_tcm.list}
\title{Term-co-occurence matrix construction}
\usage{
create_tcm(it, vectorizer, ...)

\method{create_tcm}{itoken}(it, vectorizer, ...)

\method{create_tcm}{list}(it, vectorizer, verbose = FALSE,
  work_dir = tempdir(), ...)
}
\arguments{
\item{it}{\code{list} of iterators over tokens from \link{itoken}.
Each element is a list of tokens, that is, tokenized and normalized
strings.}

\item{vectorizer}{\code{function} vectorizer function. See
\link{vectorizers}.}

\item{...}{arguments to \link{foreach} function which is used to iterate over
\code{it}.}

\item{verbose}{\code{logical} print status messages}

\item{work_dir}{working directory for intermediate results}
}
\value{
\code{dgTMatrix} TCM matrix
}
\description{
This is a function for constructing a
term-co-occurrence matrix(TCM). TCM matrix usually used with \link{GloVe} word embedding model.
}
\details{
If a parallel backend is registered, it will onstruct the TCM in multiple threads.
The user should keep in mind that he/she should split data and provide a list
of \link{itoken} iterators. Each element of \code{it} will be handled
in a separate thread combined at the end of processing.
}
\examples{
\dontrun{
data("movie_review")

# single thread

tokens = movie_review$review \%>\% tolower \%>\% word_tokenizer
it = itoken(tokens)
v = create_vocabulary(jobs)
vectorizer = vocab_vectorizer(v, grow_dtm = FALSE, skip_grams_window = 3L)
tcm = create_tcm(itoken(tokens), vectorizer)

# parallel version

# set to number of cores on your machine
N_WORKERS = 1
splits = split_into(movie_review$review, N_WORKERS)
jobs = lapply(splits, itoken, tolower, word_tokenizer)
v = create_vocabulary(jobs)
vectorizer = vocab_vectorizer(v, grow_dtm = FALSE, skip_grams_window = 3L)
jobs = lapply(splits, itoken, tolower, word_tokenizer)
doParallel::registerDoParallel(N_WORKERS)
tcm = create_tcm(jobs, vectorizer)
}
}
\seealso{
\link{itoken} \link{create_dtm}
}
