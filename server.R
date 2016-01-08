shinyServer(function(input, output) {
  ##Searching group that mention "Keyword"
  #*If the group is closed you cannot pull posts from it
  
            groupSearch_results <- reactive({
    
    
                    keyword_group = input$group_keyword
                    group_id <- searchGroup(name=keyword_group, token=fb_oauth)
  
            })
            pageSearch_results <- reactive({
    
    
                    keyword_page = input$page_keyword
                    page_id <- searchPages(string = keyword_page, token=fb_oauth)
    
            })
            
            page_analysis <- reactive({ 
              
              page_id = input$pageNumeric_id
              page <- getPage(page=page_id, token=fb_oauth, feed=TRUE, n = input$posts)
              getTerm_Matrix(page)      
               })
            
            group_analysis <- reactive({ 
              
              groupId = input$groupNumeric_id
              group <- getGroup(group_id = groupId, token=fb_oauth, n = input$posts)
              getTerm_Matrix(group) 
            })
            
            output$group_table <- renderTable({
              table_group = groupSearch_results()
              
            })
            output$page_table <- renderTable({
              table_page = pageSearch_results()
              
            })
            
        
             output$page_plot <- renderPlot({
               
                  d = page_analysis()
                  #Generate the Word cloud
                  set.seed(1234)
                  wordcloud(words = d$word, freq = d$freq, min.freq = 1,
                            max.words=200, random.order=FALSE, rot.per=0.35, 
                            colors=brewer.pal(8, "Dark2"))
                  
                 })
                
                output$group_plot <- renderPlot({
                  d = group_analysis()
                  #Generate the Word cloud
                  set.seed(1234)
                  wordcloud(words = d$word, freq = d$freq, min.freq = 1,
                            max.words=200, random.order=FALSE, rot.per=0.35, 
                            colors=brewer.pal(8, "Dark2"))
                  
                })
                
})
            
           