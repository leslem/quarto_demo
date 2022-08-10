# 1. Set up initial renv for current project -----
# Make sure you have the project open and are in the project dir

# Initialize your renv
# bare option starts with an empty renv library
renv::init(bare=TRUE)

# Set proxy via env variables
source("~/devel/set_proxy.R")

# Set repository options
# Include all repositories you want to be available in your renv.lock file
my_repos <- c(
    'CRAN'="https://cran.rstudio.com/",
    'BMS BRAN'="http://pm.rdcloud.bms.com:4242/bms-cg-biogit-bran/latest"
)
options(repos=my_repos)
options()$repos

# Install a package from BMS RSPM BRAN internal packages
renv::install(c("bmspal", "bmsdash"))

# Install packages from CRAN
pkg_list <- c(
  "tidyverse", "gt", "gtExtras", "reactable", "ggiraph", "here", "quarto",
  "rmarkdown", "gtsummary", "palmerpenguins", "fs", "skimr", "DT", "markdown"
)
install.packages(pkg_list)


# 2. Save an initial snapshot -----
# type="all" includes all installed packages in your lock file
# The default behavior with type="implicit" is that renv tried to determine which
# packages are used by your project and only includes those
renv::snapshot(type="all", prompt=FALSE)


# 3. Add a new package and update snapshot -----
# Imagine you are working on the project a few days later and want to use an
# additional package or two
source("~/devel/set_proxy.R")
# Make sure your repository options are correct first.
# They are set by renv from the renv.lock file when you open a project, but if you
# need to add another repository then you will need to update options()$repos
# before updating your snapshot.
options()$repos
install.packages("ggplot2")
renv::snapshot(type="all", prompt=FALSE)

# Final: sharing your code -----
# Your code collaborator can clone the Git repo (which will include the renv.lock,
# .Rprofile, renv/activate.R, and renv/settings.dcf files) and restore the
# same package versions specified in renv.lock
renv::restore()
