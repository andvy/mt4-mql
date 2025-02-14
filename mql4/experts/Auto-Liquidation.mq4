/**
 * Auto-Liquidation
 *
 * This EA's purpose is to protect the trading account and enforce adherence to a daily loss/drawdown limit (DDL). It monitors
 * open positions and floating PnL of all symbols (not only the chart symbol where the EA is attached).
 *
 * Positions of symbols without trade permission are immediately closed.
 *
 * Permitted positions are monitored until a predefined drawdown limit is reached. Then the EA closes all open positions and
 * deletes all pending orders of the account, and further trading is prohibited until the end of the day.
 *
 * The EA should run in a separate terminal connected 24/7 to the trade server. For best operation it's strongly advised to
 * setup a hosted environment (VM or dedicated server).
 */
#include <stddefines.mqh>
int   __InitFlags[] = {INIT_TIMEZONE, INIT_BUFFERED_LOG, INIT_NO_EXTERNAL_REPORTING};
int __DeinitFlags[];
int __virtualTicks = 800;                          // milliseconds (must be short as the EA watches all symbols)

////////////////////////////////////////////////////// Configuration ////////////////////////////////////////////////////////

extern string PermittedSymbols = "";               // symbols allowed to trade ("*": all symbols)
extern string DrawdownLimit    = "200.00 | 5%*";   // absolute or percentage drawdown limit
extern bool   IgnoreSpread     = true;             // whether to not track the spread of open positions (prevents liquidation by spread widening)

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include <core/expert.mqh>
#include <stdfunctions.mqh>
#include <rsfLib.mqh>
#include <functions/ComputeFloatingPnL.mqh>

double   prevEquity;                               // equity value at the previous tick
bool     isPctLimit;                               // whether a percent limit is configured
double   absLimit;                                 // configured absolute drawdown limit
double   pctLimit;                                 // configured percentage drawdown limit
datetime lastLiquidationTime;

string   permittedSymbols[];
string   watchedSymbols  [];
double   watchedPositions[][3];

#define I_START_EQUITY     0                       // indexes of watchedPositions[]
#define I_DRAWDOWN_LIMIT   1                       //
#define I_PROFIT           2                       //


/**
 * Initialization.
 *
 * @return int - error status
 */
int onInit() {
   // validate inputs
   // PermittedSymbols
   string sValue="", values[];
   int size = Explode(PermittedSymbols, ",", values, NULL);
   for (int i=0; i < size; i++) {
      sValue = StrTrim(values[i]);
      if (StringLen(sValue) > MAX_SYMBOL_LENGTH) return(catch("onInit(1)  invalid parameter PermittedSymbols: "+ DoubleQuoteStr(PermittedSymbols) +" (max symbol length = "+ MAX_SYMBOL_LENGTH +")", ERR_INVALID_PARAMETER));
      if (SearchStringArrayI(permittedSymbols, sValue) == -1) {
         ArrayPushString(permittedSymbols, sValue);
      }
   }

   // DrawdownLimit
   if (Explode(DrawdownLimit, "*", values, 2) > 1) {
      size = Explode(values[0], "|", values, NULL);
      sValue = StrTrim(values[size-1]);
   }
   else {
      sValue = StrTrim(DrawdownLimit);
   }
   isPctLimit = StrEndsWith(sValue, "%");
   if (isPctLimit) sValue = StrTrimRight(StrLeft(sValue, -1));
   if (!StrIsNumeric(sValue))                    return(catch("onInit(2)  invalid parameter DrawdownLimit: "+ DoubleQuoteStr(DrawdownLimit), ERR_INVALID_PARAMETER));
   double dValue = NormalizeDouble(-MathAbs(StrToDouble(sValue)), 2);
   if (isPctLimit) {
      pctLimit = dValue;
      absLimit = NULL;
      if (!pctLimit)                             return(catch("onInit(3)  illegal parameter DrawdownLimit: "+ DoubleQuoteStr(DrawdownLimit) +" (must be != 0)", ERR_INVALID_PARAMETER));
      if (pctLimit <= -100)                      return(catch("onInit(4)  illegal parameter DrawdownLimit: "+ DoubleQuoteStr(DrawdownLimit) +" (must be > -100)", ERR_INVALID_PARAMETER));
      DrawdownLimit = NumberToStr(pctLimit, ".+") +"%";
   }
   else {
      pctLimit = NULL;
      absLimit = dValue;
      if (!absLimit)                             return(catch("onInit(5)  illegal parameter DrawdownLimit: "+ DoubleQuoteStr(DrawdownLimit) +" (must be != 0)", ERR_INVALID_PARAMETER));
      DrawdownLimit = DoubleToStr(absLimit, 2);
   }
   return(catch("onInit(6)"));
}


/**
 * Main function
 *
 * @return int - error status
 */
