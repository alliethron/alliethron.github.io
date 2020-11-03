
library(shiny)
library(readr)

library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)
library(ggthemes)
library(shiny)
library(rsconnect)

library(readr)
data <- read_csv("fatal-police-shootings-data.csv") %>%
    drop_na(armed, race, age, gender, date) %>%
    mutate(
        gender=gsub('M', 'Male', gender)
    ) %>%
    mutate(
        gender=gsub('F', 'Female', gender),
        race = gsub('B', 'Black', race),
        race=gsub('H', 'Hispanic', race),
        race=gsub('W', 'White', race),
        race=gsub('A', 'Asian', race),
        race=gsub('N', 'Native American', race),
        race=gsub('O', 'Other', race),
        ageRange = ifelse(age > 25 & age < 50, "Between 25 and 50", ifelse(age <= 25, "Under 25", "Over 50")),
        date=gsub('.{3}$', '', date),
        numericDate = as.numeric(gsub('-', '',date)),
        
        year=gsub('.{3}$', '', date)
        
    ) 
total=nrow(data)

save(data, file="police.RDATA")

Spring = c('palegreen', 'pink1', 'springgreen3', 'tan1', 'yellow', 'orchid1', 'lightskyblue1')
Summer= c('turquoise1', 'khaki1', 'coral1', 'firebrick1', 'chartreuse', 'yellow1', 'pink')
Winter = c('royalblue2', 'steelblue2', 'slategray2', 'plum1', 'lightcyan2', 'seashell4', 'snow2')
Fall= c('orangered4', 'sienna3', 'tan1', 'gold', 'indianred', 'darkolivegreen4', 'snow2')
myColors=list(Spring=Spring,Summer= Summer,Winter= Winter,Fall= Fall)



strip = theme_minimal()+
    theme(
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.border = element_blank(),
        panel.grid=element_blank(),
        axis.ticks = element_blank(),
        plot.title=element_text(size=11, face="bold"),
        axis.text = element_blank()
    )


ui= fluidPage(
    titlePanel('Fatal Police Shootings At a Glance'),
    
    
    
    tabsetPanel(id='tabA', type="tabs",
                tabPanel('Victim Count',
                         
                         sidebarLayout(
                             sidebarPanel(
                                 
                                 selectInput('st', 'Select a State', choices=c('All', unique(data$state)), selected="All"),
                                 selectInput('yage', 'Select an age range', choices=c('All', unique(data$ageRange)), selected="All"),
                                 selectInput('season', 'Select a color scheme', choices=names(myColors), selected="Winter")
                             ),
                             
                             
                             mainPanel( plotOutput('deaths')) 
                         )),
                
                
                
                
                
                tabPanel( '% by Race', plotOutput('pieChart' )),
                tabPanel( '% by Age', plotOutput('pieChart2')),
                tabPanel( '% by Gender', plotOutput('pieChart3'))     
                
    )
)






server=function(input, output) {
    
    
    
    output$pieChart = renderPlot( {
        
        data %>%
            group_by(race)%>%
            
            summarise(
                raceCount = n(),
                
                raceProp = raceCount/total
                
            ) %>%
            
            ggplot(aes(x="", y=raceProp, fill=race)) +
            
            scale_fill_manual(values=myColors[[input$season]]) +
            strip +
            geom_bar(width=1, stat="identity") +
            coord_polar("y", start=0) +
            labs(
                fill="Race",
                title="Percent of all shootings by victim's race"
                
            ) +theme(plot.title=element_text(size=18),
                     legend.background = element_rect(size=0.4, color='black'))
        
        
    })
    
    
    output$pieChart2 = renderPlot( {
        
        data  %>%
            group_by(ageRange)%>%
            
            summarise(
                ageCount = n(),
                
                ageProp = ageCount/total
                
            ) %>%
            
            ggplot( aes(x="", y=ageProp, fill=ageRange)) +
            
            scale_fill_manual(values=myColors[[input$season]]) +
            strip +
            geom_bar(width=1, stat="identity") +
            coord_polar("y", start=0) +
            labs(
                fill="Age Range",
                title="Percent of all shootings by victim's age"
                
            ) + theme(plot.title=element_text(size=18),
                      legend.background = element_rect(size=0.4, color='black'))
    })
    
    output$pieChart3 = renderPlot( {
        
        data  %>%
            group_by(gender)%>%
            
            summarise(
                genderCount = n(),
                
                genderProp = genderCount/total
                
            ) %>%
            
            ggplot( aes(x="", y=genderProp, fill=gender)) +
            
            scale_fill_manual(values=myColors[[input$season]]) +
            strip +
            geom_bar(width=1, stat="identity") +
            coord_polar("y", start=0) +
            labs(
                fill="Gender",
                title="Percent of all shootings by victim's gender"
                
            )+ theme(plot.title=element_text(size=18),
                     legend.background = element_rect(size=0.4, color='black'))
        
        
        
        
        
    })        
    
    plotData <- reactive({
        rows = TRUE
        
        if(input$st != 'All'){rows = rows & data$state == input$st}
        if(input$yage != 'All'){rows = rows & data$ageRange == input$yage}
        
        data[rows, ] %>%
            group_by(year, race) %>%
            summarise(
                numba = n()
            ) 
        
        
        
        
        
        
    })
    
    
    
    output$deaths = renderPlot({    
        
        ggplot(plotData(), aes(x=year, y= numba, fill=race))+
            geom_col()+
            scale_fill_manual(values =myColors[[input$season]]) +
            labs(x="Year", y="Number of Shootings", title="Yearly Victim Count",
                 fill="Race")+
            theme(
                axis.title = element_text(face="bold", size=15),
                axis.text = element_text(size=9, face="bold"),
                plot.title = element_text(face="bold"),
                panel.background = element_blank(),
                legend.background = element_rect(size=0.4, color='black'),
                panel.border  = element_rect(color='black', fill=NA, size=0.6)
            )
        
        
        
        
        
    })
    
    
    
    
}










shinyApp(ui=ui,server= server)  





