library(tidyverse)
library(readr)

data_rae<- read_csv(file.choose())
data_rae

glimpse(data_rae)

final_SO2_23M_data<- data_rae %>% distinct() %>%
  mutate(
    so2_column = as.numeric(so2_column),
    year=as.integer(year),
    month = as.integer(month)
    
  ) %>% filter(
    !is.na(latitude),
    !is.na(longitude),
    !is.na(so2_column),
    so2_quality >=1
  ) %>% group_by(month,year) %>%
  summarise(
    Avg_so2 = mean(so2_column,na.rm=TRUE),
    Total_Records = n(),
    .groups = 'drop'
  ) %>% arrange(desc(Total_Records))

final_SO2_23M_data

write.csv(final_SO2_23M_data,'so2_emission_23M_record_data.csv',
          row.names = FALSE)

getwd()
