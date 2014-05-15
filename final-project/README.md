Final Project
==============================

| **Name**  | Octavio Suarez Munist  |
|----------:|:-------------|
| **Email** | osuarezmunist@dons.usfca.edu |

### Introduction ###
The purpose of this prototype was to explore the benefits of using visualizations to quickly assess the potential value of a survey of students. I regularly have to analyze results of questionnaires administered by third parties with no previous knowledge or information about the origin of the questions or the purpose of the survey. In addition to basic descriptives, I am trying to (1) eliminate uninteresting or mal-functioning questions, (2) group questions into dimensions and/or indexes and (3) select dependent and independent variables for regressions. This requires an iterative process to select variables of interest and group into associated sets. I am exploring the use of visualizations to (1) more efficiently make the first "cuts" of the variables and (2) reduce the number and length of iterations to the final selection and grouping of the variables of interest. 

I envision this being a useful tool for me and my colleagues doing similar work. I expect to end up with 8-10 visualizations that can be used across many similar questionnaires, but do not expect all visualizations to work for all data sets.



### Data Set ###
I selected a typical data set of around 800 responses to a pre-course survey of a college chemistry course. Variable types were limited to categorical and discrete ordinal, mostly 5-point Likert scale. The homogeneity of the ordinal variables reduces the rescaling and recoding significantly. The questions can be seen in the DataDictionaryR.csv file. There are a total of 50 questions. I could not include the response labels because on the public version of the data, but all ordinal questions are multiple choice with a short range of response values.  


### Techniques ###
A major issue when dealing with long lists of variables is displaying the associated question prompts. Since the prompts are arbitrarily long and not easy so reduce to a few characters, I chose to use the variable/column names in all visualization. This is in line with what is done in the analysis, although final results would need to include prompts. I provided a tab with the variable names and associated prompts so users can easily look these up.

#### Small Multiples of Response Frequencies ####
This will usually be the place to start exploring the data set. First, I explored visualizations of summary statistics such as mean, mode, and skewness. However, visualizing the shape of the distribution proved to be most efficient way to identify variables with problematic distributions. For example, in the plot below, variables Q06, Q07, Q08 stand out very clearly as having an extreme response pattern with little variance. (I will discuss the use of color in the interactivity section).

LIE FACTOR: This is a major concern when looking at a dynamic set of variables because the scales can change dramatically depending on the set of variables. In the plot below, Q12 has a 7-point that extends the x-axis. 

DATA DENSITY: Small multiples are quite dense to begin with, even when the response scale varies slightly. 

DATA TO INK RATIO: Again, small multiples have very good DIR, but require a lot of mental processing. While the axis labels are repeated, the alternatives would increase eye-ball travel exponentially. I tried including the question prompts for each sub-plot, but this turn the small into large multiples.

![IMAGE] (SmallMult.png)

#### HeatMap of Correlations ####
Once a few bad variables, have been dropped, I find this heatmap to be extremely useful. It allows for a quick selection of the first groupings of variables for analysis. I mapped the strength of the correlations between pairs of variables to a divergent 2-color palette. In the plot below, you can quickly see the variables that are good candidates to group for further analysis. 

In this exploration, I was interested in examining visual representations of many types of statistics to make the analysis of a data set more efficient. I find this plot to be very effective at presenting the top-level view of the potential associations between variables. It tells me where to start.


LIE FACTOR: As correlations range from -1 to 1, this result in a sufficiently precise mapping of the statistic. The eye is drawn towards the more saturated tiles, as is desired.  

DATA DENSITY: Taking into account that each correlation is a summary of 2N data points, the data density is very good. While the size of the tiles can be reduced to just large enough for the human eye to distinguish differences in shading between adjacent cells, I tried to use as much screen space as available to facilitate the identification of the pairs of interest.

DATA TO INK RATIO: The biggest waste, of course, is the redundancy of the matrix due to the diagonal symmetry. I tried graying out the top-left or bottom-right halves, but that gave readers the impression that something was wrong or missing. Also, people may vary in their choice of which halt to use. So, it seems to be the standard to ink on both sides of the diagonal.



![IMAGE] (HeatMap.png)


