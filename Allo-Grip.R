
# Allometric Grip Functions

# Loading libraries

library(tidyverse)
library(data.table)
library(here)

# Loading Data

PB <- read_csv(here("Data Files", "csv Files", "A Plus Data.csv"))

PB <- rowid_to_column(PB)

male <- PB[, c("rowid", "PartID", "sex","Age_Test_yrs", "StaHt", "Weightkg", "Grip_Max_Mean_kg")]

male <- male[male$sex == 1, ]

female <- PB[, c("rowid", "PartID", "sex","Age_Test_yrs", "StaHt", "Weightkg", "Grip_Max_Mean_kg")]

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

allo_grip <- function(id, sex,  age, height_in_cm, weight_in_kg) {

male <- PB[, c("rowid", "PartID", "sex","Age_Test_yrs", "StaHt", "Weightkg", "Grip_Max_Mean_kg")]

male <- male[male$sex == 1, ]

female <- PB[, c("rowid", "PartID", "sex","Age_Test_yrs", "StaHt", "Weightkg", "Grip_Max_Mean_kg")]

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
female_key <- female[, c("PartID", "allo_grip")]

grip_key <- rbind(male_key, female_key)

grip_key$allo_grip <- round(grip_key$allo_grip,
                            digits = 3)
PB <- PB %>%
  left_join(grip_key,
            by = "PartID")

}


# Allometric Grip Percentile -------------------------------------------------------------




# Allometric Grip Score and Percentile ---------------------------------------------------


