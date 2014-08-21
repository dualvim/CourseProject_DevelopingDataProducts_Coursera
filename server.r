#File "server.r"
#setwd("C:\\Users\\EduRDO\\Desktop\\Coursera\\EspecializaÃ§Ã£o Ciencia de Dados\\9 - Developing Data Products\\CourseProject\\Versao3\\")
#DisponÃ­vel em: http://dualvim.shinyapps.io/Versao3/
library(shiny)

#Function used to get the matrix with the weight of the assets
RetMatWeights <- function(){
    #Weight of each stock in the portfolios
    w1 <<- seq(0,1,by=0.01)
    w2 <<- (1-w1)
    w1a<<-seq(-0.5,1.5,by=0.01)
    w2a<<- (1-w1a)
    matWeights <<- data.frame(w1,w2)
    names(matWeights)<-c("w1","w2")
}
RetMatWeights()

shinyServer(
    
    function(input, output){
        matWeights <- as.matrix(matWeights)
        
        #Objects whose name starts with "R_" means reactive objects
        R_PortRet<-reactive({as.numeric(input$Ret1)*matWeights[,1]+as.numeric(input$Ret2)*matWeights[,2]})
        R_covar<-reactive({input$Cor*(input$Vol1*input$Vol2)})
        R_portSD<-reactive({sqrt((w1^2)*(input$Vol1^2)+(w2^2)*(input$Vol2^2)+(2*w1*w2*R_covar()))})
        
        #Outputs
        output$maxRet <- renderPrint({max(R_PortRet())})
        output$minRet <- renderPrint({min(R_PortRet())})
        output$maxSD <- renderPrint({max(R_portSD())})
        output$minSD <- renderPrint({min(R_portSD())})
        output$Covar <- renderPrint({R_covar()})
        output$corel <- renderPrint({input$Cor})
        
        #Plot the Main Graph
        output$newGraph <-renderPlot({
            
            #Returns and volatility of the portfolios
            ret<-w1*input$Ret1 + w2*input$Ret2
            covar <- input$Cor*(input$Vol1*input$Vol2)
            StdDev<-sqrt((w1^2)*(input$Vol1^2)+(w2^2)*(input$Vol2^2)+(2*w1*w2*covar))
            
            #Dataset with all feasible portfolios
            port<-data.frame(w1,w2,ret,StdDev)
            names(port)<-c("w1","w2","ret","StdDev")
            #Add the sharpe index variable to the dataset
            port$SI<-(port$ret-input$rf)/port$StdDev
            
            #Dataset with the portfolios of the efficient frontier
            port2<-port[port$ret>=port[port$StdDev== min(port$StdDev),]$ret,]
            
            #Dataset with only the minimum variance portfolio
            minVar<-min(port$StdDev)
            minVarPort<-port[port$StdDev==minVar,]
            #x<-reactive({as.numeric(minVarPort$ret)+0})
            
            #Dataset whith the return and SD os the individual stocks
            stocks<-data.frame(c(input$Ret1,input$Ret2),c(input$Vol1,input$Vol2))
            names(stocks)<-c("ret","StdDev")
            
            #dataset with the data of the tangency portfolio
            maxSI<-max(port$SI)
            maxSIds<-port[(port$SI==maxSI),]
            
            #Plot all the feasible portfolios
            plot(x=port$StdDev,y=port$ret,pch=20,col="red", type="b",ylim=c(min(0,min(ret)-0.01),max(ret)+0.02),xlim=c(0,max(StdDev)+0.02),main = "Feasible and Efficient Portfolios", xlab="Portifolio Volatility", ylab="E(Port.Return)")
            abline(h=0,v=0)
            
            #Plot the Minimum variance Portfolio
            points(x=minVarPort$StdDev,y=minVarPort$ret,pch=11,col="orange",cex=2)
            
            #Plot the efficient Portfolios
            points(x=port2$StdDev,y=port2$ret,col="green", type="o",pch=19)
            
            #plot the return and SD of the individual stocks
            points(x=stocks$StdDev,y=stocks$ret,pch=8,col="blue",cex=2)
            text(stocks$StdDev[1],stocks$ret[1],"Stock1",pos=1)
            text(stocks$StdDev[2],stocks$ret[2],"Stock2",pos=1)
            
            #plot the tangency portfolio
            points(maxSIds$StdDev,maxSIds$ret,pch=15,col="pink",cex=2)
            legend("topleft", pch=c(20,11,19,15), col=c("red","orange","green","pink"), legend=c("Feasible", "Min.Var","Efficient","Tangency"))
            
            #Line of the combination of risk free and risky asset
            #return and volatility of each efficient portfolio
            ret<-w1a*input$rf + w2a*maxSIds$ret[1]
            StdDev<-w2a*maxSIds$StdDev[1]
            #Plot the line of efficient portfolios
            lines(StdDev,ret,lty=1,lwd=2)
        })
    }
)
