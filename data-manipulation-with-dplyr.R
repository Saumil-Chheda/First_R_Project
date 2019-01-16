#load the dplyr package
library("dplyr")

#read in the gapminder data
dat <- read.csv("data/gapminder_data.csv")

dat$gdpPercap #reference the column of the data by name
mean(dat$gdpPercap) #average gdp
dat[1:5,"gdpPercap"]
mean(dat[1:5,"gdpPercap"])
mean(dat[dat$continent=="Americas","gdpPercap"]) #average gdp for Americas

#### using dplyr for data subsetting ----
# filter chooses the rows
filter(dat, continent =="Americas")
filter(dat, year > 2000)
dat_2 <- filter(dat, year>2000, continent=="Americas")

# select chooses the columns
select(dat, continent)
select(dat_2,country,year,gdpPercap)

# %>% this is the equivalent of pipe in the unix shell
dat %>% 
  filter(continent == "Americas",year>2000) %>% 
  select(country, year,gdpPercap)
#the above three lines form 1 command only

sin(log(exp(5)))
#also can be wriiten using pipe functions as below
5 %>% 
  exp() %>% 
  log() %>% 
  sin()

#### group_by() and summarize() ----
summary_1 <- dat %>% 
  group_by(country) %>% 
  summarize(avg_life_exp = mean(lifeExp))

####Challenge Questions ----
# 1. Compute the average gdpPercap for each country

sol_challenge1.1 <- dat %>% 
  group_by(country) %>% 
  summarize(avg_gdpPercap = mean(gdpPercap))

# 2. Compute the average gdpPercap for each continent in year 1957

sol_challenge1.2 <- filter(dat,year==1957) %>% 
  group_by(continent) %>% 
  summarize(avg_gdpPercap = mean (gdpPercap))

#### multiple summary outputs ----
dat %>% 
  group_by(continent) %>% 
  summarize(avg_gdp = mean(gdpPercap),
            min_gdp = min(gdpPercap),
            max_gdp = max(gdpPercap),
            median_gdp = median(gdpPercap),
            sd_gdp = sd(gdpPercap),
            num_values = n())

#### making new column variables ----
dat %>% 
  mutate(gdp_billion = gdpPercap * 10^9)

#### wide vs long in gapminder data ----
dat2 <- dat %>%
  select(country,year,gdpPercap)

library(tidyr)
#long to wide
dat2_wide <- dat2 %>%
  spread(year,gdpPercap)

#wide to long
dat2_long <- dat2_wide %>% 
  gather(year,gdp, "1952":"2007")
