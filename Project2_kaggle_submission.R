library(ranger)
library(dplyr)
library(lubridate)

set.seed(123)

# ======================
# Wczytanie danych
# ======================

bike_train <- read.csv("bike_train.csv")
bike_test  <- read.csv("bike_test.csv")

test_dates <- bike_test$date

bike_train <- bike_train %>% select(-X)
bike_test  <- bike_test %>% select(-X)

# ======================
# MODEL 1 - RF v2
# ======================

train_v2 <- bike_train
test_v2  <- bike_test

train_v2$date <- as.Date(train_v2$date)
test_v2$date  <- as.Date(test_v2$date)

train_v2$weekend <- ifelse(wday(train_v2$date) %in% c(1, 7), 1, 0)

test_v2$weekend <- ifelse(wday(test_v2$date) %in% c(1, 7), 1, 0)

train_v2$month <- month(train_v2$date)
test_v2$month <- month(test_v2$date)

train_v2$dayofweek <- wday(train_v2$date)
test_v2$dayofweek <- wday(test_v2$date)

train_v2$date <- NULL
test_v2$date <- NULL

rf_v2 <- ranger(count ~ ., data = train_v2, mtry = 5, min.node.size = 1, num.trees = 1000, seed = 123)

pred_v2 <- predict(rf_v2, test_v2)$predictions

# ======================
# MODEL 2 - RF v6
# ======================

train_v6 <- bike_train
test_v6  <- bike_test

train_v6$date <- as.Date(train_v6$date)
test_v6$date  <- as.Date(test_v6$date)

train_v6$weekend <- ifelse(wday(train_v6$date) %in% c(1, 7), 1, 0)

test_v6$weekend <- ifelse(wday(test_v6$date) %in% c(1, 7), 1, 0)

train_v6$month <- month(train_v6$date)
test_v6$month <- month(test_v6$date)

train_v6$dayofweek <- wday(train_v6$date)
test_v6$dayofweek <- wday(test_v6$date)

train_v6$date_num <- as.numeric(train_v6$date)
test_v6$date_num <- as.numeric(test_v6$date)

train_v6$date <- NULL
test_v6$date <- NULL

rf_v6 <- ranger(count ~ ., data = train_v6, mtry = 5, min.node.size = 1, num.trees = 1000, seed = 123)

pred_v6 <- predict(rf_v6, test_v6)$predictions

# ======================
# Ensemble RF
# ======================

pred_rf <- 0.5 * pred_v2 + 0.5 * pred_v6

# ======================
# MODEL 3 - Extra Trees
# ======================

train_et <- bike_train
test_et  <- bike_test

train_et$date <- as.Date(train_et$date)
test_et$date  <- as.Date(test_et$date)

train_et$weekend <- ifelse(wday(train_et$date) %in% c(1, 7), 1, 0)

test_et$weekend <- ifelse(wday(test_et$date) %in% c(1, 7), 1, 0)

train_et$month <- factor(month(train_et$date))
test_et$month <- factor(month(test_et$date), levels = levels(train_et$month))

train_et$dayofweek <- factor(wday(train_et$date))
test_et$dayofweek <- factor(wday(test_et$date), levels = levels(train_et$dayofweek))

train_et$date_num <- as.numeric(train_et$date)
test_et$date_num <- as.numeric(test_et$date)

train_et$date <- NULL
test_et$date <- NULL

extra <- ranger(count ~ ., data = train_et, splitrule = "extratrees", num.trees = 3000, mtry = 4, min.node.size = 3, seed = 123)

pred_et <- predict(extra, test_et)$predictions

# ======================
# Finalne ensemble
# ======================

pred_final <- 0.9 * pred_et + 0.1 * pred_rf

# ======================
# Submission
# ======================

submission <- data.frame(date = test_dates, pred = pred_final)

write.csv(submission, "submission_final.csv", row.names = FALSE)

head(submission)

