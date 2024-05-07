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

# Instalé shiny y ggplot2
if (!require("shiny")) {
  install.packages("shiny")
}
if (!require("ggplot2")) {
  install.packages("ggplot2")
}
library(shiny)
library(ggplot2)

# Interfaz
ui <- fluidPage(
  titlePanel("Gráfico por año"),
  sidebarLayout(
    sidebarPanel(
      # opciones de input
      selectInput("variable", "Selecciona una variable:",
                  choices = c("publicidad", "ventas", "kw"))
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Función de un server en la app de Shiny
server <- function(input, output) {
  output$plot <- renderPlot({
    
    #PLOT
    ggplot(data, aes_string(x = "y", y = input$variable)) +
      geom_bar(stat = "summary", fun = sum, fill = "blue") +
      labs(x = "Año", y = input$variable)
  })
}

# Crea la aplicación Shiny
shinyApp(ui = ui, server = server)
