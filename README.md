# FungusNameCheck.R

A tool to check fungus names for the most up to date classification according to [Species Fungorum](http://www.speciesfungorum.org/).

## Requirements

FungusNameCheck.R is an [R](https://www.r-project.org/) script (written in R v4.1.1) designed to run in the linux command line.

It requires the [**taxize**](https://github.com/ropensci/taxize) R package.

To download:

```
git clone https://github.com/Rowena-h/FungusNameCheck.git
```

## Usage

The only input needed is a file containing a list of names to check **without a header**. To see an example, refer to [example/list](example/list).

To run the script:

```
Rscript FungusNameCheck.R example/list
```

To run the script and additionally produce a log file:

```
Rscript FungusNameCheck.R example/list 2>&1 | tee log
```
