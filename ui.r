#File "ui.r"
#setwd("C:\\Users\\EduRDO\\Desktop\\Coursera\\EspecializaÃ§Ã£o Ciencia de Dados\\9 - Developing Data Products\\CourseProject\\Versao3\\")
#Available at: http://dualvim.shinyapps.io/Versao3/
library(markdown)

shinyUI(
    fluidPage(
        titlePanel("Documentation"),
        fluidRow(column(12,includeMarkdown("documentation.md"))),
    pageWithSidebar(
    headerPanel("Two-Asset Portfolios & Efficient Portfolios"),
    sidebarPanel(
        #Numeric Inputs (expected return, expected volatility and correlation)
        sliderInput("Ret1", "Expected Return of Stock 1", 0, min = -0.25, max = 0.25, step = 0.001),
        sliderInput("Ret2", "Expected Return of Stock 2", 0, min = -0.25, max = 0.25, step = 0.001),
        sliderInput("Vol1", "Expected Volatility of Stock 1", 0, min = 0, max = 0.25, step = 0.001),
        sliderInput("Vol2", "Expected Volatility of Stock 2", 0, min = 0, max = 0.25, step = 0.001),
        sliderInput("Cor", "Correlation of the returns of the two stocks", 0, min = -1, max = 1, step = 0.01),
        sliderInput("rf", "Return of the Risk-Free Asset", 0, min = 0, max = 0.25, step = 0.001)

    ),
    
    mainPanel(
        h3("Output Plot"),
        plotOutput("newGraph"),
        h4("Minimum Return"),
        verbatimTextOutput('minRet'),
        h4("Maximum Return"),
        verbatimTextOutput('maxRet'),
        h4("Smallest Volatility"),
        verbatimTextOutput('minSD'),
        h4("Biggest Volatility"),
        verbatimTextOutput('maxSD'),
        h4("Covariation of the returns of the 2 stocks"),
        verbatimTextOutput('Covar'),
        h4("Correlation of the returns of the 2 stocks"),
        verbatimTextOutput('corel')
        )
    )
))
