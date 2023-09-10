# XGBoostのインストール
#install.packages("xgboost")

# 既存のパッケージとデータの読み込み
library(caret)
library(e1071)
library(kernlab)
data(spam)

# XGBoostパッケージの読み込み
library(xgboost)

# データの分割
train.index <- createDataPartition(spam$type, p=0.5, list=F)
spam.train <- spam[train.index,]
spam.test <- spam[-train.index,]

# トレーニング設定
fitControl <- trainControl(method="LGOCV",
                           p=0.75,
                           number=5)

# XGBoost
spam.xgb <- train(spam.train[,-58], spam.train$type,
                  method="xgbTree",
                  preProcess=c("center", "scale"),
                  trControl=fitControl)

# モデルの評価
allPred <- extractPrediction(list(spam.xgb),
                             testX = spam.test[,-58], testY = spam.test$type)

testPred <- allPred[allPred$dataType=="Test",]
tp.xgb <- testPred[testPred$model=="xgbTree",]

confusionMatrix(tp.xgb$pred, tp.xgb$obs)