int onTick() {
   // get open positions
   string openSymbols[];
   double openPositions[];
   if (!ComputeFloatingPnLs(openSymbols, openPositions, IgnoreSpread)) return(last_error);

   // calculate current equity
   double equity = AccountBalance();
   int openSize = ArraySize(openSymbols);
   for (int i=0; i < openSize; i++) {
      equity += openPositions[i];
   }

   // synchronize watched positions
   int watchedSize = ArraySize(watchedSymbols);
   for (i=0; i < watchedSize; i++) {
      int n = SearchStringArray(openSymbols, watchedSymbols[i]);
      if (n == -1) {
         // position closed, remove watched position
         logInfo("onTick(1)  "+ watchedSymbols[i] +" position closed");
         if (watchedSize > i+1) {
            int dim2 = ArrayRange(watchedPositions, 1);
            ArrayCopy(watchedSymbols,   watchedSymbols,   i,       i+1);
            ArrayCopy(watchedPositions, watchedPositions, i*dim2, (i+1)*dim2);
         }
         watchedSize--;
         ArrayResize(watchedSymbols,   watchedSize);
         ArrayResize(watchedPositions, watchedSize);
         i--;
      }
      else {
         // update watched position and remove open position
         watchedPositions[i][I_PROFIT] = openPositions[n];
         if (openSize > n+1) {
            ArrayCopy(openSymbols,   openSymbols,   n, n+1);
            ArrayCopy(openPositions, openPositions, n, n+1);
         }
         openSize--;
         ArrayResize(openSymbols,   openSize);
         ArrayResize(openPositions, openSize);
      }
   }

   // auto-liquidate new positions after previous liquidation on the same day
   if (openSize > 0) {
      datetime today = TimeFXT();
      today -= (today % DAY);
      datetime lastLiquidation = lastLiquidationTime - lastLiquidationTime % DAY;
      if (lastLiquidation == today) {
         logWarn("onTick(2)  liquidating all new positions (auto-liquidation until end of day)");
         ArrayResize(watchedSymbols, 0);
         ArrayResize(watchedPositions, 0);
         CloseOpenOrders();
         return(catch("onTick(3)"));
      }
   }

   // process new positions
   for (i=0; prevEquity && i < openSize; i++) {
      // close non-permitted positions
      if (SearchStringArrayI(permittedSymbols, openSymbols[i]) == -1) {
         logWarn("onTick(2)  closing non-permitted "+ openSymbols[i] +" position");
         CloseOpenOrders(openSymbols[i]);
         continue;
      }
      // watch new position
      ArrayResize(watchedSymbols,   watchedSize+1);
      ArrayResize(watchedPositions, watchedSize+1);
      watchedSymbols  [watchedSize]                   = openSymbols[i];
      watchedPositions[watchedSize][I_START_EQUITY  ] = prevEquity;
      watchedPositions[watchedSize][I_DRAWDOWN_LIMIT] = ifDouble(isPctLimit, NormalizeDouble(prevEquity * pctLimit/100, 2), absLimit);
      watchedPositions[watchedSize][I_PROFIT        ] = openPositions[i];
      logInfo("onTick(4)  watching "+ watchedSymbols[watchedSize] +" position, drawdownLimit="+ DoubleToStr(watchedPositions[watchedSize][I_DRAWDOWN_LIMIT], 2));
      watchedSize++;
   }
   prevEquity = equity;

   // monitor drawdown limit
   for (i=0; i < watchedSize; i++) {
      double profit  = watchedPositions[i][I_PROFIT];
      double ddLimit = watchedPositions[i][I_DRAWDOWN_LIMIT];
      if (profit < ddLimit) {
         lastLiquidationTime = TimeFXT();
         logWarn("onTick(5)  "+ watchedSymbols[i] +": drawdown limit of "+ DrawdownLimit +" reached, liquidating positions...");
         ArrayResize(watchedSymbols, 0);
         ArrayResize(watchedPositions, 0);
         CloseOpenOrders();
         break;
      }
   }
   return(catch("onTick(6)"));
}


/**
 * Close open positions and pending orders.
 *
 * @param string symbol [optional] - symbol to close (default: all symbols)
 *
 * @return bool - success status
 */
bool CloseOpenOrders(string symbol = "") {
   int orders = OrdersTotal(), pendings[], positions[];
   ArrayResize(pendings, 0);
   ArrayResize(positions, 0);

   for (int i=0; i < orders; i++) {
      if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) break;
      if (OrderType() > OP_SELLSTOP)                   continue;
      if (symbol != "") {
         if (!StrCompareI(OrderSymbol(), symbol))      continue;
      }
      if (OrderType() > OP_SELL) ArrayPushInt(pendings, OrderTicket());
      else                       ArrayPushInt(positions, OrderTicket());
   }

   int oe[], oes[][ORDER_EXECUTION_intSize], oeFlags=NULL;

   if (ArraySize(positions) > 0) {
      if (!OrdersClose(positions, 1, CLR_NONE, oeFlags, oes)) return(false);
   }
   for (i=ArraySize(pendings)-1; i >= 0; i--) {
      if (!OrderDeleteEx(pendings[i], CLR_NONE, oeFlags, oe)) return(false);
   }
   return(!catch("CloseOpenOrders(1)"));
}


/**
 * Return a string representation of the input parameters (for logging purposes).
 *
 * @return string
 */
string InputsToStr() {
   return(StringConcatenate("PermittedSymbols=", DoubleQuoteStr(PermittedSymbols), ";", NL,
                            "DrawdownLimit=",    DoubleQuoteStr(DrawdownLimit),    ";", NL,
                            "IgnoreSpread=",     BoolToStr(IgnoreSpread),          ";"));
}
