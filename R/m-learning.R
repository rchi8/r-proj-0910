#install.packages("caret")
#install.packages("e1071")
#install.packages("kernlab")

library(caret)
library(e1071)

library(kernlab)
data(spam)
head(spam)
table(spam[,58])

# 学習用データとテスト用データに分ける
train.index <- createDataPartition(spam$type, p=0.5, list=F)
spam.train <- spam[train.index,]
spam.test <- spam[-train.index,]


# トレーニング方法のカスタマイズ：LGOCVで７５％をとレーニンに使う５回
fitControl <- trainControl(method="LGOCV",
                           p=0.75,
                           number=5)

# svm
spam.svm <- train(spam.train[,-58], spam.train$type,
                  method="svmRadial",
                  preProcess=c("center", "scale"),
                  trControl=fitControl)

# ランダムフォレスト
spam.rf <- train(spam.train[,-58], spam.train$type,
                 method="rf",
                 preProcess=c("center", "scale"),
                 trControl=fitControl)

allPred <- extractPrediction(list(spam.svm, spam.rf),
                             testX = spam.test[,-58], testY = spam.test$type)

testPred <- allPred[allPred$dataType=="Test",]

tp.svm <- testPred[testPred$model=="svmRadial",]
tp.rf <- testPred[testPred$model=="rf",]

confusionMatrix(tp.svm$pred, tp.svm$obs)
confusionMatrix(tp.rf$pred, tp.rf$obs)