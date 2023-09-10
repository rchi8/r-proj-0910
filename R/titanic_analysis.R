library(ggplot2)

z <- data.frame(Titanic)
titanic.data <- data.frame(
  Class=rep(z$Class, z$Freq),
  Sex=rep(z$Sex, z$Freq),
  Age=rep(z$Age, z$Freq),
  Survived=rep(z$Survived, z$Freq)
)



head(titanic.data)

head(z)


# モデル構築

# titanic.logit <- glm("Survived", data=titanic.data, family=binomial)
titanic.logit <- glm(Survived ~ Class + Sex + Age, data=titanic.data, family=binomial)
summary(titanic.logit)

# install.packages("epiDisplay")
library(epiDisplay)
logistic.display(titanic.logit, simplified=T)

library(rpart)

# install.packages("party")

# rpartパッケージをロード
library(rpart)

# rpartで決定木モデルを構築
titanic.rp <- rpart(Survived ~ Class + Sex + Age, data=titanic.data)

# 決定木をプロット
plot(titanic.rp)
text(titanic.rp)


data(state)

state.pca <- prcomp(state.x77[, 1:6], scale=T)
biplot(state.pca)


