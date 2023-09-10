# データ読み込み
library(ggplot2)
data(state)
head(state.x77)

# k-meansの実行
state.km <- kmeans(state.x77[,1:6], 3)

# 主成分分析の結果にクラスターの情報を付加
state.pca.df <- data.frame(state.pca$x)
state.pca.df$name <- rownames(state.pca.df)
state.pca.df$cluster <- as.factor(state.km$cluster)

# 描画
ggplot(state.pca.df, aes(x=PC1, y=PC2, label=name, col=cluster)) +
  geom_text() +
  theme_bw(16)

# レーダーチャートの作成
install.packages("fmsb")
library(fmsb)

df <- as.data.frame(scale(state.km$centers))
dfmax <- apply(df, 2, max)+1
dfmin <- apply(df, 2, min)-1
df <- rbind(dfmax,dfmin,df)

radarchart(df, seg=5, plty=1,pcol=rainbow(3))
legend("topright", legend=1:3,col=rainbow(3),lty=1)
