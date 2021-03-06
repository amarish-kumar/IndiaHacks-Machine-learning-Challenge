rm(list=ls(all=T))

setwd("SET YOUR WORKING DIRECTORY")

require(randomForest)

train <- read.csv("train.csv", header = TRUE, sep = ",")
test <- read.csv("test.csv", header = TRUE, sep = ",")

## AS WE HAVE ASPECT RATIO WHICH IS THE RATIO BETWEEN THE WIDTH AND HEIGHT, WE DONT NEED THE EXPLICIT WIDTH AND HEIGHT
train$SignWidth <- NULL
train$SignHeight <- NULL
train$Id <- NULL

test$SignWidth <- NULL
test$SignHeight <- NULL
testid <- test$Id
test$Id <- NULL

## RENAMING THE TARGET COLUMN TO SOMETHING NICE
colnames(train)[4] <- "Target"

model_rf <- randomForest(Target ~ ., train, ntree = 30, mtry = 2, probability = TRUE)
model_rf

pred <- data.frame(predict(model_rf, test, type = "prob"))
final_pred <-cbind(testid,pred)

## MAKING THE DATAFRAME IN REQUIRED FORMAT
names(final_pred) <- c("Id","Front","Left","Rear","Right")
write.csv(final_pred,"final_prediction.csv", row.names = FALSE)
