
# Allometric Grip Functions

# Loading libraries

library(tidyverse)
library(data.table)
library(here)

# Loading Data

PB <- read_csv(here("Data Files", "csv Files", "A Plus Data.csv"))

male <- PB[, c("PartID", "sex","Age_Test_yrs", "StaHt", "Weightkg", "Grip_Max_Mean_kg")]

male <- male[male$sex == 1, ]

female <- PB[, c("PartID", "sex","Age_Test_yrs", "StaHt", "Weightkg", "Grip_Max_Mean_kg")]

female <- female[female$sex == 0, ]

# Loading reference tables

male_grip <- read_csv(here("Ref Tables", "Allometric Grip Norms - Boys.csv"))

wts <- male_grip[c(1:2), c(2:14)]

wts <- as.data.frame(t(wts))

colnames(wts) <- c("B1 (Ht)", "B2 (BM)")

wts$Age <- row.names(wts)

wts<- wts %>%
  relocate("Age", .before = "B1 (Ht)") %>%
  mutate_at(1:3, as.numeric)

male$Height <- male$StaHt/100 # make sure to write something in to change cm to meters

male <- male[, -4] # then drop the centimeters

df1 <- setDT(male[, c("PartID", "Age_Test_yrs")])
df2 <- setDT(wts)

df3 <- df2[df1, on = c("Age" = "Age_Test_yrs"), roll = TRUE]

male <- male %>%
  left_join(df3, 
            by = c("PartID", "Age_Test_yrs" = "Age"))

male$allo_grip <- (male$Grip_Max_Mean_kg) / ((male$Weightkg^male$`B2 (BM)`) *
                                               (male$Height^male$`B1 (Ht)`))
male_key <- male[, c("PartID", "allo_grip")]

### Females

female_grip <- read_csv(here("Ref Tables", "Allometric Grip Norms - Girls.csv"))

wts <- female_grip[c(1:2), c(2:14)]

wts <- as.data.frame(t(wts))

colnames(wts) <- c("B1 (Ht)", "B2 (BM)")

wts$Age <- row.names(wts)

wts<- wts %>%
  relocate("Age", .before = "B1 (Ht)") %>%
  mutate_at(1:3, as.numeric)

female$Height <- female$StaHt/100 # make sure to write something in to change cm to meters

female <- female[, -4] # then drop the centimeters

df1 <- setDT(female[, c("PartID", "Age_Test_yrs")])
df2 <- setDT(wts)

df3 <- df2[df1, on = c("Age" = "Age_Test_yrs"), roll = TRUE]

female <- female %>%
  left_join(df3, 
            by = c("PartID", "Age_Test_yrs" = "Age"))

female$allo_grip <- (female$Grip_Max_Mean_kg) / ((female$Weightkg^female$`B2 (BM)`) *
                                                   (female$Height^female$`B1 (Ht)`))
female_key <- female[, c("PartID", "allo_grip")]

grip_key <- rbind(male_key, female_key)

grip_key$allo_grip <- round(grip_key$allo_grip,
                            digits = 3)
PB <- PB %>%
  left_join(grip_key,
            by = "PartID")

huh <- PB[, c(1, 2, 24, 37, 26)]

# Allometric Grip Score ----------------------------------------------------------------

# Formula:  Grip score / ([BM^exponent] * [Ht^exponent])

allo_grip <- function(df, id, sex){#,  age, height_in_meters, weight_in_kg, grip_value_in_kg) {

  male <- df %>%
    filter(sex == 1) %>%
    select(all_of(c(id, sex)))#, age, height_in_meters, weight_in_kg, grip_value_in_kg)))
  
#male <- df[df$sex == 1, ]
  
#male <- male[, c(id, sex, age, height_in_cm, weight_in_kg, 
    #           grip_value_in_kg)]
}

test <- allo_grip(PB, "PartID", "sex")

female <- df[df$sex == 0, ]

female <- female[, c("PartID", "sex","Age_Test_yrs", "StaHt", "Weightkg", 
                 "Grip_Max_Mean_kg")]

# Loading reference tables

male_grip <- read_csv(here("Ref Tables", "Allometric Grip Norms - Boys.csv"))

wts <- male_grip[c(1:2), c(2:14)]

wts <- as.data.frame(t(wts))

colnames(wts) <- c("B1 (Ht)", "B2 (BM)")

wts$Age <- row.names(wts)

wts<- wts %>%
  relocate("Age", .before = "B1 (Ht)") %>%
  mutate_at(1:3, as.numeric)

male$Height <- male$StaHt/100 # make sure to write something in to change cm to meters

male <- male[, -5] # then drop the centimeters

df1 <- setDT(male[, c("PartID", "Age_Test_yrs")])
df2 <- setDT(wts)

df3 <- df2[df1, on = c("Age" = "Age_Test_yrs"), roll = TRUE]

male <- male %>%
  left_join(df3, 
            by = c("PartID", "Age_Test_yrs" = "Age"))

male$allo_grip <- (male$Grip_Max_Mean_kg) / ((male$Weightkg^male$`B2 (BM)`) *
                                               (male$Height^male$`B1 (Ht)`))
male_key <- male[, c("PartID", "allo_grip")]

### Females

female_grip <- read_csv(here("Ref Tables", "Allometric Grip Norms - Girls.csv"))

