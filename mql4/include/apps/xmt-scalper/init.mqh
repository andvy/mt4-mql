/**
 * Called after the expert was manually loaded by the user. Also in tester with both "VisualMode=On|Off". There was an input
 * dialog.
 *
 * @return int - error status
 */
int onInitUser() {
   // check for and validate a specified sequence id
   if (ValidateInputs.SID()) {                                 // on success a sequence id was specified and restored
      RestoreSequence();
      return(last_error);
   }
   else if (StringLen(StrTrim(Sequence.ID)) > 0) {
      return(last_error);                                      // on error an invalid sequence id was specified
   }


   // TODO: move to separate function ValidateInputs()
   // validate inputs
   // Sequence.ID
   string values[], sValue = StrTrim(Sequence.ID);
   if (StringLen(sValue) > 0) {
      if (!StrIsDigit(sValue))                               return(catch("onInitUser(1)  "+ sequence.name +" invalid input parameter Sequence.ID: "+ DoubleQuoteStr(Sequence.ID) +" (must be digits only)", ERR_INVALID_INPUT_PARAMETER));
      int iValue = StrToInteger(sValue);
      if (iValue < SID_MIN || iValue > SID_MAX)              return(catch("onInitUser(2)  "+ sequence.name +" invalid input parameter Sequence.ID: "+ DoubleQuoteStr(Sequence.ID) +" (range error)", ERR_INVALID_INPUT_PARAMETER));
      sequence.id = iValue;
      Sequence.ID = sequence.id;
   }
   // TradingMode
   sValue = TradingMode;
   if (Explode(sValue, "*", values, 2) > 1) {
      int size = Explode(values[0], "|", values, NULL);
      sValue = values[size-1];
   }
   sValue = StrToLower(StrTrim(sValue));
   if      (sValue=="r"  || sValue=="regular"       ) tradingMode = TRADINGMODE_REGULAR;
   else if (sValue=="v"  || sValue=="virtual"       ) tradingMode = TRADINGMODE_VIRTUAL;
   else if (sValue=="vc" || sValue=="virtual-copier") tradingMode = TRADINGMODE_VIRTUAL_COPIER;
   else if (sValue=="vm" || sValue=="virtual-mirror") tradingMode = TRADINGMODE_VIRTUAL_MIRROR;
   else                                                      return(catch("onInitUser(3)  "+ sequence.name +" invalid input parameter TradingMode: "+ DoubleQuoteStr(TradingMode), ERR_INVALID_INPUT_PARAMETER));
   TradingMode = tradingModeDescriptions[tradingMode];
   // EntryIndicator
   if (EntryIndicator < 1 || EntryIndicator > 3)             return(catch("onInitUser(4)  "+ sequence.name +" invalid input parameter EntryIndicator: "+ EntryIndicator +" (must be from 1-3)", ERR_INVALID_INPUT_PARAMETER));
   // IndicatorTimeframe
   if (IsTesting() && IndicatorTimeframe!=Period())          return(catch("onInitUser(5)  "+ sequence.name +" illegal test on "+ PeriodDescription(Period()) +" for configured EA timeframe "+ PeriodDescription(IndicatorTimeframe), ERR_RUNTIME_ERROR));
   // BreakoutReversal
   double stopLevel = MarketInfo(Symbol(), MODE_STOPLEVEL);
   if (LT(BreakoutReversal*Pip, stopLevel*Point))            return(catch("onInitUser(6)  "+ sequence.name +" invalid input parameter BreakoutReversal: "+ NumberToStr(BreakoutReversal, ".1+") +" (must be larger than MODE_STOPLEVEL)", ERR_INVALID_INPUT_PARAMETER));
   double minLots=MarketInfo(Symbol(), MODE_MINLOT), maxLots=MarketInfo(Symbol(), MODE_MAXLOT);
   if (MoneyManagement) {
      // Risk
      if (LE(Risk, 0))                                       return(catch("onInitUser(7)  "+ sequence.name +" invalid input parameter Risk: "+ NumberToStr(Risk, ".1+") +" (must be positive)", ERR_INVALID_INPUT_PARAMETER));
      double lots = CalculateLots(false); if (IsLastError()) return(last_error);
      if (LT(lots, minLots))                                 return(catch("onInitUser(8)  "+ sequence.name +" not enough money ("+ DoubleToStr(AccountEquity()-AccountCredit(), 2) +") for input parameter Risk="+ NumberToStr(Risk, ".1+") +" (resulting position size "+ NumberToStr(lots, ".1+") +" smaller than MODE_MINLOT="+ NumberToStr(minLots, ".1+") +")", ERR_NOT_ENOUGH_MONEY));
      if (GT(lots, maxLots))                                 return(catch("onInitUser(9)  "+ sequence.name +" too large input parameter Risk: "+ NumberToStr(Risk, ".1+") +" (resulting position size "+ NumberToStr(lots, ".1+") +" larger than MODE_MAXLOT="+  NumberToStr(maxLots, ".1+") +")", ERR_INVALID_INPUT_PARAMETER));
   }
   else {
      // ManualLotsize
      if (LT(ManualLotsize, minLots))                        return(catch("onInitUser(10)  "+ sequence.name +" too small input parameter ManualLotsize: "+ NumberToStr(ManualLotsize, ".1+") +" (smaller than MODE_MINLOT="+ NumberToStr(minLots, ".1+") +")", ERR_INVALID_INPUT_PARAMETER));
      if (GT(ManualLotsize, maxLots))                        return(catch("onInitUser(11)  "+ sequence.name +" too large input parameter ManualLotsize: "+ NumberToStr(ManualLotsize, ".1+") +" (larger than MODE_MAXLOT="+ NumberToStr(maxLots, ".1+") +")", ERR_INVALID_INPUT_PARAMETER));
   }
   // EA.StopOnProfit / EA.StopOnLoss
   if (EA.StopOnProfit && EA.StopOnLoss) {
      if (EA.StopOnProfit <= EA.StopOnLoss)                  return(catch("onInitUser(12)  "+ sequence.name +" input parameter mis-match EA.StopOnProfit="+ DoubleToStr(EA.StopOnProfit, 2) +" / EA.StopOnLoss="+ DoubleToStr(EA.StopOnLoss, 2) +" (profit must be larger than loss)", ERR_INVALID_INPUT_PARAMETER));
   }

   // initialize sequence id
   if (!sequence.id) {
      sequence.id = CreateSequenceId(); SS.SequenceName();
      logInfo("onInitUser(13)  sequence id "+ sequence.id +" created");
   }

   // initialize global vars
   if (UseSpreadMultiplier) { minBarSize = 0;              sMinBarSize = "-";                                }
   else                     { minBarSize = MinBarSize*Pip; sMinBarSize = DoubleToStr(MinBarSize, 1) +" pip"; }
   MaxSpread        = NormalizeDouble(MaxSpread, 1);
   sMaxSpread       = DoubleToStr(MaxSpread, 1);
   commissionPip    = GetCommission(1, MODE_MARKUP)/Pip;
   orderSlippage    = Round(MaxSlippage*Pip/Point);
   orderComment     = "XMT."+ sequence.id + ifString(ChannelBug, ".ChBug", "") + ifString(TakeProfitBug, ".TpBug", "");
   orderMagicNumber = GenerateMagicNumber();

   // restore order log
   if (!ReadOrderLog()) return(last_error);

   return(catch("onInitUser(14)"));
}


/**
 * Called after the expert was loaded by a chart template. Also at terminal start. There was no input dialog.
 *
 * @return int - error status
 */
int onInitTemplate() {
   return(SetLastError(ERR_NOT_IMPLEMENTED));
}


/**
 * Called after the chart symbol has changed. There was no input dialog.
 *
 * @return int - error status
 */
int onInitSymbolChange() {
   return(SetLastError(ERR_ILLEGAL_STATE));
}


/**
 * Initialization postprocessing. Not called if the reason-specific event handler returned with an error.
 *
 * @return int - error status
 */
int afterInit() {
   SS.All();
   if (!SetLogfile(GetLogFilename())) return(last_error);
   if (!InitMetrics())                return(last_error);   // initialize metrics

   if (IsTesting()) {                                       // read test configuration
      string section = ProgramName() +".Tester";
      test.onPositionOpenPause = GetConfigBool(section, "OnPositionOpenPause", false);
      test.reduceStatusWrites  = GetConfigBool(section, "ReduceStatusWrites",   true);
   }
   return(catch("afterInit(1)"));
}
