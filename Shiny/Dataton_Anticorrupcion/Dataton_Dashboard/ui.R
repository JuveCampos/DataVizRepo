#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(dashboardPage(skin = "green",

  # HEADER
  dashboardHeader(title = "Datatón Anticorrupción"),
  
  # SIDEBAR
  dashboardSidebar(sidebarMenu(
    menuItem("Introducción", tabName = "tabIntroduccion"),
    menuItem("Tiempo Real", tabName = "tabTiempoReal"), 
    menuItem("Noticias", tabName = "tabNoticias")
    
  )),
  
  # BODY
  dashboardBody(
  #####################################
  # Estilo y colores del contenido!!! #
  ####################################
  tags$head(tags$style(
    HTML("@import url('https://fonts.googleapis.com/css?family=Karla|Source+Serif+Pro|Ultra');
         .content-wrapper {
         background-color: white !important;}
         label, input, button, select { 
         font-family: 'Karla', sans-serif;
         font-color = #606060;
         font-size: 14pt;
         }
         
         body {
         background-color: white;
         style= width: 80%;
         }
         p {
         text-indent: 0px;
         font-family: 'Karla', sans-serif;
         font-size: 12pt;
         color: #606060;
         text-align:justify;
         padding-top: 5px;
         padding-botton: 10px;
         padding-right:190px;
         padding-left:70px;
         
         }
         .main-header .logo {
         font-family: 'Ultra', serif;
         font-size: 28px;
         background-color:white;
         padding-top:0px; 
         padding-bottom:0px;
         }
         
         .main-sidebar {
         background-color: black !important;
         }
         
         
         .container {
         position: relative;
         width: 50%;
         }
         
         .image {
         opacity: 1;
         display: block;
         width: 100%;
         height: auto;
         transition: .5s ease;
         backface-visibility: hidden;
         }
         
         .middle {
         transition: .5s ease;
         opacity: 0;
         position: absolute;
         top: 50%;
         left: 50%;
         transform: translate(-50%, -50%);
         -ms-transform: translate(-50%, -50%)
         }
         
         .container:hover .image {
         opacity: 0.3;
         }
         
         .container:hover .middle {
         opacity: 1;
         }
         
         .text {
         background-color: black;
         color: white;
         font-size: 14px;
         padding: 16px 32px;
         }
         
         .box.box-solid.box-primary>.box-header {
         color:#606060;
         background:white;
         background-color:#f0f0f5;
         font-family: 'Karla', sans-serif;
         text-align:center;
         }
         
         .box.box-solid.box-warning>.box-header {
         color:#606060;
         background:white;
         background-color:#f0f0f5;
         font-family: 'Karla', sans-serif;
         text-align:center;
         }
         
         .box.box-solid.box-primary {
         color:#606060;
         background-color:white;
         border-color:white !important;
         }
         
         .box.box-solid.box-warning {
         color:#606060;
         background-color:white;
         border-color:white;
         }
         
         li {
         font-family: 'Karla', sans-serif;                    
         font-size: 16px;
         margin-top: 15px;
         padding-top: 0px;
         padding-botton: 0px;
         border:1px;
         line-height: 1.7;
         font-color:#606060;
         
         }
         li span {
         font-family: 'Karla', sans-serif;
         font-size: 15px;
         font-color:#606060;
         
         }
         ul {
         list-style-type: none;
         }
         
         h2 {
         font-family:'Ultra', serif;
         font-weight: 500;
         line-height: 1.1;
         color: 	#000000;
         font-size: 22pt;
         text-align:center;
         padding-right:190px;
         padding-left:70px;
         }

  
         h1 {
         font-family:'Ultra', serif;
         font-weight: 800;
         line-height: 1.1;
         color: 	#000000;
         font-size: 28pt;
         #text-align:left;
         #padding-right:190px;
         #padding-left:70px;
         }

         "))
    ), 
  
  
  tabItems(
    tabItem("tabIntroduccion", 
            h1("Datatón Anticorrupción 2018"),
            h2("Introducción"),
            p("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,")
      ), # Fin del tabIntroduccion
  tabItem("tabTiempoReal", 
          h1("Detección de Anomalías en CompraNET en tiempo real"), 
          p("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,"),
          h2("Dummy Elements"), br(), br(),
          # Dummy Code #
          fluidRow(
            box(
              title = "Box title", width = 6, status = "success",
              "Box content"
            ),
            box(
              status = "warning", width = 6,
              "Box content"
            )
          ),
          
          fluidRow(
            column(width = 4,
                   box(
                     title = "Title 1", width = NULL, solidHeader = TRUE, status = "success",
                     "Box content"
                   ),
                   box(
                     width = NULL, background = "black",
                     "A box with a solid black background"
                   )
            ),
            column(width = 4,
                   box(
                     title = "Title 3", width = NULL, solidHeader = TRUE, status = "success",
                     "Box content"
                   ),
                   box(
                     title = "Title 5", width = NULL, background = "light-blue",
                     "A box with a solid light-blue background"
                   )
            ),
            column(width = 4,
                   box(
                     title = "Title 2", width = NULL, solidHeader = TRUE,
                     "Box content"
                   ),
                   box(
                     title = "Title 6", width = NULL, background = "green",
                     "A box with a solid green background"
                   )
            )
          )
  
          
          
          
          
          ), 
  tabItem("tabNoticias", 
          h1("Monitoreo de corrupción en medios de comunicación"), 
          p("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,")
          )
      )
    )
  )
) # fin del ShinyUI


