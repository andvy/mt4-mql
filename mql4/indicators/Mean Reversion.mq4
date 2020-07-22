/**
 * Mean Reversion indicator
 *
 * @see  https://www.forexfactory.com/showthread.php?t=743125
 */
#include <stddefines.mqh>
int   __INIT_FLAGS__[] = {INIT_TIMEZONE};
int __DEINIT_FLAGS__[];

////////////////////////////////////////////////////// Configuration ////////////////////////////////////////////////////////

extern string Timeframe        = "D1";
extern int    Periods          = 5;
extern bool   Show.Price       = true;
extern bool   Show.Sublevels   = false;
extern color  Color.HighLow    = Blue;
extern color  Color.Mean       = Red;
extern color  Color.Sublevels  = Gray;
extern int    Width.MainLevels = 1;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include <core/indicator.mqh>
#include <stdfunctions.mqh>
#include <rsfLibs.mqh>
#include <functions/iBarShiftNext.mqh>

#define MODE_LEVEL_100        0                          // indicator buffer ids
#define MODE_LEVEL_75         1
#define MODE_LEVEL_50         2
#define MODE_LEVEL_25         3
#define MODE_LEVEL_0          4

#property indicator_chart_window
#property indicator_buffers   5

#property indicator_color1    CLR_NONE
#property indicator_color2    CLR_NONE
#property indicator_color3    CLR_NONE
#property indicator_color4    CLR_NONE
#property indicator_color5    CLR_NONE

#property indicator_style1    STYLE_SOLID
#property indicator_style2    STYLE_DOT
#property indicator_style3    STYLE_SOLID
#property indicator_style4    STYLE_DOT
#property indicator_style5    STYLE_SOLID

#property indicator_width1    2
#property indicator_width2    1
#property indicator_width3    2
#property indicator_width4    1
#property indicator_width5    2

double buffer100[];                                      // level 100% (High)
double buffer75 [];                                      // level  75%
double buffer50 [];                                      // level  50% (Mid)
double buffer25 [];                                      // level  25%
double buffer0  [];                                      // level   0% (Low)

int meanTimeframe;
int meanPeriods;

int drawWidthMain;


/**
 * Initialization
 *
 * @return int - error status
 */
int onInit() {
   // validate inputs
   // Timeframe
   meanTimeframe = StrToTimeframe(Timeframe, F_ERR_INVALID_PARAMETER);
   if (meanTimeframe == -1)  return(catch("onInit(1)  Invalid input parameter Timeframe: "+ DoubleQuoteStr(Timeframe), ERR_INVALID_INPUT_PARAMETER));
   Timeframe = TimeframeDescription(meanTimeframe);
   // Periods
   if (Periods < 0)          return(catch("onInit(2)  Invalid input parameter Periods: "+ Periods, ERR_INVALID_INPUT_PARAMETER));
   meanPeriods = Periods;
   // colors: after deserialization the terminal might turn CLR_NONE (0xFFFFFFFF) into Black (0xFF000000)
   if (Color.HighLow   == 0xFF000000) Color.HighLow   = CLR_NONE;
   if (Color.Mean      == 0xFF000000) Color.Mean      = CLR_NONE;
   if (Color.Sublevels == 0xFF000000) Color.Sublevels = CLR_NONE;
   // Width.MainLevels
   if (Width.MainLevels < 0) return(catch("onInit(3)  Invalid input parameter Width.MainLevels: "+ Width.MainLevels, ERR_INVALID_INPUT_PARAMETER));
   if (Width.MainLevels > 5) return(catch("onInit(4)  Invalid input parameter Width.MainLevels: "+ Width.MainLevels, ERR_INVALID_INPUT_PARAMETER));
   drawWidthMain = Width.MainLevels;

   // buffer management
   SetIndexBuffer(MODE_LEVEL_100, buffer100);            // level 100% (High)
   SetIndexBuffer(MODE_LEVEL_75,  buffer75 );            // level  75%
   SetIndexBuffer(MODE_LEVEL_50,  buffer50 );            // level  50% (Mid)
   SetIndexBuffer(MODE_LEVEL_25,  buffer25 );            // level  25%
   SetIndexBuffer(MODE_LEVEL_0,   buffer0  );            // level   0% (Low)

   // names, labels and display options
   if (Width.MainLevels && Color.HighLow!=CLR_NONE) SetIndexLabel(MODE_LEVEL_100, "MeanReversion(High)");
   else                                             SetIndexLabel(MODE_LEVEL_100, NULL);
   if (Width.MainLevels && Color.HighLow!=CLR_NONE) SetIndexLabel(MODE_LEVEL_50,  "MeanReversion(Mid)");
   else                                             SetIndexLabel(MODE_LEVEL_50,  NULL);
   if (Width.MainLevels && Color.HighLow!=CLR_NONE) SetIndexLabel(MODE_LEVEL_0,   "MeanReversion(Low)");
   else                                             SetIndexLabel(MODE_LEVEL_0,   NULL);
   if (Show.Sublevels && Color.Sublevels!=CLR_NONE) SetIndexLabel(MODE_LEVEL_75,  "MeanReversion(75%)");
   else                                             SetIndexLabel(MODE_LEVEL_75,  NULL);
   if (Show.Sublevels && Color.Sublevels!=CLR_NONE) SetIndexLabel(MODE_LEVEL_25,  "MeanReversion(25%)");
   else                                             SetIndexLabel(MODE_LEVEL_25,  NULL);
   IndicatorDigits(Digits);
   SetIndicatorOptions();

   return(catch("onInit(5)"));
}


