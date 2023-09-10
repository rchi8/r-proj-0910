library(ggplot2)

amount1 <- "data/investment_return_data.csv"
amount1.data <- read.csv(amount1)

head(amount1.data)

summary(amount1.data)

ggplot(amount1.data, aes(x=Investment, y=Return)) +
  geom_point() +
  theme_bw(16)

# 線形回帰モデルの構築

amount1.lm1 <- lm(Investment~Return, data=amount1.data)

summary(amount1.lm1)

plot(amount1.lm1, which=1)