#### Bar Graph of Factor Analysis Runs ####
I played around with line graphs, including scree plots, before settling on this bar chart to show multiple runs of factor analysis. Using lines resulted in overplotting. Because I arbitrarily chose 10 as the maximum number of choices, I only found one Color Brewer palette that would accommodate this. The colors are ugly, but the contrast is good to be able to follow the percent of variance explained by factor for each run. 
The plot clearly shows the loss in variance explained to the first factor when adding more factors to the computation. It is not so clear for other factors. 


LIE FACTOR: Since all the CFA runs are put on the same scale (0-1.0) the lie factor is very good, as bar heights can be accurately compared on both the x and y dimensions.

DATA DENSITY: Again, considering the amount of data points and computation behind multiple CFA runs, the plot is very efficient. Additionally, 

DATA TO INK RATIO: The bar chart captures both the total as well as the individual factors' proportion of variance explained with the bars. I think this is a good balance between ink and readability.


![IMAGE] (Factor.png)


#### Parallel Coordinates Plot ####
This plot presents another way to see the pair-wise correlations between multiple variables. Since the variables are discrete, I "mapped" the frequency of co-occurrences of responses of adjacent variables to the alpha level by setting it  very low (.01) so more frequently occurring co-occurrences would result in more visible lines. While this plot is more vulnerable to an ordering effect than the heatmap above, it does also provide a general sense of each variable's response frequency. It may also help identify unusual response patterns such as selecting the same response for all questions.  


LIE FACTOR: The biggest concern with parallel coordinates plot is the ordering effect. That can hide or exaggerate the apparent strength of an association. 

DATA DENSITY: PCPs allow multiple variables to me mapped simultaneously, making them dense. They provide some sense of the distribution of the responses, especially when not scaled, as is possible when the variables mapped have similar discrete ranges. This homogeneity reduces the number of lines and allows for smaller plots if desired, when very efficient data density

DATA TO INK RATIO: Lines between points do not have goof DIR, but, in this plot, where the frequency of co-occurrences is mapped to the alpha level of the lines, the result is a reduction in the number of lines. Rather than the number of lines being a function of the number of cases, it is a function of the number of choices. This reduces overplotting tremendously and results in a good data to ink ratio, even for a line graph.


![IMAGE] (ParCoord.png)


### Interactivity ###
Since the purpose of this tool is to allow for the selection of variables for further analysis, I implemented two user-selected widgets to support this selection. I listed the ordinal variables in a multi-select checkbox and the categorical variables in a radio button. While this is a simple interface, the interaction with the four plots results in a powerful to quickly familiarize a statistically trained user with a new data set. The ability to efficiently iterate through different types of analysis on the way to coming up with a triage of the variables in the data set.

Every time an ordinal variable is selected or de-selected, the active plot is regenerated, and this carries through to all other plots if made active. When a categorical variable is selected, the frequencies and parallel coordinates plots are redrawn with  the categories mapped to color. 

The combination of a simple checkbox for selecting the variables of interest with automatic generation of visual representations of key descriptives and statistics results in a much more efficient process to become familiar with a new data set. 

### Prototype Feedback ###
I was unable to participate in the class feedback activity due to illness. However, I showed a number of versions of the tool to my colleagues at work. A number of visualizations were dropped based on their feedback. In particular, line graphs quickly became too dense be efficient even with a relatively small data set. Secondly, the need for more control (through more widgets) quickly became too costly to program. It became clear that the tool worked best early in the data analysis process, but would just become one more interface to learn to navigate if extended.


### Challenges ###
My first challenge was selecting a limited number of statistics that would be useful but not mislead the user, especially for the more sophisticated analysis where there are many assumptions and statistics to check before reaching conclusions. 

Additionally, the variable in the data set corresponded to question prompts that were arbitrarily long. This is a major difficulty when working with many data sets like this one. You do not have time to come up with meaningful but short variables, so we simply have to reference questions by the variable name ("Q_*). I added a tab with this mapping, and it actually is very helpful, as one can keep looking at the screen instead of changing to another screen. 

My third challenge was to create a simple interface in shiny. The problem was that I had a long list of variables, but I wanted to create a tool that was flexible enough to read different data sets. This resulted in an overly long multi-select widget that required scrolling and hid other widgets. If I had more time, I would have figured out a better way to show the selected variables. 

I tried to add a few more widgets to add additional functionality, but these quickly became too complex, as there would need to be a lot of code needed to handle the particularities of different types of variables. I think that my keeping the tool very simple, it can allow to more efficiently iterate through the first cycles of data analysis.

