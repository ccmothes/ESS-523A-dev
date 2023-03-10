Intro to Environmental Data Science in R
================
Caitlin Mothes
2022-12-20

## Before this Lesson…

Before this lesson you must complete all set up instructions found here:
*\[paste link\]* and watch the instructional video for this week:
*\[paste link to video here\]*.

You should have created a personal account on GitHub, joined the course
organization, and installed R and RStudio on your computer.

## 1. Getting to know RStudio

When you first open RStudio, it is split into 3 panels:

- **The Console** (left), where you can directly type and run code (by
  hitting Enter)
- **The Environment/History pane** (upper-right), where you can view the
  objects you currently have stored in your environment and a history of
  the code you’ve run
- **The Files/Plots/Packages/Help pane** (lower-right), where you can
  search for files, view and save your plots, view and manage what
  packages are loaded in your library and session, and get R help

<figure>
<img
src="https://swcarpentry.github.io/r-novice-gapminder/fig/01-rstudio.png"
style="width:100.0%" alt="Image Credit: Software Carpentry" />
<figcaption aria-hidden="true">Image Credit: Software
Carpentry</figcaption>
</figure>

To write and save code you use scripts. You can open a new script with
File -\> New File or by clicking the icon with the green plus sign in
the upper left corner. When you open a script, RStudio then opens a
fourth **‘Source’ panel** in the upper-left to write and save your code.
You can also send code from a script directly to the console to execute
it by highlighting the code line/chunk (or place your cursor at the end
of the code chunk) and hit CTRL+ENTER on a PC or CMD+ENTER on a Mac.

