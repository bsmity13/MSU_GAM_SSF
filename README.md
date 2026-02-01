# GAM & SSF Workshop

[Brian J. Smith](https://github.com/bsmity13)

Montana State University

February 11 & 13, 2026

This workshop covers general applications of **generalized additive models** 
(GAMs) in ecology, an introduction to **step-selection functions** (SSFs) for 
modeling animal movement, and then concludes by fitting SSFs using the 
flexibility of GAMs.

## Recommended Resources

- [Wood (2017)](https://doi.org/10.1201/9781315370279) for understanding GAMs
- [Fieberg et al. (2021)](https://doi.org/10.1111/1365-2656.13441) for understanding SSFs
  - Note, [Appendix B](https://conservancy.umn.edu/bitstream/handle/11299/218272/AppB_SSF_examples.html?sequence=26&isAllowed=y) hosted online by University of Minnesota Libraries


## Agenda

### Wednesday, Feb 11
9:00 am - 3:00 pm
- Introductions and workshop overview
- Overview of regression modeling (*lecture*)
- Simulating data to understand regression models (*R walkthrough*)
- Lunch (~11:30 - 12:30)
- GAM theory (*lecture*)
- Fitting GAMs to ecological data in R (*R walkthrough*)

### Thursday, Feb 12
On campus all day
- Department seminar (3:30 - 4:30)

### Friday, Feb 13
8:00 am - 2:00 pm
- Introductions and review of Wednesday
- RSFs and SSFs (*lecture*)
- Fitting SSFs in R (*R walkthrough*)
- Lunch (~11:00 - 12:00)
- SSFs with GAMs (*lecture*)
- SSFs with GAMs in R (*code walkthrough*)

## Repository Structure

### Slides 

Slides in this repository were created with [Quarto](https://quarto.org/) using 
[`revealjs`](https://quarto.org/docs/presentations/revealjs/). The slideshows 
are written in a `*.qmd` file, then rendered to HTML for presentation. The 
`*.qmd` files are located in the root directory, while the HTML files are 
rendered inside the `docs/` folder.

### Code

The code walkthroughs are plain R scripts, located in the root directory.

### Numbering

The lecture and code walkthrough files are numbered in the order we will cover 
them in the workshop. Day 1 covers `01_*` through `04_*`, Day 2 covers `05_*` 
through `08_*`.