CourseProject_DevelopingDataProducts_Coursera
=============================================

Source Codes from the apps created in the course project of the "Developing data products course", from Coursera.

#Documentation of the aplication:

# Couse Project of 'Developing Data Products' - "Two-Asset Portfolios & Efficient Portfolios"  

## About the Application:  
This application is intended to be used studying finance, more specifically in the subject of portfolio theory.  

This application do the following things:  

 1. Plot in the graph the feasible portfolios of two assets;  
 2. Plot the efficient portfolios in the graph;  
 3. Marks the minimum variance portfolio, the tangency portfolio and the individual risk and return of each stock;  
 4. Plot the line with the efficient portfolios, that is, x1% invested in the risk-free asset and x2% invested in the tangency portfolio (remember thar $x1+x2=1$);  
 5. Present, in the bottom of the user interface (ui), the minimum and maximum return and volatility, and the covariance and the correlation.  

## Input Variables:  
This application has six input variables, which are controled using sliders. Below the six input variables are described in detail.  

 1. **E(Stock1)**: It's the expected return of stock1; the values range from -0.25 to +0.25, in steps of 0.001.  
 2. **E(Stock2)**: It's the expected return of stock2; the values range from -0.25 to +0.25, in steps of 0.001.  
 3. **\sigma(stock1)**: It's the expected volatility of stock1; the values range from 0 to 0.25, in steps of 0.001.  
 4. **\sigma(stock2)**: It's the expected volatility of stock2; the values range from 0 to 0.25, in steps of 0.001.  
 5. **\ro(ret(Stock1),ret(Stock2))**: Is the correlation between the returns of stock1 and stock 2. The values range from -1 to 1, in steps of 0.01.  
 6. **Rf**: It's the return of the risk-free asset. The values range from 0 to 0.25, in steps of 0.001.  

## Output Variables:  
In the bottom of the user interface, UI, there are 6 output values: "Minimum Return", "Maximum Return", "Smallest Volatility", "Biggest Vollatility", "Covariation of the stocks' returns" and "correlation of the stock returns".  

The main characteristic of these 6 values is that the first five come from reactive variables, that is, when the inputs are changed, these variables change imediatelly. The 5 reactive values are taken from 3 reactive variables, calculated in the "server.r" file: "R_PortRet" (Return of the portfolio), "R_covar" (Covariance between the two stocks' returns) and "R_PortSD" (Portfolio's Volatility).  

The formula of the portifolio's expected returns are simply: $Weight_Stock1*E(Stock1)+Weight_Stock2*E(Stock2)$, that is, it is the sum of the multiplications percentage of each stock in the portifolio and the expected returns of the stock.  

The formula of the covariance is $\ro(ret(Stock1),ret(Stock2))*\sigma(stock1)*\sigma(stock2)$.  

The formula of the portifolio's volatility is $\sqrt((X1^2)*(\sigma(Stock1)^2)+(X2^2)*(\sigma(Stock2)^2))+2*Cov(Stock1,Stock2)*\sigma(Stock1)*\sigma(Stock2)$. The main point on this formula is that the volatility of a portifolio will also depend on the correalation os the assets in it. If the two assets are positive correlated, usually the combination of both assets will not decrease the risk so much as two negatively correlated assets would.  

## Output plot:  
### Feasible and efficient portifolios.  
This section explain the main component of the application: the output plot. The curve in this plot represents all the possible portifolios which combine the assets "Stock1" and "Stok2". Note that all the portifolios with returns below of the one observed in the minumum variance portifolio aren't efficient, because there are portifolios which offers a higher level of  returns whith the same level of risk. So the "inefficient portifolios" are marked in Red in the plot.  

The portifolios which offers retuns above the return of the portifolio of minimum variance are marked in green. These portifolios are considered efficient because the offer the highestlevel of returns at any given level of risk.  

In the curve of portifolios there four points over it. First there are the blue asteriscs, which represents the portfolios composed with only one of the two stocks. Note that these points are exactly over the level of risk and return of the stock.  

The second point, marked by an orange star, represents the portifolio of minimum variance, which is the portifolio which has the lowest volatility.  

Finally, the pink square on the curve represents the "tangency portifolio", this portifolio is the one which presents the highest **Sharpe Ratio**. The formula of the Sharpe ratio is $\frac{E(Rport)-Rf}{\sigma(R(port))}$. That is, the Sharpe ratio is the risk premium of investing in risk assets (Return of the portfolio minus the return of the risk-free asset) for each risk unit.  

**The black line wich crosses this point in the CML (Capital Market Line), and each point of this line represents an investiment of x1% in the risk free asset and x2% in the tangency portfolio**.  

The point of the CML wich crosses de Y-axis is the point where the investor invests all the available wealth in the risk-free asset, while the pink square represents the point where the investor put all the available wealth in the tangency portfolio.  

A point in the line after the tangency portfolio represents the hipothesys where the investor "borrows" money from the market, at the risk-free rate, and invests the borrowed money in the tangency portifolio.  