![Image Credit: Software
Carpentry](https://swcarpentry.github.io/r-novice-gapminder/fig/01-rstudio-script.png)

It is good practice to add comments/notes throughout your scripts to
document what the code is doing. To do this start a line with a `#`. R
knows to ignore everything after a `#`, so you can write whatever you
want there.

## 2. Version Control with Git and GitHub

From this weeks instructional video and online lessons you learned how
to set up a GitHub account, create repositories, and collaborate with
others via forking, branching, pull requests, and posting issues.

For today’s lesson, you are going to work through creating a Git
repository, linking Git and RStudio, and push some R code to the repo.

### 2.1 Create a Git Repo

First step, go to your GitHub account and create a new repository, let’s
call it “GitHub-R-intro”. Remember naming conventions are important. A
common convention is to use dashes between words like we did here. You
could also use underscores (“\_”) or camelCase naming conventions.

Now we are going to clone this repo to our local machines so you can
work in them, write code, and push changes to GitHub.

We are going to use the terminal within RStudio to talk to GitHub.

First Open RStudio, then go to Tools -\> Global Options -\> Terminal and
make sure ‘Git Bash’ is selected for ‘New terminals open with:’.

Next click on the ‘Terminal’ tab next to ‘Console’ and `cd` to the
folder you want to put your repo in. Once there run the following

``` bash
git clone {insert https URL here}
```

Hopefully this runs, and if you navigate in the ‘Files’ pane you should
now see a folder with your repo name. If you have issues, make sure you
have set up your personal HTTPS tokens correctly as instructed
[here](https://happygitwithr.com/https-pat.html).

Now we can set up an R Project that is connected to our Git repor and
start coding!

## 3. R Projects

As a first step whenever you start a new project, workflow, analysis,
etc., it is good practice to set up an R project. R Projects are
RStudio’s way of bundling together all your files for a specific
project, such as data, scripts, results, figures. Your project directory
also becomes your working directory, so everything is self-contained and
easily portable.

Throughout the course you will be cloning repositories on GitHub where
we may already have an R project set up (you can tell by checking if
there is a .Rproj file in the directory/repo with the same name as the
repo), but here we are going to walk through how to set up your own
projects.

You can start an R project in an existing directory or in a new one. To
create a project go to File -\> New Project:

![](project-start.png)

To make sure our R Project is talking to our Git repo, we choose
‘Existing Directory’ and choose your Git repo directory you just cloned
to your local machine. Before creating the project, make sure to check
‘Open in a new session’.

Now we are working in our R project that is connected to our Git repo.
You can see the working directory printed at the top of your console is
now our project directory, and in the ‘Files’ tab in RStudio you can see
we have an .Rproj file, which will open up this R project in RStudio
whenever you come back to it. For example close out of this R session,
navigate to the project folder on your computer, and double-click the
.Rproj file.

We also know it is connected to our repo by the existence of the ‘Git’
tab in the upper right pane. We will be teaching you all how to commit
and push changes to GitHub via the Terminal, but this Git tab acts as a
GUI for pushing changes that you may want to use in the future. I
personally like to keep the Git tab open to have a present view of all
my modified/untracked files I need to be sure to push at the end of the
day.

## 4. Write a set-up script

Let’s start coding!

The first thing you do in a fresh R session is set up your environment,
which mostly includes installing and loading necessary libraries and
reading in required data sets. Let’s open a fresh R script and save it
in our root (project) directory. Call this script ‘setup.R’.

### 4.1 Packages

R Packages include reusable functions that are not built-in with R. To
use these functions, you must install the package to your local system
with the `install.packages()` function. Once a package is installed on
your computer you don’t need to install it again. Anytime you want to
use the package in a new R session you load it with the `library()`
function.

#### 4.2.1 Base R vs. The Tidyverse

You may hear us use the terms ‘Base R’ and ‘Tidyverse’ a lot throughout
this course. Base R includes functions that are installed with the R
software and do not require the installation of additional packages to
use them. The Tidyverse is a collection of R packages designed for data
manipulation, exploration, and visualization that you are likely to use
in every day data analysis, and all use the same design philosophy,
grammar, and data structures. When you install the Tidyverse, it
installs all of these packages, and you can then load all of them in
your R session with `library(tidyverse)`. Base R and Tidyverse have many
similar functions, but many prefer the style, efficiency and
functionality of the Tidyverse packages, and we will mostly be sticking
to Tidyverse functions for this course.

#### 4.2.2 Package load function

To make code reproducible (meaning anyone can run your code from their
local machines) we can write a function that checks whether or not
necessary packages are installed, if not install them and load them, but
if they are it will only load them and not re-install. This function
looks like:

``` r
packageLoad <-
  function(x) {
    for (i in 1:length(x)) {
      if (!x[i] %in% installed.packages()) {
        install.packages(x[i])
      }
      library(x[i], character.only = TRUE)
    }
  }
```

For each package name given (‘x’) it checks if it is already installed,
if not installs it, and then loads that package into the session. Put
this function and the top of your set up script, and then use it to
install the `tidyverse` package.

``` r
packageLoad('tidyverse')
```

You can also give this function a string of package names. Lets install
all the packages we will need for the first week (and beyond). We will
discuss these packages more later on.

``` r
# create a string of package names
packages <- c('tidyverse',
              'palmerpenguins',
              'sf',
              'terra',
              'mapview')

packageLoad(packages)
```

Since this is code you will be re-using throughout your workflows, we
will save it as its own script and run it at the beginning of other
scripts/documents using the `source()` function.

## 5. R Markdown

Throughout this course you will be working mostly in R Markdown
documents. R Markdown is a notebook style interface integrating text and
code, allowing you to create fully reproducible documents and render
them to various elegantly formatted static or dynamic outputs.

You can learn more about R Markdown at their website, which has really
informative lessons on their [Getting
Started](https://rmarkdown.rstudio.com/lesson-1.html) page and see the
range of outputs you can create at their
[Gallery](https://rmarkdown.rstudio.com/gallery.html) page.

### 5.1 What About Quarto?

Some of you may have heard of Quarto, which is essentially an extension
of R Markdown but it lives as its own software to allow its use in other
languages such as Python, Julia and Observable. You can install the
Quarto CLI on its own and RStudio will detect it so you can create
documents within the IDE, or alternatively with newer versions of
RStudio a version of Quarto is built-in and you can enable Quarto
through the R Markdown tab in Global Options. R Markdown isn’t going
anywhere, however many in the data science realm are switching to
Quarto. Quarto documents are very similar to R Markdown, in fact Quarto
can even render R Markdown documents, so after learning R Markdown in
this course you should have some of the fundamental skills to easily
switch to Quarto if you want to. You can read more about Quarto
[here](https://quarto.org/).

### 5.2 Getting started with R Markdown

Let’s create a new document by going to File -\> New File -\> R
Markdown. You will be prompted to add information like title and author,
fill those in (let’s call it “Intro to R Markdown”) and keep the output
as HTML for now. Click OK to create the document.

This creates an outline of an R Markdown document, and you see the
title, author and date you gave the prompt at the top of the document
which is called the YAML header.

Notice that the file contains three types of content:

- An (optional) YAML header surrounded by `---`s

- R code chunks surrounded by ```` ``` ````s

- text mixed with simple text formatting

Since this is a notebook style document, you run the code chunks by
clicking the green play button, and then the output is returned directly
below the chunk.

When you want to create a report from your notebook, you render it by
hitting the ‘knit’ button, and it will render to the format you have
specified in the YAML header. In order to do so though, you need to have
the `rmarkdown` package installed, so go back to your ‘setup.R’ script,
add `rmarkdown` to your packages variable and save it.

#### OK FINALLY we can start coding

You can delete the rest of the code/text below the YAML header, and
insert a new code chunk at the top. You can insert code chunks by
clicking the green C with the ‘+’ sign at the top of the source editor,
or with the keyboard short cut (Ctrl+Alt+I for Windows, Option+Command+I
for Macs). For the rest of the lesson (and course) you will be writing
and executing code through code chunks, and you can type any notes in
the main body of the document (*refer to the lecture video about using
the Source vs. Visual editor*).

The first chunk is almost always your set up code, where you read in
libraries and any necessary data sets. Here we will execute our set up
script to install and load all the libraries we need:

``` r
source("setup.R")
```

## 6. Explore

Normally when working with a new data set, the first thing we do is
explore the data to better understand what we’re working with. To do so,
you also need to understand the fundamental data types and structures
you can work with in R.

### 6.1 The `penguins` data

For this intro lesson, we are going to use the Palmer Penguins data set
(which is loaded with the `palmerpenguins` package you installed in your
set up script). This data was collected and made available by
[Dr. Kristen
Gorman](https://www.uaf.edu/cfos/people/faculty/detail/kristen-gorman.php)
and the [Palmer Station, Antarctica
LTER](https://pallter.marine.rutgers.edu/), a member of the [Long Term
Ecological Research Network](https://lternet.edu/).

Load the `penguins` data set.

``` r
data("penguins")
```

You now see it in the Environment pane. Print it to the console to see a
snapshot of the data:

``` r
penguins
```

This data is structured is a data frame, probably the most common data
type and one you are most familiar with. These are like Excel spread
sheets, tabular data organized by rows and columns. However we see at
the top this is called a `tibble` which is just a fancy kind of data
frame specific to the `tidyvese`.

At the top we can see the data type of each column. There are five main
data types:

- **character**: `"a"`, `"swc"`

- **numeric**: `2`, `15.5`

- **integer**: `2L` (the `L` tells R to store this as an integer)

- **logical**: `TRUE`, `FALSE`

- **complex**: `1+4i` (complex numbers with real and imaginary parts)

Data types are combined to form data structures. R’s basic data
structures include

- atomic vector

- list

- matrix

- data frame

- factors

You can see the data type or structure of an object using the `class()`
function, and get more specific details using the `str()` function.
(Note that ‘tbl’ stands for tibble).

``` r
class(penguins)
str(penguins)
```

``` r
class(penguins$species)
str(penguins$species)
```

When we pull one column from a data frame like we just did above, that
returns a vector. Vectors are 1-dimensional, and must contain data of a
single data type (i.e., you cannot have a vector of both numbers and
characters).

If you want a 1-dimensional object that holds mixed data types and
structures, that would be a list. You can put together pretty much
anything in a list.

``` r
myList <- list("apple", 1993, FALSE, penguins)
str(myList)
```

You can even nest lists within lists

``` r
list(myList, list("more stuff here", list("and more")))
```

You can use the `names()` function to retrieve or assign names to list
and vector elements

``` r
names(myList) <- c("fruit", "year", "logic", "data")
names(myList)
```

### 6.2 Indexing

Indexing is an extremely important aspect to data exploration and
manipulation. In fact you already started indexing when we looked at the
data type of individual columns with `penguins$species`. How you index
is dependent on the data structure.

Index lists:

``` r
# for lists we use double brackes [[]]
myList[[1]]

myList[["data"]]
```

Index vectors:

``` r
# for vectors we use single brackets []
myVector <- c("apple", "banana", "pear")
myVector[2]
```

Index data frames:

``` r
# dataframe[row(s), columns()]
penguins[1:5, 2]

penguins[1:5, "island"]

penguins[1, 1:5]

penguins[1:5, c("species","sex")]

penguins[penguins$sex=='female',]

# $ for a single column
penguins$species
```

#### 6.2.1 Exercises

1.  Why don’t the following lines of code work? Tweak each one so the
    code runs

    ``` r
    myList["Fruit"]
    ```

    ``` r
    penguins$flipper_lenght_mm
    ```

    ``` r
    penguins[island=='Dream',]
    ```

2.  How many species are in the `penguins` dataset? What islands were
    the data collected for? (Note: the `unique()` function might help)

3.  Create a new data frame that has columns for species, island and
    flipper length, but just for the Dream island.

4.  What is the average flipper length for the Adelie species on Dream
    island? (Note: explore the `mean()` function and how to deal with NA
    values).

### 6.3 The `dplyr` package

So far the code you’ve been writing has consisted of Base R
functionality. Now lets dive into the Tidyverse with the `dplyr`
package.

`dplyr` is a Tidyverse package to handle most of your data exploration
and manipulation tasks.

Sort data with
<a href="https://dplyr.tidyverse.org/reference/arrange.html"
style="font-size: 13pt;"><code>arrange()</code></a>

``` r
arrange(penguins, sex)

#Sort first by species (in descending order) then by sex
arrange(penguins, desc(species), sex)
```

**Note: Tidyverse package functions take in column names
*without*quotations.**

Subset rows with `filter()`

You can filter data in many ways using comparison operators (`>`, `>=`,
`<`, `<=`, `!=` (not equal), and `==` (equal)), logical operators (`&`
is "and", `|` is "or", and `!` is "not") and other operations such as
`%in%`, which returns everything that matches at least on of the values
in a given vector, and `is.na()` and `!is.na()` to return all missing or
all non-missing data.

``` r
filter(penguins, species == "Adelie")

filter(penguins, species != "Adelie")

filter(penguins, island %in% c("Dream", "Torgersen") & !is.na(bill_length_mm))
```

Using `dplyr` functions will not manipulate the original data, so if you
want to save the returned object you need to assign it to a new
variable.

Select variables by their column names with
<a href="https://dplyr.tidyverse.org/reference/select.html"
style="font-size: 13pt;"><code>select()</code></a>

`select()` has many helper functions you can use with it, such as
`starts_with()`, `ends_with()`, `contains()` and many more that are very
useful when dealing with large data sets. See `?select` for more details

``` r
# Select two specific variables
select(penguins, species, sex)

# Select a range of variables
select(penguins, species:flipper_length_mm)

# Rename columns within select
select(penguins, genus = species, island)

# Select column variables that are recorded in mm
select(penguins, contains("mm"))
```

Create new variables with
<a href="https://dplyr.tidyverse.org/reference/mutate.html"
style="font-size: 13pt;"><code>mutate()</code></a>

``` r
# New variable that calculates bill length in cm
mutate(penguins, bill_length_cm = bill_length_mm/10)

# mutate based on conditional statements
mutate(penguins, species_sex = if_else(sex == 'male', paste0(species,"_m"), paste0(species, "_f")))
```

These can all be used in conjunction with
[`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html)
which changes the scope of each function from operating on the entire
dataset to operating on it group-by-group. `group_by()` becomes even
more powerful when used along with `summarise()`. However before we
start using multiple operations in conjunction with one another, we need
to talk about the pipe operator `%>%`.

#### 6.3.1 The pipe `%>%`

The pipe, `%>%`, comes from the **magrittr** package by Stefan Milton
Bache. Packages in the tidyverse load `%>%` for you automatically, so
you don't usually load magrittr explicitly. Pipes are a powerful tool
for clearly expressing a sequence of multiple operations.

For example, the pipe operator can take this sequence of operations:

``` r
df1 <- filter(penguins, island == "Dream")
df2 <- mutate(df1, flipper_length_cm = flipper_length_mm/10)
df3 <- select(df2, species, year, flipper_length_cm)

print(df3)
```

And turn it into this, removing the need to create intermediate
variables

``` r
penguins %>% 
  filter(island == "Dream") %>% 
  mutate(flipper_length_cm = flipper_length_mm/10) %>% 
  select(species, year, flipper_length_cm)
```

You can read it as a series of imperative statements: filter, then
mutate, then select. A good way to pronounce `%>%` when reading code is
"then". It takes the output of the operation to the left of `%>%` and
feeds it into the next function as the input.

Say you want to summarize data by some specified group, for example you
want to find the average body mass for each species, this is where the
`group_by()` function comes into play.

``` r
penguins %>% 
  group_by(species) %>% 
  summarise(body_mass_avg = mean(body_mass_g, na.rm = TRUE))
```

Or get a count of how many individuals were observed for each species
each year

``` r
penguins %>% 
  group_by(species, year) %>% 
  summarise(n_observations = n())
```

6.3.2 Exercises

1.  Reorder the variables in `penguins` so that `year` is the first
    column followed by the rest (Hint: look into the use of
    `everything()`).

2.  Create a new column called ‘size_group’ where individuals with body
    mass greater than the overall average are called ‘large’ and those
    smaller are called ‘small’.

3.  Find out which year for each species were individuals on average the
    largest according to body mass.

4.  You want to filter data for years that are *not* in a vector of
    given years, but this code doesn’t work. Tweak it so that it does.
    (Yes, you could just filter year to equal 2007 in this case but
    there is a trouble-shooting lessons here).

    ``` r
    penguins %>% 
      filter(year !%in% c(2008, 2009))
    ```

## 7. Visualize

A huge part of data exploration includes data visualization to get quick
snapshots of your data and reveal patterns you can’t see from starting a
a data frame of numbers. Here we are going to walk through a very quick
introduction to `ggplot2`, using some code examples from the
`palmerpenguins` R package tutorial:
<https://allisonhorst.github.io/palmerpenguins/articles/intro.html>.

`ggplot2` is perhaps the most popular data visualization package in the
R language, and is also a part of the Tidyverse. One big difference
about `ggplot` though is that it does not use the pipe `%>%` operator
like we just learned, but instead threads together arguments with `+`
signs.

The general structure for ggplots follows the template below. However
note that you can also specify the `aes()` parameters withing `ggplot()`
instead of your geom function, which you may see a lot of people do. The
mappings include arguments such as the x and y variables from your data
you want to use for the plot. The geom function is the type of plot you
want to make, such as `geom_point()`, `geom_bar()`, etc, there are a lot
to choose from.

``` r
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))
```

If you plan on doing any statistical analysis on your data , one of the
first things you are likely to do is explore the distirbution of your
variables. You can plot histograms with `geom_histogram()`

``` r
ggplot(penguins) + 
  geom_histogram(mapping = aes(x = flipper_length_mm))
```

![](intro-basics_files/figure-gfm/unnamed-chunk-28-1.png)<!-- -->

This isn’t too informative, we want to see the distributions for each
species. We can do that by coloring the bars by species

``` r
# Histogram example: flipper length by species
ggplot(penguins) +
  geom_histogram(aes(x = flipper_length_mm, fill = species), alpha = 0.5, position = "identity") +
  scale_fill_manual(values = c("darkorange","darkorchid","cyan4"))
```

![](intro-basics_files/figure-gfm/unnamed-chunk-29-1.png)<!-- -->

Or we can use `facet_wrap()` to create a separate plot for each species

``` r
ggplot(penguins) +
  geom_histogram(aes(x = flipper_length_mm, fill = species), alpha = 0.5, position = "identity") +
  scale_fill_manual(values = c("darkorange","darkorchid","cyan4")) +
  facet_wrap(~species)
```

![](intro-basics_files/figure-gfm/unnamed-chunk-30-1.png)<!-- -->

Lets make a quick bar plot showing the total count of each species
studied on each island

``` r
ggplot(penguins) +
  geom_bar(mapping = aes(x = island, fill = species))
```

![](intro-basics_files/figure-gfm/unnamed-chunk-31-1.png)<!-- -->

As you may have already noticed, the beauty about `ggplot2` is there are
a million ways you can customize your plots. This example builds on our
simple bar plot

``` r
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(alpha = 0.8) +
  scale_fill_manual(values = c("darkorange","purple","cyan4"), 
                    guide = FALSE) +
  theme_minimal() +
  facet_wrap(~species, ncol = 1) +
  coord_flip()
```

![](intro-basics_files/figure-gfm/unnamed-chunk-32-1.png)<!-- -->

Now make a scatterplot showing the relationship between body mass and
flipper length, coloring the point by species

``` r
ggplot(penguins) +
  geom_point(mapping = aes(x = body_mass_g, y = flipper_length_mm, color = species))
```

![](intro-basics_files/figure-gfm/unnamed-chunk-33-1.png)<!-- -->

### 7.1 Exercises

1.  Make a barplot showing the average flipper length for each species.

2.  Make a scatter plot of bill length compared to bill depth but only
    for observations on the Dream island.
