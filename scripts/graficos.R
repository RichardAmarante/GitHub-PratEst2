library(tidyverse)
library(readxl)
library(writexl)

# Carregando a base de dados
dados <- read_excel("Base_trabalho.xlsx") # Carregando a base de dados
str(dados) # Verificando como estão organizadas as variáveis e de que tipo são

# Transformando variáveis qualitativas em fatores
dados$sexo <- factor(dados$sexo, levels = c(0,1), labels = c("Feminino","Masculino")) # Transformando a variável indicadora de sexo em um fator, com as categorias "Feminino" e "Masculino

dados$filhos <- factor(dados$filhos, levels = c(0,1), labels = c("Não","Sim")) # Transformando a variável indicadora de ter filhos em um fator, com as categorias "Não" e "Sim"

dados$casado <- factor(dados$casado, levels = c(0,1), labels = c("Não","Sim")) # Transformando a variável indicadora de ser casado em um fator, com as categorias "Não" e "Sim"

dados$reincidente <- factor(dados$reincidente, levels = c(0,1), labels = c("Não","Sim")) # Transformando a variável indicadora de reincidência em um fator, com as categorias "Não" e "Sim"

dados$escolaridade <- factor(dados$escolaridade, levels = c(1,2,3), labels = c("Fundamental","Médio","Superior")) # Transformando a variável de escolaridade em um fator, com as categorias "Fundamental", "Médio", "Superior"

write_xlsx(dados, "Base_Categorizada.xlsx") # Salvando novo arquivo da base de dados

# Analisando dados faltantes
n_na   <- sapply(dados, function(x) sum(is.na(x))) # Verificar o número de linhas da base com NA
p_na   <- sapply(dados, function(x) mean(is.na(x))) # Verificando a proporção das linhas da base com NA
faltas <- data.frame(n_na = n_na, prop_na = p_na) # Mostrando que não houve nenhuma ocorrência de NA na base

# Gráficos
# Histograma de idade
g1 <- ggplot(dados, aes(x = idade)) +
  geom_histogram(binwidth = 5, fill = "#10B981", color = "white") +
  scale_x_continuous(breaks = seq(20, 99, by = 5)) +
  labs(x = "Idade (anos)", y = "Frequência") +
  theme_minimal(base_size = 12)

ggsave("figuras/hist_idade.png", g1, width = 12, height = 6.75, dpi = 300, bg = "white")

# Boxplot de tempo preso
g2 <- ggplot(dados, aes(x = "", y = tempo_preso)) +
  geom_boxplot(fill = "#10B981") +
  labs(x = NULL, y = "Tempo preso (meses)") +
  theme_minimal(base_size = 12)

ggsave("figuras/boxplot_tempo_preso.png", g2, width = 12, height = 6.75, dpi = 300, bg = "white")

# Boxplot da periculosidade por escolaridade
g3 <- ggplot(dados, aes(x = escolaridade, y = score_periculosidade)) + 
  geom_boxplot(fill = "#10B981") +
  labs(x = "Escolaridade", y = "Score de periculosidade") +
  theme_minimal(base_size = 12)

ggsave("figuras/boxplot_periculosidade_por_escolaridade.png", g3, width = 12, height = 6.75, dpi = 300, bg = "white")

# Barras para reincidência
g4 <- ggplot(dados, aes(x = reincidente)) +
  geom_bar(fill = "#10B981") +
  labs(x = "Reincidência", y = "Frequência") +
  theme_minimal(base_size = 12)

ggsave("figuras/bar_reincidente.png", g4, width = 12, height = 6.75, dpi = 300, bg = "white")
