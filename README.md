
# Rdatamill alpha - not recommended for use

This package is designed as framework for users to create web forms particularly for collecting experimental data. It uses the shiny package to provide users with an UX interface to create forms. The user can then enter, validate and analyse results. Allowing uses to share their Experiment as a Service (EaaS) to other R users.

# Install

Currently, the package is only available on GitHub.

```r
# install.packages("devtools")
devtools::install_github(fozy81/rdatamill")
```

# Introduction

This package is aimed a students wanting to record experimental data but using something more formal than a spreadsheet. It allows users to create custom forms via a user interface.

![create_test](./create_form.png?raw=true)

Results can then be entered into the forms.

![enter_data](./enter_data.png?raw=true)

Validation rules can be applied to the results. Complex validation rules can can be written as R functions an applied to results to detect errors and anomalies. The results confirmed as valid and saved. Analysis and reports can then be written based on this data for instance in R Markdown and finally the package submitted for assessment to the lecturer :)

![analysis](./analysis.png?raw=true)

Currently all data is saved locally. And there are loads of bugs so not recommended for use at this stage!

