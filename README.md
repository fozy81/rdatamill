
# Rdatamill

This package is designed to allow uses to create web forms particularly for collecting experimental data. It uses the shiny package to create a user interface to create forms, enter results, validate reults and display the results. Allowing uses to share their experiment as a service (EaaS) to other R users.

# Install

Currently, the package is only available on GitHub.

```r
# install.packages("devtools")
devtools::install_github(fozy81/rdatamill")
```

# Introduction

This package is aimed a students wanting to record experimental data but using something more formal than a spreadsheet. It allows users to create custom forms via a user interface.

![create_test](./create_test.png?raw=true)

Results can then be entered into the forms.

![enter_data](./enter_data.png?raw=true)

Validation rules can be applied to the results. And the results confirmed as valid and saved. Analysis and reports can then be written based on this data for instance in R Markdown and finally the package submitted for assessment to the lecturer :)

![analysis](./analysis.png?raw=true)

Currently all data is saved locally. And there are loads of bugs so not recommended for use at this stage!

