# ggplot2パッケージのインストールとインポート
# install.packages("ggplot2")
library(ggplot2)

# データの読み込み

body_sample_tsv = "data/body_sample.tsv"
body_sample_csv = "data/body_sample.csv"

#body.data <- read.table(body_sample_tsv, header=T, stringsAsFactors=F)
body.data <- read.csv(body_sample_csv, header=T, stringsAsFactors=F)

# データフレームの基本操作

body.data[,2]
body.data[,4]

body.data[, c(1,3)]

body.data[,"IQ"]
body.data$IQ

body.data[, c("Age", "IQ")]

body.data[body.data$Gender=="Female",]
body.data[order(body.data$Height_cm),]
body.data[order(body.data$Height_cm, decreasing=T),]

# 文字列を因子とする
body.data$Gender <- factor(body.data$Gender)


summary(body.data)

sd(body.data$Height_cm)
var(body.data$Weight_kg)

# データ可視化の基本

# ヒストグラム
#ggplot(body.data, aes(x=Height_cm)) +
#    geom_histogram() +
#theme_bw(16) +
#ylab("count")

# 男女色分け
ggplot(body.data, aes(x=Height_cm, fill=Gender)) +
  geom_histogram() +
  theme_bw(16) +
  ylab("count")

ggplot(body.data, aes(x=Gender, y=Height_cm, fill=Gender)) +
  geom_boxplot() +
  theme_bw(16)

ggplot(body.data, aes(x=Height_cm, y=Weight_kg)) +
  geom_point()
theme_bw(16)

ggplot(body.data, aes(x=Height_cm, y=Weight_kg)) +
  geom_point() +
  theme_bw(16) +
  geom_smooth(method="lm")

ggplot(body.data, aes(x=Height_cm, y=Weight_kg, col=Gender)) +
  geom_point() +
  theme_bw(16) +
  geom_smooth(method="lm")

cor(body.data$Height_cm, body.data$Weight_kg)

# 男性
body.data.m <- body.data[body.data$Gender=="Male",]
cor(body.data.m$Height_cm, body.data.m$Weight_kg)


# 女性
body.data.f <- body.data[body.data$Gender=="Female",]
cor(body.data.f$Height_cm, body.data.f$Weight_kg)



