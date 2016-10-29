#setwd("C:\\rector\\git\\machinelearning")

library(caret)


train_csv = "pml-training.csv"
test_csv = "pml-testing.csv"
set.seed(3921837)

all_training <- read.csv(train_csv)
final_testing <- read.csv(test_csv)

all_training[is.na(init_training)] <- 0

inTrain <- createDataPartition(y=all_training$classe,
                               p=0.75, list=FALSE)

training <- all_training[inTrain,]
testing <- all_training[-inTrain,]


#modTree <- train(classe ~., method="rpart", data=x)
#ctrl <- trainControl(method = "repeatedcv", repeats = 3)
#modForestBoot <- train(classe ~., method="rf", data=x, 
#                       trControl=trainControl(method = "boot", number = 20))

nzv_cols <- nearZeroVar(training)
training_trim <- training[, -nzv_cols]

x <- training_trim[sample(nrow(training_trim), 1000),]
x <- subset(x, select=-c(cvtd_timestamp))

modTreeBoot5 <- train(classe ~., method="rpart", data=x, trControl=trainControl(method = "boot", number = 5))
modTreeCv5 <- train(classe ~., method="rpart", data=x, trControl=trainControl(method = "cv", number = 5))
modGbmBoot5 <- train(classe ~., method="gbm", data=x, verbose=FALSE,
                    trControl=trainControl(method = "boot", number = 5))
modForestCv5 <- train(classe ~., method="rf", data=x, verbose=FALSE,
                      trControl=trainControl(method = "cv", number = 5))

