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

This shiny, new App provides a simple scatter plot with four input widgets to filter by rating and genre. Instead of sliders for manualcontrol of appearance of dots, I used two sliders to allow filtering by budget. This seemed like a more useful set of controls to explore the data. I set a low (0.2) initial alpha level to show overlapping points, but increased the alpha level as the proportion of mapped to total points decreased.


I only filtered out movies with no budget, as the rest can be filtered by user. User can gray out undesired genres. However, MPAA ratings and budgets not in the selected category/ies and range, respectively, are removed completely to reduce clutter and allow x-axis to zoom in. I fixed the range of the y-axis, but, after playing around with fixing the origin at 0 for the x-axis, I decided to allow it to change to allow for zooming in on the x-axis.
