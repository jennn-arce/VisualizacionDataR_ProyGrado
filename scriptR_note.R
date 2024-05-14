# if (!require("readr")) {
#   install.packages("readr")
# }
# library(readr)

# # Cargar el archivo CSV
# data <- read_csv("publicidadVentas.csv")

# # Visualizar las primeras filas de los datos
# head(data)

# # Resumen estadístico de las variables numéricas
# summary(data)

# # Si necesitas más información sobre las columnas específicas, por ejemplo, si quieres conocer los tipos de datos,
# # puedes usar la función str(data)
# str(data)

# # Instalé shiny y ggplot2
# if (!require("shiny")) {
#   install.packages("shiny")
# }
# if (!require("ggplot2")) {
#   install.packages("ggplot2")
# }
# library(shiny)
# library(ggplot2)

# # Interfaz
# ui <- fluidPage(
#   titlePanel("Gráfico por año"),
#   sidebarLayout(
#     sidebarPanel(
#       # opciones de input
#       selectInput("variable", "Selecciona una variable:",
#                   choices = c("publicidad", "ventas", "kw")),
#     ),
#     mainPanel(
#       plotOutput("plot")
#     )
#   )
# )

# # Función de un server en la app de Shiny
# server <- function(input, output) {
#   output$plot <- renderPlot({
    
#     #PLOT
#     ggplot(data, aes_string(x = "y", y = input$variable)) +
#       geom_bar( fun = sum, fill = "blue") +
#       labs(x = "Año", y = input$variable)
#   })
# }

# # Crea la aplicación Shiny
# shinyApp(ui = ui, server = server)


# Comentarios

# Instala los paquetes necesarios si no están instalados
if (!require("shiny")) {   # Verifica si el paquete "shiny" está instalado
  install.packages("shiny")   # Si no está instalado, lo instala
}
if (!require("ggplot2")) {   # Verifica si el paquete "ggplot2" está instalado
  install.packages("ggplot2")   # Si no está instalado, lo instala
}

if (!require("readr")) {
  install.packages("readr")
}
# Carga el paquete readr
library(readr)
library(shiny)   # Carga el paquete "shiny"
library(ggplot2)   # Carga el paquete "ggplot2"

# Cargar la base de datos
data <- read_csv("publicidadVentas.csv")

# Define la interfaz de usuario
ui <- fluidPage(   # Define la apariencia de la página
  titlePanel("Total de ventas o publicidad por año"),   # Título de la página
  sidebarLayout(   # Define un diseño con un panel lateral y un panel principal
    sidebarPanel(   # Define el panel lateral
      selectInput("variable", "Seleccione una variable:",   # Crea un menú desplegable llamado "variable"
                  choices = c("ventas", "publicidad", "kw"))   # Opciones del menú desplegable
    ),
    mainPanel(   # Define el panel principal
      plotOutput("plot")   # Crea un espacio para mostrar el gráfico generado
    )
  )
)

# Define la función del servidor
server <- function(input, output) {   # Define la lógica del servidor
  # Función para crear el gráfico
  output$plot <- renderPlot({   # Crea un gráfico de acuerdo a los parámetros dados
    ggplot(data, aes_string(x = "y", y = input$variable)) +   # Crea un gráfico con ggplot2
      geom_bar(stat = "summary", fun = sum, fill = "blue") +   # Agrega barras al gráfico
      labs(x = "Año", y = "Total", fill = "Variable") +   # Etiqueta los ejes x e y y la leyenda de colores
      ggtitle(paste("Total de", input$variable, "por año")) +   # Agrega un título al gráfico
      theme_minimal()   # Aplica un tema minimalista al gráfico
  })
}

# Crea la aplicación Shiny
shinyApp(ui = ui, server = server)   # Crea una aplicación Shiny con la interfaz de usuario y la función del servidor definidas anteriormente


# Gráfica scatter: publicidad vs ventas

# Aplicar logaritmo natural a las columnas de publicidad y ventas
data$log_publicidad <- log(data$publicidad)
data$log_ventas <- log(data$ventas)

# Interfaz
ui1 <- fluidPage(
  titlePanel("Scatter Plot de Log(Publicidad) vs. Log(Ventas)"),
    sidebarLayout(
    sidebarPanel(
      # Selector de año
      selectInput("year", "Selecciona un año:",
                  choices = unique(data$y))
    ),
  mainPanel(
    plotOutput("scatterplot")
  )
)

# Función del servidor
server_2 <- function(input, output) { # nolint
  output$scatterplot <- renderPlot({
    # Filtrar los datos por el año seleccionado
    filtered_data <- subset(data, y == input$year)
    
    # Crear el scatter plot
    ggplot(filtered_data, aes(x = log(publicidad), y = log(ventas))) +
      geom_point() +
      labs(x = "Log(Publicidad)", y = "Log(Ventas)") +
      ggtitle(paste("Scatter Log(Publicidad) vs. Log(Ventas) para el Año", input$year))
  })
}

# Crea la aplicación Shiny
shinyApp(ui = ui1, server = server_2)
