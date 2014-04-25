Homework [5]: Time Series
==============================

| **Name**  | Octavio Suarez Munist  |
|----------:|:-------------|
| **Email** | osuarezmunist@dons.usfca.edu |

## Instructions ##

Run hw5v1.R script to produce plots

## Discussion ##

The Seatbelts data sets presents several challenges, as it is a time series with a clear seasonal cycle. Additionally, there are a number of measured changes of the time period, including the enactemetn of a seatbelt law in 1983 and changes in miles driven over time. Since the data set only goes until 1984, the seatbelt law is only in effect for 2 of the 16 years of data. Furthermore, there are many known changes to cars and driving habits not incldued in the data set. 

Also, multiple accident variables are reported, inlcuding deaths and injuries. It is hard to know which one is most impacted by seatbelts versus other changes.

I plotted 5 time series together:

![IMAGE](MUltivariateTS.png)

From these I picked Drivers Killed as the more interesting series, as van drivers was too low and the other ones mixed deaths and injuries, which seemed to be affected more by events before the Seatbelt Law.

To account for increases in KMs driven, I converted the number of deaths to a rate. I used color and a vertical bar to mark the enactement of the Seatbelt Law.

![IMAGE](Timeline.png)


Due to the cyclical nature of the data, I used a star plot to show the trend of decreasing vehicular deaths each month over time, but not clear if this was a results of the law.

![IMAGE](Starr.png)

