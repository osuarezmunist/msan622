Homework 2: Interactivity
==============================

| **Name**  | Octavio Suarez Munist  |
|----------:|:-------------|
| **Email** | osuarezmunist@dons.usfca.edu |

## Instructions ##

The following packages must be installed prior to running this code:

- `ggplot2`
- `shiny`

To run this code, please enter the following commands in R:

```
setwd(<download directory for ui.r and server.r files>)
runApp()
```

This will start the `shiny` app. See below for details on how to interact with the visualization.

## Discussion ##

Provided a simple scatter plot with four input widgets to filter by rating and genre. Instead of sliders for appearance of dots, used two sliders to allow filtering by budget. This seemed like a more useful set of controls to explore the data.


I only filtered out movies with no budget, as the rest can be filtered by user.
