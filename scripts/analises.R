#library(tidyverse)
library(readxl)
library(writexl)

# Carregando a base de dados
dados <- read_excel("Base_Categorizada.xlsx") # Carregando a base de dados

# Criando um data frame para as medidas
resumo <- data.frame(
  variavel = c("idade","tempo_preso","score_periculosidade"),
  media = c(
    mean(dados$idade, na.rm=TRUE),
    mean(dados$tempo_preso, na.rm=TRUE),
    mean(dados$score_periculosidade, na.rm=TRUE)
  ),
  q1 = c(
    quantile(dados$idade, 0.25, na.rm=TRUE),
    quantile(dados$tempo_preso, 0.25, na.rm=TRUE),
    quantile(dados$score_periculosidade, 0.25, na.rm=TRUE)
  ),
  mediana = c(
    median(dados$idade, na.rm=TRUE),
    median(dados$tempo_preso, na.rm=TRUE),
    median(dados$score_periculosidade, na.rm=TRUE)
  ),
  q3 = c(
    quantile(dados$idade, 0.75, na.rm=TRUE),
    quantile(dados$tempo_preso, 0.75, na.rm=TRUE),
    quantile(dados$score_periculosidade, 0.75, na.rm=TRUE)
  ),
  variancia = c(
    var(dados$idade, na.rm=TRUE),
    var(dados$tempo_preso, na.rm=TRUE),
    var(dados$score_periculosidade, na.rm=TRUE)
  ),
  desvio = c(
    sd(dados$idade, na.rm=TRUE),
    sd(dados$tempo_preso, na.rm=TRUE),
    sd(dados$score_periculosidade, na.rm=TRUE)
  ),
  amplitude = c(
    max(dados$idade, na.rm=TRUE) - min(dados$idade, na.rm=TRUE),
    max(dados$tempo_preso, na.rm=TRUE) - min(dados$tempo_preso, na.rm=TRUE),
    max(dados$score_periculosidade, na.rm=TRUE) - min(dados$score_periculosidade, na.rm=TRUE)
  )
)

write.csv(resumo, "figuras/tabela_resumo_completa.csv", row.names=FALSE)

# Gráfico de Dispersão
g5 <- ggplot(dados, aes(x = tempo_preso, y = score_periculosidade)) +
  geom_point(alpha = 0.6, size = 1.7, color = "#10B981") +
  geom_smooth(method = "lm", se = FALSE, color = "grey40", linetype = "dashed") + 
  labs(x = "Tempo preso (meses)", y = "Score de periculosidade") +
  theme_minimal(base_size = 12)

ggsave("figuras/disp_tempo_vs_periculosidade.png", g5, width = 12, height = 6.75, dpi = 300, bg = "white")

# Correlação de Pearson
cor(dados$tempo_preso, dados$score_periculosidade)