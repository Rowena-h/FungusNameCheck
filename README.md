# FungusNameCheck.R

A tool to check fungus names for the most up to date classification according to [Species Fungorum](http://www.speciesfungorum.org/).

## Requirements

FungusNameCheck.R is an [R](https://www.r-project.org/) script (written in R v4.1.1) designed to run in the linux command line.

To download:

```
git clone https://github.com/Rowena-h/FungusNameCheck.git
```

It requires the [**taxize**](https://github.com/ropensci/taxize) R package to run.

## Usage

The only input needed is a file containing a list of names **without a header**. To see an example, refer to [example/list](example/list).

To run the script in the command line:

```
Rscript FungusNameCheck.R example/list
```

This will produce a csv file with two columns, where the first is the provided name and the second is the current name (see [example/checked_names_PID333527.csv](example/checked_names_PID333527.csv)).

To run the script and additionally produce a log file:

```
Rscript FungusNameCheck.R example/list 2>&1 | tee log
```

If there is an `NA` in the current name column it means that the provided name can't be found anywhere in Species Fungorum, but as the script can't cope with typos, it's probably worth double-checking for that before anything else.