/**
 * Main function
 *
 * @return int - error status
 */
int onTick() {
   // under specific circumstances buffers may not be initialized on the first tick after terminal start
   if (!ArraySize(buffer100)) return(log("onTick(1)  size(buffer100) = 0", SetLastError(ERS_TERMINAL_NOT_YET_READY)));

   // reset all buffers and delete garbage before doing a full recalculation
   if (!UnchangedBars) {
      ArrayInitialize(buffer100, EMPTY_VALUE);
      ArrayInitialize(buffer75,  EMPTY_VALUE);
      ArrayInitialize(buffer50,  EMPTY_VALUE);
      ArrayInitialize(buffer25,  EMPTY_VALUE);
      ArrayInitialize(buffer0,   EMPTY_VALUE);
      SetIndicatorOptions();
   }

   // synchronize buffers with a shifted offline chart
   if (ShiftedBars > 0) {
      ShiftIndicatorBuffer(buffer100, Bars, ShiftedBars, EMPTY_VALUE);
      ShiftIndicatorBuffer(buffer75,  Bars, ShiftedBars, EMPTY_VALUE);
      ShiftIndicatorBuffer(buffer50,  Bars, ShiftedBars, EMPTY_VALUE);
      ShiftIndicatorBuffer(buffer25,  Bars, ShiftedBars, EMPTY_VALUE);
      ShiftIndicatorBuffer(buffer0,   Bars, ShiftedBars, EMPTY_VALUE);
   }

   // update indicator
   if (Period() < meanTimeframe) {

      if (!UnchangedBars) {
         double high, low, mean, level25, level75;
         int startBar, endBar=0;

         for (int period=1; period <= meanPeriods; period++) {
            startBar = iBarShiftNext(NULL, NULL, Time[endBar] - (Time[endBar] % DAY));

            debug("onTick(0.1)  period="+ period +"  startBar="+ startBar +"  endBar="+ endBar +"  openTime="+ TimeToStr(Time[startBar], TIME_FULL));

            high = INT_MIN;
            low  = INT_MAX;

            for (int bar=startBar; bar >= endBar; bar--) {
               high    = MathMax(high, High[bar]);
               low     = MathMin(low,  Low [bar]);
               mean    = (high+low)/2;
               level25 = (mean+low)/2;
               level75 = (high+mean)/2;

               if (bar != startBar) {                    // skip drawing of the first bar to interrupt the indicator line
                  buffer100[bar] = high;
                  buffer75 [bar] = level75;
                  buffer50 [bar] = mean;
                  buffer25 [bar] = level25;
                  buffer0  [bar] = low;
               }
            }
            endBar = startBar + 1;
         }

         if (Show.Price) {
            UpdatePriceLabel(MODE_LEVEL_100, Tick.Time, buffer100[0]);
            UpdatePriceLabel(MODE_LEVEL_25,  Tick.Time, buffer75 [0]);
            UpdatePriceLabel(MODE_LEVEL_50,  Tick.Time, buffer50 [0]);
            UpdatePriceLabel(MODE_LEVEL_75,  Tick.Time, buffer25 [0]);
            UpdatePriceLabel(MODE_LEVEL_0,   Tick.Time, buffer0  [0]);
         }
      }
   }
   return(last_error);
}


/**
 *
 */
bool UpdatePriceLabel(int id, datetime time, double price) {
   return(false);
}


/**
 * Workaround for various terminal bugs when setting indicator options. Usually options are set in init(). However after
 * recompilation options must be set in start() to not get ignored.
 */
void SetIndicatorOptions() {
   //SetIndexStyle(int buffer, int drawType, int lineStyle=EMPTY, int drawWidth=EMPTY, color drawColor=NULL)

   int drawTypeMain = ifInt(!drawWidthMain,  DRAW_NONE, DRAW_LINE);
   int drawTypeSub  = ifInt(!Show.Sublevels, DRAW_NONE, DRAW_LINE);

   SetIndexStyle(MODE_LEVEL_100, drawTypeMain, EMPTY, drawWidthMain, Color.HighLow);
   SetIndexStyle(MODE_LEVEL_50,  drawTypeMain, EMPTY, drawWidthMain, Color.Mean   );
   SetIndexStyle(MODE_LEVEL_0,   drawTypeMain, EMPTY, drawWidthMain, Color.HighLow);

   SetIndexStyle(MODE_LEVEL_75, drawTypeSub, EMPTY, EMPTY, Color.Sublevels);
   SetIndexStyle(MODE_LEVEL_25, drawTypeSub, EMPTY, EMPTY, Color.Sublevels);
}


/**
 * Return a string representation of the input parameters (for logging purposes).
 *
 * @return string
 */
string InputsToStr() {
   return(StringConcatenate("Timeframe=",        DoubleQuoteStr(Timeframe),   ";", NL,
                            "Periods=",          Periods,                     ";", NL,
                            "Show.Price=",       BoolToStr(Show.Price),       ";", NL,
                            "Show.Sublevels=",   BoolToStr(Show.Sublevels),   ";", NL,
                            "Color.HighLow=",    ColorToStr(Color.HighLow),   ";", NL,
                            "Color.Mean=",       ColorToStr(Color.Mean),      ";", NL,
                            "Color.Sublevels=",  ColorToStr(Color.Sublevels), ";", NL,
                            "Width.MainLevels=", Width.MainLevels,            ";")
   );
}