wts <- female_grip[c(1:2), c(2:14)]

wts <- as.data.frame(t(wts))

colnames(wts) <- c("B1 (Ht)", "B2 (BM)")

wts$Age <- row.names(wts)

wts<- wts %>%
  relocate("Age", .before = "B1 (Ht)") %>%
  mutate_at(1:3, as.numeric)

female$Height <- female$StaHt/100 # make sure to write something in to change cm to meters

female <- female[, -5] # then drop the centimeters

df1 <- setDT(female[, c("PartID", "Age_Test_yrs")])
df2 <- setDT(wts)

df3 <- df2[df1, on = c("Age" = "Age_Test_yrs"), roll = TRUE]

female <- female %>%
  left_join(df3, 
            by = c("PartID", "Age_Test_yrs" = "Age"))

female$allo_grip <- (female$Grip_Max_Mean_kg) / ((female$Weightkg^female$`B2 (BM)`) *
                                                   (female$Height^female$`B1 (Ht)`))

# Making Keys and Joining

female_key <- female[, c("PartID", "allo_grip")]

grip_key <- rbind(male_key, female_key)

grip_key$allo_grip <- round(grip_key$allo_grip,
                            digits = 3)
PB <- PB %>%
  left_join(grip_key,
            by = "PartID")



# Allometric Grip Percentile -------------------------------------------------------------

male_grip <- read_csv(here("Ref Tables", "Allometric Grip Norms - Boys.csv"))

percents <- male_grip[c(3:16), c(2:14)]

percents <- as.data.frame(t(percents))

colnames(percents) <- c(".01", ".05", ".10", ".20", ".21", ".30", ".40", ".50", ".60", ".70",
                        ".80", ".90", ".95", ".99")

percents$Age <- row.names(percents)

hmm <- percents %>% 
  pivot_longer(c(".01", ".05", ".10", ".20", ".21", ".30", ".40", ".50", ".60", ".70",
                 ".80", ".90", ".95", ".99"),
               names_to = "allo_grip_percentile",
               values_to = "allo_grip") %>%
  relocate("allo_grip", .before = "allo_grip_percentile")

male_percent <- male[, c("PartID", "Age_Test_yrs", "allo_grip")]

df_percent <- setDT(male[, c("PartID", "Age_Test_yrs", "allo_grip")])
df_percent$Age_Test_yrs <- floor(df_percent$Age_Test_yrs)

hmm <- hmm %>%
  mutate_at(1, as.numeric)

df_prct_key <- setDT(hmm)

df_prct_final <- df_prct_key[df_percent, 
                             on = c("Age" = "Age_Test_yrs", "allo_grip" = "allo_grip"),
                             roll = Inf]

male_key <- df_prct_final[, c("PartID", "allo_grip_percentile")]

#### Female Percentiles
female_grip <- read_csv(here("Ref Tables", "Allometric Grip Norms - Girls.csv"))

percents <- female_grip[c(3:16), c(2:14)]

percents <- as.data.frame(t(percents))

colnames(percents) <- c(".01", ".05", ".10", ".20", ".21", ".30", ".40", ".50", ".60", ".70",
                        ".80", ".90", ".95", ".99")

percents$Age <- row.names(percents)

prct_key <- percents %>% 
  pivot_longer(c(".01", ".05", ".10", ".20", ".21", ".30", ".40", ".50", ".60", ".70",
                 ".80", ".90", ".95", ".99"),
               names_to = "allo_grip_percentile",
               values_to = "allo_grip") %>%
  relocate("allo_grip", .before = "allo_grip_percentile")

female_percent <- female[, c("PartID", "Age_Test_yrs", "allo_grip")]

df_percent <- setDT(female[, c("PartID", "Age_Test_yrs", "allo_grip")])
df_percent$Age_Test_yrs <- floor(df_percent$Age_Test_yrs)

prct_key <- prct_key %>%
  mutate_at(1, as.numeric)

df_prct_key <- setDT(prct_key)

df_prct_final <- df_prct_key[df_percent, 
                             on = c("Age" = "Age_Test_yrs", "allo_grip" = "allo_grip"),
                             roll = Inf]

female_key <- df_prct_final[, c("PartID", "allo_grip_percentile")]

percent_key <- rbind(male_key, female_key)

PB <- PB %>%
  left_join(percent_key,
            by = "PartID")

hmm <- PB[, c("PartID", "Grip_Percentile", "Grip_Class", "allo_grip_percentile")]

PB <- PB %>%
  mutate_at("allo_grip_percentile", as.numeric)

PB$allo_grip_percentile <- PB$allo_grip_percentile*100

PB$Allo_Grip_Max_Mean_KG <- PB$allo_grip

PB <- PB[, -c(25:27)]

PB <- PB[, -34]

PB <- PB %>%
  relocate("allo_grip_percentile", .before = "Grip_Max_Mean_kg")

PB$allo_grip_class <- PB$allo_grip_percentile %>%
  cut(breaks = c(0, 21, 80, Inf),
      labels = c(1, 2, 3),
      right = FALSE) 

PB <- PB %>%
  relocate("allo_grip_class", .before = "Grip_Max_Mean_kg")

write_csv(PB, here("Data Files", "Clean Data", "PB.csv"))

# Allometric Grip Score and Percentile ---------------------------------------------------


