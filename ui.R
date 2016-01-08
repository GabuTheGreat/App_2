shinyUI(fluidPage(theme = "bootstrap.css",
                  
                  titlePanel("SENTIMENT ANALYSIS FACEBOOK"),
                  
                  sidebarLayout(
                    
                    sidebarPanel(
                      
                      numericInput("posts", "Number of Posts to Pull:", 100),
                      
                      textInput("group_keyword", label = h5("Group Search (Key Word)"), 
                                value = "Raila"),
                      
                      textInput("page_keyword", label = h5("Page Search (Key Word)"), 
                                value = "Uhuru"),
                      
                      helpText("Enter keyWord to identify groups and pages Related to it"),
                      
                      numericInput("groupNumeric_id", "Enter Group ID:", 137443116349366),
                      
                      numericInput("pageNumeric_id", "Enter Page ID:", 148874415141120),
                      
                      actionButton("submit", "SUBMIT")
                    ),
                    
                    mainPanel(
                      tabsetPanel(
                        tabPanel("Groups Found", tableOutput("group_table")), 
                        tabPanel("Pages Found", tableOutput("page_table")),
                        tabPanel("Wordcloud Group", plotOutput("group_plot")),
                        tabPanel("Wordcloud Page", plotOutput("page_plot"))
                      )
                    )
                  )
))