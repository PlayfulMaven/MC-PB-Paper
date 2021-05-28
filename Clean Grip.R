
# Allometric Grip Score ----------------------------------------------------------------

# Formula:  Grip score / ([BM^exponent] * [Ht^exponent])

allo_grip <- function(df, id, sex,  age, height_in_meters, weight_in_kg, grip_value_in_kg) {
  
  male <- df %>%
    filter(sex == 1) %>%
    select(all_of(c(id, sex, age, height_in_meters, weight_in_kg, grip_value_in_kg)))
  
 # female <- df %>%
  #  filter(sex == 0) %>%
   # select(all_of(c(id, sex, age, height_in_meters, weight_in_kg, grip_value_in_kg)))
  
  male_grip <- read_csv(here("Ref Tables", "Allometric Grip Norms - Boys.csv"))
  
  wts <- male_grip[c(1:2), c(2:14)]
  
  wts <- as.data.frame(t(wts))
  
  colnames(wts) <- c("B1 (Ht)", "B2 (BM)")
  
  wts$Age <- row.names(wts)
  
  wts<- wts %>%
    relocate("Age", .before = "B1 (Ht)") %>%
    mutate_at(1:3, as.numeric)
  
  df1 <- setDT(male[, c("PartID", "Age_Test_yrs")])
  df2 <- setDT(wts)
  
  df3 <- df2[df1, on = c("Age" = "Age_Test_yrs"), roll = TRUE]
  
  male <- male %>%
    left_join(df3, 
              by = c("PartID", "Age_Test_yrs" = "Age"))
  
  male$allo_grip <- (male$Grip_Max_Mean_kg) / ((male$Weightkg^male$`B2 (BM)`) *
                                                 (male$Height^male$`B1 (Ht)`))
  male_key <- male[, c("PartID", "allo_grip")]
}

test <- allo_grip(PB, "PartID", "sex", "Age_Test_yrs", "Ht_meters", "Weightkg", 
                  "Grip_Max_Mean_kg")
