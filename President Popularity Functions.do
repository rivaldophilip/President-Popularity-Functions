//Variable setup
set obs 285
gen zeit=tq(1948q1)+_n-1
gen time=tq(1948q1)+_n-1
format %tq time
tsset time
insheet using C:\Users\qzou21\Downloads\EconomicVariables.csv

//Stationarity test by checking the lag that produces the smallest BIC\
//GDP growth
reg gdpgrowth l.gdpgrowth, r
estat ic
reg gdpgrowth l(1/2).gdpgrowth, r
estat ic
reg gdpgrowth l(1/3).gdpgrowth, r
estat ic
reg gdpgrowth l(1/4).gdpgrowth, r
estat ic
reg gdpgrowth l(1/5).gdpgrowth, r
estat ic
reg gdpgrowth l(1/6).gdpgrowth, r
estat ic
dfuller gdpgrowth, reg lag(5)

//Inflation
reg inflation l.inflation, r
estat ic
reg inflation l(1/2).inflation, r
estat ic
reg inflation l(1/3).inflation, r
estat ic
reg inflation l(1/4).inflation, r
estat ic
reg inflation l(1/5).inflation, r
estat ic
reg inflation l(1/6).inflation, r
estat ic
dfuller inflation, reg lag(5)
dfuller inflation, reg lag(5) trend

//Unemployment rate
reg unrate l.unrate, r
estat ic
reg unrate l(1/2).unrate, r
estat ic
reg unrate l(1/3).unrate, r
estat ic
dfuller unrate, reg lag(2)

//Creating first differences
gen d3dy = dy-L3.dy
gen d3inf=inf-l3.inf
gen d3ur=ur-L3.ur

//Testing a simple model
reg pop L.pop d3dy d3inf d3ur eisenhower1 eisenhower2 kennedyjohnson1 kennedyjohnson2 nixon1 nixon2ford1 carter1 reagan1 reagan2 hwbush1 clinton1 clinton2 wbush1 wbush2 obama2 trump1 tf1 tf2 tf3 tf4 tf5 tf6 tf7 tf8 tf9 tf10 tf11 tf12 tf13 tf14 tf15 party_change2 party_change3 party_change4 party_change5 party_change6 party_change7 party_change8 if tin(1953q2,2018q4)

//Final model with Newey HAC heteroskedasticity standard error
newey pop L.pop d3dy d3inf l.d3ur watergate wtc_911 lewinsky korean_war vietnam_war persian_gw su_collapse iraq_war uscn_relation ebombing trumptariff eisenhower1 eisenhower2 kennedyjohnson1 kennedyjohnson2 nixon1 nixon2ford1 carter1 reagan1 reagan2 hwbush1 clinton1 clinton2 wbush1 wbush2 obama1 obama2 trump1 tf2 tf3 tf4 tf5 tf6 tf7 tf8 tf9 tf10 tf11 tf12 tf13 tf14 tf15 tf16 party_change2 party_change3 party_change4 party_change5 party_change6 party_change7 party_change8 if tin(1953q2,2018q4), lag(4) noconstant

