if (!require("readr")) {
  install.packages("readr")
}
library(readr)

# Cargar el archivo CSV
data <- read_csv("publicidadVentas.csv")

# Visualizar las primeras filas de los datos
head(data)

# Resumen estadístico de las variables numéricas
summary(data)

# Si necesitas más información sobre las columnas específicas, por ejemplo, si quieres conocer los tipos de datos,
# puedes usar la función str(data)
str(data)

