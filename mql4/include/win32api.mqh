/**
 * win32api.mqh
 */
#import "kernel32.dll"

   bool CloseHandle(int hObject);
   bool CreateProcessA(int lpApplicationName, string lpCommandLine, int lpProcessAttributes, int lpThreadAttributes, int bInheritHandles, int dwCreationFlags, int lpEnvironment, int lpCurrentDirectory, int lpStartupInfo[], int lpProcessInformation[]);
   bool DeleteFileA(string lpFileName);
   bool GetComputerNameA(string lpBuffer, int lpBufferSize[]);
   int  GetEnvironmentStringsA();
   void GetLocalTime(int lpSystemTime[]);
   int  GetModuleFileNameA(int hModule, string lpBuffer, int nBufferSize);
   int  GetPrivateProfileIntA(string lpSection, string lpKey, int nDefault, string lpFileName);
   int  GetPrivateProfileStringA(string lpSection, string lpKey, string lpDefault, string lpBuffer, int nBufferSize, string lpFileName);
   void GetStartupInfoA(int lpStartupInfo[]);
   void GetSystemTime(int lpSystemTime[]);
   int  GetCurrentThreadId();
   int  GetTimeZoneInformation(int lpTimeZoneInformation[]);
   void OutputDebugStringA(string lpMessage);
   int  WaitForSingleObject(int hHandle, int dwMilliseconds);
   int  WinExec(string lpCmdLine, int nCmdShow);

#import "shell32.dll"

   int  ShellExecuteA(int hWnd, string lpOperation, string lpFile, string lpParameters, string lpDirectory, int nShowCmd);

#import "user32.dll"

   int  GetActiveWindow();
   int  GetParent(int hWnd);
   int  GetWindowTextA(int hWnd, string lpBuffer, int nBufferSize);
   bool PostMessageA(int hWnd, int Msg, int wParam, int lParam);
   int  RegisterWindowMessageA(string lpString);
   bool SetWindowTextA(int hWnd, string lpString);


   /*
   // Von hier an MetaQuest-Code (nicht �berpr�ft)
   //
   // messages
   int  SendMessageA(int hWnd, int Msg, int wParam, int lParam);
   int  SendNotifyMessageA(int hWnd, int Msg, int wParam, int lParam);
   void keybd_event(int bVk, int bScan, int dwFlags, int dwExtraInfo);
   void mouse_event(int dwFlags, int dx, int dy, int dwData, int dwExtraInfo);

   // windows
   int  FindWindowA(string lpClassName, string lpWindowName);
   int  GetWindow(int hWnd, int uCmd);
   int  GetWindowTextLengthA(int hWnd);
   int  UpdateWindow(int hWnd);
   int  EnableWindow(int hWnd, int bEnable);
   int  DestroyWindow(int hWnd);
   int  ShowWindow(int hWnd, int nCmdShow);
   int  SetActiveWindow(int hWnd);
   int  AnimateWindow(int hWnd, int dwTime, int dwFlags);
   int  FlashWindow(int hWnd, int dwFlags);
   int  CloseWindow(int hWnd);
   int  MoveWindow(int hWnd, int X, int Y, int nWidth, int nHeight, int bRepaint);
   int  SetWindowPos(int hWnd, int hWndInsertAfter, int X, int Y, int cx, int cy, int uFlags);
   int  IsWindowVisible(int hWnd);
   int  IsIconic(int hWnd);
   int  IsZoomed(int hWnd);
   int  SetFocus(int hWnd);
   int  GetFocus();
   int  IsWindowEnabled(int hWnd);

   // miscellaneous
   int  MessageBoxA(int hWnd, string lpText, string lpCaption, int uType);
   int  MessageBoxExA(int hWnd, string lpText, string lpCaption, int uType, int wLanguageId);
   int  MessageBeep(int uType);
   int  GetSystemMetrics(int nIndex);
   int  ExitWindowsEx(int uFlags, int dwReserved);
   int  SwapMouseButton(int fSwap);
   */

#import


// AnimateWindow() commands
#define AW_HOR_POSITIVE                      0x00000001
#define AW_HOR_NEGATIVE                      0x00000002
#define AW_VER_POSITIVE                      0x00000004
#define AW_VER_NEGATIVE                      0x00000008
#define AW_CENTER                            0x00000010
#define AW_HIDE                              0x00010000
#define AW_ACTIVATE                          0x00020000
#define AW_SLIDE                             0x00040000
#define AW_BLEND                             0x00080000


// Dialog box command IDs (return codes)
#define IDOK                                          1
#define IDCANCEL                                      2
#define IDABORT                                       3
#define IDRETRY                                       4
#define IDIGNORE                                      5
#define IDYES                                         6
#define IDNO                                          7
#define IDCLOSE                                       8
#define IDHELP                                        9
#define IDTRYAGAIN                                   10
#define IDCONTINUE                                   11


// Dialog box flags
#define MB_OK                                0x00000000
#define MB_OKCANCEL                          0x00000001
#define MB_ABORTRETRYIGNORE                  0x00000002
#define MB_YESNOCANCEL                       0x00000003
#define MB_YESNO                             0x00000004
#define MB_RETRYCANCEL                       0x00000005
#define MB_CANCELTRYCONTINUE                 0x00000006
#define MB_ICONHAND                          0x00000010
#define MB_ICONQUESTION                      0x00000020
#define MB_ICONEXCLAMATION                   0x00000030
#define MB_ICONASTERISK                      0x00000040
#define MB_USERICON                          0x00000080
#define MB_ICONWARNING               MB_ICONEXCLAMATION
#define MB_ICONERROR                        MB_ICONHAND
#define MB_ICONINFORMATION              MB_ICONASTERISK
#define MB_ICONSTOP                         MB_ICONHAND
#define MB_DEFBUTTON1                        0x00000000
#define MB_DEFBUTTON2                        0x00000100
#define MB_DEFBUTTON3                        0x00000200
#define MB_DEFBUTTON4                        0x00000300
#define MB_APPLMODAL                         0x00000000
#define MB_SYSTEMMODAL                       0x00001000
#define MB_TASKMODAL                         0x00002000
#define MB_HELP                              0x00004000 // help button
#define MB_NOFOCUS                           0x00008000
#define MB_SETFOREGROUND                     0x00010000
#define MB_DEFAULT_DESKTOP_ONLY              0x00020000
#define MB_TOPMOST                           0x00040000
#define MB_RIGHT                             0x00080000
#define MB_RTLREADING                        0x00100000


// GetSystemMetrics() codes
#define SM_CXSCREEN                                   0
#define SM_CYSCREEN                                   1
#define SM_CXVSCROLL                                  2
#define SM_CYHSCROLL                                  3
#define SM_CYCAPTION                                  4
#define SM_CXBORDER                                   5
#define SM_CYBORDER                                   6
#define SM_CXDLGFRAME                                 7
#define SM_CYDLGFRAME                                 8
#define SM_CYVTHUMB                                   9
#define SM_CXHTHUMB                                  10
#define SM_CXICON                                    11
#define SM_CYICON                                    12
#define SM_CXCURSOR                                  13
#define SM_CYCURSOR                                  14
#define SM_CYMENU                                    15
#define SM_CXFULLSCREEN                              16
#define SM_CYFULLSCREEN                              17
#define SM_CYKANJIWINDOW                             18
#define SM_MOUSEPRESENT                              19
#define SM_CYVSCROLL                                 20
#define SM_CXHSCROLL                                 21
#define SM_DEBUG                                     22
#define SM_SWAPBUTTON                                23
#define SM_RESERVED1                                 24
#define SM_RESERVED2                                 25
#define SM_RESERVED3                                 26
#define SM_RESERVED4                                 27
#define SM_CXMIN                                     28
#define SM_CYMIN                                     29
#define SM_CXSIZE                                    30
#define SM_CYSIZE                                    31
#define SM_CXFRAME                                   32
#define SM_CYFRAME                                   33
#define SM_CXMINTRACK                                34
#define SM_CYMINTRACK                                35
#define SM_CXDOUBLECLK                               36
#define SM_CYDOUBLECLK                               37
#define SM_CXICONSPACING                             38
#define SM_CYICONSPACING                             39
#define SM_MENUDROPALIGNMENT                         40
#define SM_PENWINDOWS                                41
#define SM_DBCSENABLED                               42
#define SM_CMOUSEBUTTONS                             43
#define SM_SECURE                                    44
#define SM_CXEDGE                                    45
#define SM_CYEDGE                                    46
#define SM_CXMINSPACING                              47
#define SM_CYMINSPACING                              48
#define SM_CXSMICON                                  49
#define SM_CYSMICON                                  50
#define SM_CYSMCAPTION                               51
#define SM_CXSMSIZE                                  52
#define SM_CYSMSIZE                                  53
#define SM_CXMENUSIZE                                54
#define SM_CYMENUSIZE                                55
#define SM_ARRANGE                                   56
#define SM_CXMINIMIZED                               57
#define SM_CYMINIMIZED                               58
#define SM_CXMAXTRACK                                59
#define SM_CYMAXTRACK                                60
#define SM_CXMAXIMIZED                               61
#define SM_CYMAXIMIZED                               62
#define SM_NETWORK                                   63
#define SM_CLEANBOOT                                 67
#define SM_CXDRAG                                    68
#define SM_CYDRAG                                    69
#define SM_SHOWSOUNDS                                70
#define SM_CXMENUCHECK                               71     // use instead of GetMenuCheckMarkDimensions()
#define SM_CYMENUCHECK                               72
#define SM_SLOWMACHINE                               73
#define SM_MIDEASTENABLED                            74
#define SM_MOUSEWHEELPRESENT                         75
#define SM_XVIRTUALSCREEN                            76
#define SM_YVIRTUALSCREEN                            77
#define SM_CXVIRTUALSCREEN                           78
#define SM_CYVIRTUALSCREEN                           79
#define SM_CMONITORS                                 80
#define SM_SAMEDISPLAYFORMAT                         81


// GetTimeZoneInformation() constants
#define TIME_ZONE_ID_UNKNOWN                          0
#define TIME_ZONE_ID_STANDARD                         1
#define TIME_ZONE_ID_DAYLIGHT                         2


// GetWindow() constants
#define GW_HWNDFIRST                                  0
#define GW_HWNDLAST                                   1
#define GW_HWNDNEXT                                   2
#define GW_HWNDPREV                                   3
#define GW_OWNER                                      4
#define GW_CHILD                                      5


// Keyboard events
#define KEYEVENTF_EXTENDEDKEY                    0x0001
#define KEYEVENTF_KEYUP                          0x0002


// Messages
#define WM_NULL                                  0x0000
#define WM_CREATE                                0x0001
#define WM_DESTROY                               0x0002
#define WM_MOVE                                  0x0003
#define WM_SIZE                                  0x0005
#define WM_ACTIVATE                              0x0006
#define WM_SETFOCUS                              0x0007
#define WM_KILLFOCUS                             0x0008
#define WM_ENABLE                                0x000A
#define WM_SETREDRAW                             0x000B
#define WM_SETTEXT                               0x000C
#define WM_GETTEXT                               0x000D
#define WM_GETTEXTLENGTH                         0x000E
#define WM_PAINT                                 0x000F
#define WM_CLOSE                                 0x0010
#define WM_QUERYENDSESSION                       0x0011
#define WM_QUIT                                  0x0012
#define WM_QUERYOPEN                             0x0013
#define WM_ERASEBKGND                            0x0014
#define WM_SYSCOLORCHANGE                        0x0015
#define WM_ENDSESSION                            0x0016
#define WM_SHOWWINDOW                            0x0018
#define WM_WININICHANGE                          0x001A
#define WM_SETTINGCHANGE                         0x001A // WM_WININICHANGE
#define WM_DEVMODECHANGE                         0x001B
#define WM_ACTIVATEAPP                           0x001C
#define WM_FONTCHANGE                            0x001D
#define WM_TIMECHANGE                            0x001E
#define WM_CANCELMODE                            0x001F
#define WM_SETCURSOR                             0x0020
#define WM_MOUSEACTIVATE                         0x0021
#define WM_CHILDACTIVATE                         0x0022
#define WM_QUEUESYNC                             0x0023
#define WM_GETMINMAXINFO                         0x0024
#define WM_PAINTICON                             0x0026
#define WM_ICONERASEBKGND                        0x0027
#define WM_NEXTDLGCTL                            0x0028
#define WM_SPOOLERSTATUS                         0x002A
#define WM_DRAWITEM                              0x002B
#define WM_MEASUREITEM                           0x002C
#define WM_DELETEITEM                            0x002D
#define WM_VKEYTOITEM                            0x002E
#define WM_CHARTOITEM                            0x002F
#define WM_SETFONT                               0x0030
#define WM_GETFONT                               0x0031
#define WM_SETHOTKEY                             0x0032
#define WM_GETHOTKEY                             0x0033
#define WM_QUERYDRAGICON                         0x0037
#define WM_COMPAREITEM                           0x0039
#define WM_GETOBJECT                             0x003D
#define WM_COMPACTING                            0x0041
#define WM_WINDOWPOSCHANGING                     0x0046
#define WM_WINDOWPOSCHANGED                      0x0047
#define WM_COPYDATA                              0x004A
#define WM_CANCELJOURNAL                         0x004B
#define WM_NOTIFY                                0x004E
#define WM_INPUTLANGCHANGEREQUEST                0x0050
#define WM_INPUTLANGCHANGE                       0x0051
#define WM_TCARD                                 0x0052
#define WM_HELP                                  0x0053
#define WM_USERCHANGED                           0x0054
#define WM_NOTIFYFORMAT                          0x0055
#define WM_CONTEXTMENU                           0x007B
#define WM_STYLECHANGING                         0x007C
#define WM_STYLECHANGED                          0x007D
#define WM_DISPLAYCHANGE                         0x007E
#define WM_GETICON                               0x007F
#define WM_SETICON                               0x0080
#define WM_NCCREATE                              0x0081
#define WM_NCDESTROY                             0x0082
#define WM_NCCALCSIZE                            0x0083
#define WM_NCHITTEST                             0x0084
#define WM_NCPAINT                               0x0085
#define WM_NCACTIVATE                            0x0086
#define WM_GETDLGCODE                            0x0087
#define WM_SYNCPAINT                             0x0088
#define WM_NCMOUSEMOVE                           0x00A0
#define WM_NCLBUTTONDOWN                         0x00A1
#define WM_NCLBUTTONUP                           0x00A2
#define WM_NCLBUTTONDBLCLK                       0x00A3
#define WM_NCRBUTTONDOWN                         0x00A4
#define WM_NCRBUTTONUP                           0x00A5
#define WM_NCRBUTTONDBLCLK                       0x00A6
#define WM_NCMBUTTONDOWN                         0x00A7
#define WM_NCMBUTTONUP                           0x00A8
#define WM_NCMBUTTONDBLCLK                       0x00A9
#define WM_KEYFIRST                              0x0100
#define WM_KEYDOWN                               0x0100
#define WM_KEYUP                                 0x0101
#define WM_CHAR                                  0x0102
#define WM_DEADCHAR                              0x0103
#define WM_SYSKEYDOWN                            0x0104
#define WM_SYSKEYUP                              0x0105
#define WM_SYSCHAR                               0x0106
#define WM_SYSDEADCHAR                           0x0107
#define WM_KEYLAST                               0x0108
#define WM_INITDIALOG                            0x0110
#define WM_COMMAND                               0x0111
#define WM_SYSCOMMAND                            0x0112
#define WM_TIMER                                 0x0113
#define WM_HSCROLL                               0x0114
#define WM_VSCROLL                               0x0115
#define WM_INITMENU                              0x0116
#define WM_INITMENUPOPUP                         0x0117
#define WM_MENUSELECT                            0x011F
#define WM_MENUCHAR                              0x0120
#define WM_ENTERIDLE                             0x0121
#define WM_MENURBUTTONUP                         0x0122
#define WM_MENUDRAG                              0x0123
#define WM_MENUGETOBJECT                         0x0124
#define WM_UNINITMENUPOPUP                       0x0125
#define WM_MENUCOMMAND                           0x0126
#define WM_CTLCOLORMSGBOX                        0x0132
#define WM_CTLCOLOREDIT                          0x0133
#define WM_CTLCOLORLISTBOX                       0x0134
#define WM_CTLCOLORBTN                           0x0135
#define WM_CTLCOLORDLG                           0x0136
#define WM_CTLCOLORSCROLLBAR                     0x0137
#define WM_CTLCOLORSTATIC                        0x0138
#define WM_MOUSEFIRST                            0x0200
#define WM_MOUSEMOVE                             0x0200
#define WM_LBUTTONDOWN                           0x0201
#define WM_LBUTTONUP                             0x0202
#define WM_LBUTTONDBLCLK                         0x0203
#define WM_RBUTTONDOWN                           0x0204
#define WM_RBUTTONUP                             0x0205
#define WM_RBUTTONDBLCLK                         0x0206
#define WM_MBUTTONDOWN                           0x0207
#define WM_MBUTTONUP                             0x0208
#define WM_MBUTTONDBLCLK                         0x0209
#define WM_PARENTNOTIFY                          0x0210
#define WM_ENTERMENULOOP                         0x0211
#define WM_EXITMENULOOP                          0x0212
#define WM_NEXTMENU                              0x0213
#define WM_SIZING                                0x0214
#define WM_CAPTURECHANGED                        0x0215
#define WM_MOVING                                0x0216
#define WM_DEVICECHANGE                          0x0219
#define WM_MDICREATE                             0x0220
#define WM_MDIDESTROY                            0x0221
#define WM_MDIACTIVATE                           0x0222
#define WM_MDIRESTORE                            0x0223
#define WM_MDINEXT                               0x0224
#define WM_MDIMAXIMIZE                           0x0225
#define WM_MDITILE                               0x0226
#define WM_MDICASCADE                            0x0227
#define WM_MDIICONARRANGE                        0x0228
#define WM_MDIGETACTIVE                          0x0229
#define WM_MDISETMENU                            0x0230
#define WM_ENTERSIZEMOVE                         0x0231
#define WM_EXITSIZEMOVE                          0x0232
#define WM_DROPFILES                             0x0233
#define WM_MDIREFRESHMENU                        0x0234
#define WM_MOUSEHOVER                            0x02A1
#define WM_MOUSELEAVE                            0x02A3
#define WM_CUT                                   0x0300
#define WM_COPY                                  0x0301
#define WM_PASTE                                 0x0302
#define WM_CLEAR                                 0x0303
#define WM_UNDO                                  0x0304
#define WM_RENDERFORMAT                          0x0305
#define WM_RENDERALLFORMATS                      0x0306
#define WM_DESTROYCLIPBOARD                      0x0307
#define WM_DRAWCLIPBOARD                         0x0308
#define WM_PAINTCLIPBOARD                        0x0309
#define WM_VSCROLLCLIPBOARD                      0x030A
#define WM_SIZECLIPBOARD                         0x030B
#define WM_ASKCBFORMATNAME                       0x030C
#define WM_CHANGECBCHAIN                         0x030D
#define WM_HSCROLLCLIPBOARD                      0x030E
#define WM_QUERYNEWPALETTE                       0x030F
#define WM_PALETTEISCHANGING                     0x0310
#define WM_PALETTECHANGED                        0x0311
#define WM_HOTKEY                                0x0312
#define WM_PRINT                                 0x0317
#define WM_PRINTCLIENT                           0x0318
#define WM_HANDHELDFIRST                         0x0358
#define WM_HANDHELDLAST                          0x035F
#define WM_AFXFIRST                              0x0360
#define WM_AFXLAST                               0x037F
#define WM_PENWINFIRST                           0x0380
#define WM_PENWINLAST                            0x038F
#define WM_APP                                   0x8000


// Mouse events
#define MOUSEEVENTF_MOVE                         0x0001     // mouse move
#define MOUSEEVENTF_LEFTDOWN                     0x0002     // left button down
#define MOUSEEVENTF_LEFTUP                       0x0004     // left button up
#define MOUSEEVENTF_RIGHTDOWN                    0x0008     // right button down
#define MOUSEEVENTF_RIGHTUP                      0x0010     // right button up
#define MOUSEEVENTF_MIDDLEDOWN                   0x0020     // middle button down
#define MOUSEEVENTF_MIDDLEUP                     0x0040     // middle button up
#define MOUSEEVENTF_WHEEL                        0x0800     // wheel button rolled
#define MOUSEEVENTF_ABSOLUTE                     0x8000     // absolute move


// Process creation flags, see CreateProcess()
#define DEBUG_PROCESS                            0x00000001
#define DEBUG_ONLY_THIS_PROCESS                  0x00000002
#define CREATE_SUSPENDED                         0x00000004
#define DETACHED_PROCESS                         0x00000008
#define CREATE_NEW_CONSOLE                       0x00000010
#define CREATE_NEW_PROCESS_GROUP                 0x00000200
#define CREATE_UNICODE_ENVIRONMENT               0x00000400
#define CREATE_SEPARATE_WOW_VDM                  0x00000800
#define CREATE_SHARED_WOW_VDM                    0x00001000
#define INHERIT_PARENT_AFFINITY                  0x00010000
#define CREATE_PROTECTED_PROCESS                 0x00040000
#define EXTENDED_STARTUPINFO_PRESENT             0x00080000
#define CREATE_BREAKAWAY_FROM_JOB                0x01000000
#define CREATE_PRESERVE_CODE_AUTHZ_LEVEL         0x02000000
#define CREATE_DEFAULT_ERROR_MODE                0x04000000
#define CREATE_NO_WINDOW                         0x08000000


// Process priority flags, see CreateProcess()
#define IDLE_PRIORITY_CLASS                      0x00000040
#define BELOW_NORMAL_PRIORITY_CLASS              0x00004000
#define NORMAL_PRIORITY_CLASS                    0x00000020
#define ABOVE_NORMAL_PRIORITY_CLASS              0x00008000
#define HIGH_PRIORITY_CLASS                      0x00000080
#define REALTIME_PRIORITY_CLASS                  0x00000100


// ShowWindow() commands (keine Flags)
#define SW_SHOW                           5  // Activates the window and displays it in its current size and position.
#define SW_SHOWNA                         8  // Displays the window in its current size and position. Similar to SW_SHOW, except that the window is not activated.
#define SW_HIDE                           0  // Hides the window and activates another window.

#define SW_SHOWMAXIMIZED                  3  // Activates the window and displays it as a maximized window.
#define SW_MAXIMIZE        SW_SHOWMAXIMIZED

#define SW_SHOWMINIMIZED                  2  // Activates the window and displays it as a minimized window.
#define SW_SHOWMINNOACTIVE                7  // Displays the window as a minimized window. Similar to SW_SHOWMINIMIZED, except the window is not activated.
#define SW_MINIMIZE                       6  // Minimizes the specified window and activates the next top-level window in the Z order.
#define SW_FORCEMINIMIZE                 11  // Minimizes a window, even if the thread that owns the window is not responding. This flag should only be used when
#define SW_MAX             SW_FORCEMINIMIZE  // minimizing windows from a different thread.

#define SW_SHOWNORMAL                     1  // Activates and displays a window. If the window is minimized or maximized, Windows restores it to its original size and
#define SW_NORMAL             SW_SHOWNORMAL  // position. An application should specify this flag when displaying the window for the first time.
#define SW_SHOWNOACTIVATE                 4  // Displays a window in its most recent size and position. Similar to SW_SHOWNORMAL, except that the window is not activated.
#define SW_RESTORE                        9  // Activates and displays the window. If the window is minimized or maximized, Windows restores it to its original size and
                                             // position. An application should specify this flag when restoring a minimized window.

#define SW_SHOWDEFAULT                   10  // Sets the show state based on the SW_ flag specified in the STARTUPINFO structure passed to the CreateProcess() function by
                                             // the program that started the application.


// ShellExecute() error codes
#define SE_ERR_FNF                                    2     // File not found.
#define SE_ERR_PNF                                    3     // Path not found.
#define SE_ERR_ACCESSDENIED                           5     // Access denied.
#define SE_ERR_OOM                                    8     // Out of memory.
#define SE_ERR_SHARE                                 26     // A sharing violation occurred.
#define SE_ERR_ASSOCINCOMPLETE                       27     // file association information incomplete or invalid.
#define SE_ERR_DDETIMEOUT                            28     // DDE operation timed out.
#define SE_ERR_DDEFAIL                               29     // DDE operation failed.
#define SE_ERR_DDEBUSY                               30     // DDE operation is busy.
#define SE_ERR_NOASSOC                               31     // File association not available.
#define SE_ERR_DLLNOTFOUND                           32     // Dynamic-link library not found.


// STARTUPINFO structure flags
#define STARTF_FORCEONFEEDBACK               0x00000040
#define STARTF_FORCEOFFFEEDBACK              0x00000080
#define STARTF_PREVENTPINNING                0x00002000
#define STARTF_RUNFULLSCREEN                 0x00000020
#define STARTF_TITLEISAPPID                  0x00001000
#define STARTF_TITLEISLINKNAME               0x00000800
#define STARTF_USECOUNTCHARS                 0x00000008
#define STARTF_USEFILLATTRIBUTE              0x00000010
#define STARTF_USEHOTKEY                     0x00000200
#define STARTF_USEPOSITION                   0x00000004
#define STARTF_USESHOWWINDOW                 0x00000001
#define STARTF_USESIZE                       0x00000002
#define STARTF_USESTDHANDLES                 0x00000100


// Wait function constants, see WaitForSingleObject()
#define WAIT_ABANDONED                       0x00000080
#define WAIT_OBJECT_0                        0x00000000
#define WAIT_TIMEOUT                         0x00000102
#define WAIT_FAILED                          0xFFFFFFFF
#define INFINITE                             0xFFFFFFFF     // infinite timeout


// Windows error codes
#define ERROR_SUCCESS                                 0
#define NO_ERROR                          ERROR_SUCCESS
#define ERROR_INVALID_FUNCTION                        1
#define ERROR_FILE_NOT_FOUND                          2
#define ERROR_PATH_NOT_FOUND                          3
#define ERROR_TOO_MANY_OPEN_FILES                     4
#define ERROR_ACCESS_DENIED                           5
#define ERROR_INVALID_HANDLE                          6
#define ERROR_ARENA_TRASHED                           7
#define ERROR_NOT_ENOUGH_MEMORY                       8
#define ERROR_INVALID_BLOCK                           9
#define ERROR_BAD_ENVIRONMENT                        10
#define ERROR_BAD_FORMAT                             11
#define ERROR_INVALID_ACCESS                         12
#define ERROR_INVALID_DATA                           13
#define ERROR_OUTOFMEMORY                            14
#define ERROR_INVALID_DRIVE                          15
#define ERROR_CURRENT_DIRECTORY                      16
#define ERROR_NOT_SAME_DEVICE                        17
#define ERROR_NO_MORE_FILES                          18
#define ERROR_WRITE_PROTECT                          19
#define ERROR_BAD_UNIT                               20
#define ERROR_NOT_READY                              21
#define ERROR_BAD_COMMAND                            22
#define ERROR_CRC                                    23
#define ERROR_BAD_LENGTH                             24
#define ERROR_SEEK                                   25
#define ERROR_NOT_DOS_DISK                           26
#define ERROR_SECTOR_NOT_FOUND                       27
#define ERROR_OUT_OF_PAPER                           28
#define ERROR_WRITE_FAULT                            29
#define ERROR_READ_FAULT                             30
#define ERROR_GEN_FAILURE                            31
#define ERROR_SHARING_VIOLATION                      32
#define ERROR_LOCK_VIOLATION                         33
#define ERROR_WRONG_DISK                             34
#define ERROR_SHARING_BUFFER_EXCEEDED                36
#define ERROR_HANDLE_EOF                             38
#define ERROR_HANDLE_DISK_FULL                       39
#define ERROR_NOT_SUPPORTED                          50
#define ERROR_REM_NOT_LIST                           51
#define ERROR_DUP_NAME                               52
#define ERROR_BAD_NETPATH                            53
#define ERROR_NETWORK_BUSY                           54
#define ERROR_DEV_NOT_EXIST                          55
#define ERROR_TOO_MANY_CMDS                          56
#define ERROR_ADAP_HDW_ERR                           57
#define ERROR_BAD_NET_RESP                           58
#define ERROR_UNEXP_NET_ERR                          59
#define ERROR_BAD_REM_ADAP                           60
#define ERROR_PRINTQ_FULL                            61
#define ERROR_NO_SPOOL_SPACE                         62
#define ERROR_PRINT_CANCELLED                        63
#define ERROR_NETNAME_DELETED                        64
#define ERROR_NETWORK_ACCESS_DENIED                  65
#define ERROR_BAD_DEV_TYPE                           66
#define ERROR_BAD_NET_NAME                           67
#define ERROR_TOO_MANY_NAMES                         68
#define ERROR_TOO_MANY_SESS                          69
#define ERROR_SHARING_PAUSED                         70
#define ERROR_REQ_NOT_ACCEP                          71
#define ERROR_REDIR_PAUSED                           72
#define ERROR_FILE_EXISTS                            80
#define ERROR_CANNOT_MAKE                            82
#define ERROR_FAIL_I24                               83
#define ERROR_OUT_OF_STRUCTURES                      84
#define ERROR_ALREADY_ASSIGNED                       85
#define ERROR_INVALID_PASSWORD                       86
#define ERROR_INVALID_PARAMETER                      87
#define ERROR_NET_WRITE_FAULT                        88
#define ERROR_NO_PROC_SLOTS                          89
#define ERROR_TOO_MANY_SEMAPHORES                   100
#define ERROR_EXCL_SEM_ALREADY_OWNED                101
#define ERROR_SEM_IS_SET                            102
#define ERROR_TOO_MANY_SEM_REQUESTS                 103
#define ERROR_INVALID_AT_INTERRUPT_TIME             104
#define ERROR_SEM_OWNER_DIED                        105
#define ERROR_SEM_USER_LIMIT                        106
#define ERROR_DISK_CHANGE                           107
#define ERROR_DRIVE_LOCKED                          108
#define ERROR_BROKEN_PIPE                           109
#define ERROR_OPEN_FAILED                           110
#define ERROR_BUFFER_OVERFLOW                       111
#define ERROR_DISK_FULL                             112
#define ERROR_NO_MORE_SEARCH_HANDLES                113
#define ERROR_INVALID_TARGET_HANDLE                 114
#define ERROR_INVALID_CATEGORY                      117
#define ERROR_INVALID_VERIFY_SWITCH                 118
#define ERROR_BAD_DRIVER_LEVEL                      119
#define ERROR_CALL_NOT_IMPLEMENTED                  120
#define ERROR_SEM_TIMEOUT                           121
#define ERROR_INSUFFICIENT_BUFFER                   122
#define ERROR_INVALID_NAME                          123
#define ERROR_INVALID_LEVEL                         124
#define ERROR_NO_VOLUME_LABEL                       125
#define ERROR_MOD_NOT_FOUND                         126
#define ERROR_PROC_NOT_FOUND                        127
#define ERROR_WAIT_NO_CHILDREN                      128
#define ERROR_CHILD_NOT_COMPLETE                    129
#define ERROR_DIRECT_ACCESS_HANDLE                  130
#define ERROR_NEGATIVE_SEEK                         131
#define ERROR_SEEK_ON_DEVICE                        132
#define ERROR_IS_JOIN_TARGET                        133
#define ERROR_IS_JOINED                             134
#define ERROR_IS_SUBSTED                            135
#define ERROR_NOT_JOINED                            136
#define ERROR_NOT_SUBSTED                           137
#define ERROR_JOIN_TO_JOIN                          138
#define ERROR_SUBST_TO_SUBST                        139
#define ERROR_JOIN_TO_SUBST                         140
#define ERROR_SUBST_TO_JOIN                         141
#define ERROR_BUSY_DRIVE                            142
#define ERROR_SAME_DRIVE                            143
#define ERROR_DIR_NOT_ROOT                          144
#define ERROR_DIR_NOT_EMPTY                         145
#define ERROR_IS_SUBST_PATH                         146
#define ERROR_IS_JOIN_PATH                          147
#define ERROR_PATH_BUSY                             148
#define ERROR_IS_SUBST_TARGET                       149
#define ERROR_SYSTEM_TRACE                          150
#define ERROR_INVALID_EVENT_COUNT                   151
#define ERROR_TOO_MANY_MUXWAITERS                   152
#define ERROR_INVALID_LIST_FORMAT                   153
#define ERROR_LABEL_TOO_LONG                        154
#define ERROR_TOO_MANY_TCBS                         155
#define ERROR_SIGNAL_REFUSED                        156
#define ERROR_DISCARDED                             157
#define ERROR_NOT_LOCKED                            158
#define ERROR_BAD_THREADID_ADDR                     159
#define ERROR_BAD_ARGUMENTS                         160
#define ERROR_BAD_PATHNAME                          161
#define ERROR_SIGNAL_PENDING                        162
#define ERROR_MAX_THRDS_REACHED                     164
#define ERROR_LOCK_FAILED                           167
#define ERROR_BUSY                                  170
#define ERROR_CANCEL_VIOLATION                      173
#define ERROR_ATOMIC_LOCKS_NOT_SUPPORTED            174
#define ERROR_INVALID_SEGMENT_NUMBER                180
#define ERROR_INVALID_ORDINAL                       182
#define ERROR_ALREADY_EXISTS                        183
#define ERROR_INVALID_FLAG_NUMBER                   186
#define ERROR_SEM_NOT_FOUND                         187
#define ERROR_INVALID_STARTING_CODESEG              188
#define ERROR_INVALID_STACKSEG                      189
#define ERROR_INVALID_MODULETYPE                    190
#define ERROR_INVALID_EXE_SIGNATURE                 191
#define ERROR_EXE_MARKED_INVALID                    192
#define ERROR_BAD_EXE_FORMAT                        193
#define ERROR_ITERATED_DATA_EXCEEDS_64k             194
#define ERROR_INVALID_MINALLOCSIZE                  195
#define ERROR_DYNLINK_FROM_INVALID_RING             196
#define ERROR_IOPL_NOT_ENABLED                      197
#define ERROR_INVALID_SEGDPL                        198
#define ERROR_AUTODATASEG_EXCEEDS_64k               199
#define ERROR_RING2SEG_MUST_BE_MOVABLE              200
#define ERROR_RELOC_CHAIN_XEEDS_SEGLIM              201
#define ERROR_INFLOOP_IN_RELOC_CHAIN                202
#define ERROR_ENVVAR_NOT_FOUND                      203
#define ERROR_NO_SIGNAL_SENT                        205
#define ERROR_FILENAME_EXCED_RANGE                  206
#define ERROR_RING2_STACK_IN_USE                    207
#define ERROR_META_EXPANSION_TOO_LONG               208
#define ERROR_INVALID_SIGNAL_NUMBER                 209
#define ERROR_THREAD_1_INACTIVE                     210
#define ERROR_LOCKED                                212
#define ERROR_TOO_MANY_MODULES                      214
#define ERROR_NESTING_NOT_ALLOWED                   215
#define ERROR_EXE_MACHINE_TYPE_MISMATCH             216
#define ERROR_BAD_PIPE                              230
#define ERROR_PIPE_BUSY                             231
#define ERROR_NO_DATA                               232
#define ERROR_PIPE_NOT_CONNECTED                    233
#define ERROR_MORE_DATA                             234
#define ERROR_VC_DISCONNECTED                       240
#define ERROR_INVALID_EA_NAME                       254
#define ERROR_EA_LIST_INCONSISTENT                  255
#define ERROR_NO_MORE_ITEMS                         259
#define ERROR_CANNOT_COPY                           266
#define ERROR_DIRECTORY                             267
#define ERROR_EAS_DIDNT_FIT                         275
#define ERROR_EA_FILE_CORRUPT                       276
#define ERROR_EA_TABLE_FULL                         277
#define ERROR_INVALID_EA_HANDLE                     278
#define ERROR_EAS_NOT_SUPPORTED                     282
#define ERROR_NOT_OWNER                             288
#define ERROR_TOO_MANY_POSTS                        298
#define ERROR_PARTIAL_COPY                          299
#define ERROR_OPLOCK_NOT_GRANTED                    300
#define ERROR_INVALID_OPLOCK_PROTOCOL               301
#define ERROR_MR_MID_NOT_FOUND                      317
#define ERROR_INVALID_ADDRESS                       487
#define ERROR_ARITHMETIC_OVERFLOW                   534
#define ERROR_PIPE_CONNECTED                        535
#define ERROR_PIPE_LISTENING                        536
#define ERROR_EA_ACCESS_DENIED                      994
#define ERROR_OPERATION_ABORTED                     995
#define ERROR_IO_INCOMPLETE                         996
#define ERROR_IO_PENDING                            997
#define ERROR_NOACCESS                              998
#define ERROR_SWAPERROR                             999
#define ERROR_STACK_OVERFLOW                       1001
#define ERROR_INVALID_MESSAGE                      1002
#define ERROR_CAN_NOT_COMPLETE                     1003
#define ERROR_INVALID_FLAGS                        1004
#define ERROR_UNRECOGNIZED_VOLUME                  1005
#define ERROR_FILE_INVALID                         1006
#define ERROR_FULLSCREEN_MODE                      1007
#define ERROR_NO_TOKEN                             1008
#define ERROR_BADDB                                1009
#define ERROR_BADKEY                               1010
#define ERROR_CANTOPEN                             1011
#define ERROR_CANTREAD                             1012
#define ERROR_CANTWRITE                            1013
#define ERROR_REGISTRY_RECOVERED                   1014
#define ERROR_REGISTRY_CORRUPT                     1015
#define ERROR_REGISTRY_IO_FAILED                   1016
#define ERROR_NOT_REGISTRY_FILE                    1017
#define ERROR_KEY_DELETED                          1018
#define ERROR_NO_LOG_SPACE                         1019
#define ERROR_KEY_HAS_CHILDREN                     1020
#define ERROR_CHILD_MUST_BE_VOLATILE               1021
#define ERROR_NOTIFY_ENUM_DIR                      1022
#define ERROR_DEPENDENT_SERVICES_RUNNING           1051
#define ERROR_INVALID_SERVICE_CONTROL              1052
#define ERROR_SERVICE_REQUEST_TIMEOUT              1053
#define ERROR_SERVICE_NO_THREAD                    1054
#define ERROR_SERVICE_DATABASE_LOCKED              1055
#define ERROR_SERVICE_ALREADY_RUNNING              1056
#define ERROR_INVALID_SERVICE_ACCOUNT              1057
#define ERROR_SERVICE_DISABLED                     1058
#define ERROR_CIRCULAR_DEPENDENCY                  1059
#define ERROR_SERVICE_DOES_NOT_EXIST               1060
#define ERROR_SERVICE_CANNOT_ACCEPT_CTRL           1061
#define ERROR_SERVICE_NOT_ACTIVE                   1062
#define ERROR_FAILED_SERVICE_CONTROLLER_CONNECT    1063
#define ERROR_EXCEPTION_IN_SERVICE                 1064
#define ERROR_DATABASE_DOES_NOT_EXIST              1065
#define ERROR_SERVICE_SPECIFIC_ERROR               1066
#define ERROR_PROCESS_ABORTED                      1067
#define ERROR_SERVICE_DEPENDENCY_FAIL              1068
#define ERROR_SERVICE_LOGON_FAILED                 1069
#define ERROR_SERVICE_START_HANG                   1070
#define ERROR_INVALID_SERVICE_LOCK                 1071
#define ERROR_SERVICE_MARKED_FOR_DELETE            1072
#define ERROR_SERVICE_EXISTS                       1073
#define ERROR_ALREADY_RUNNING_LKG                  1074
#define ERROR_SERVICE_DEPENDENCY_DELETED           1075
#define ERROR_BOOT_ALREADY_ACCEPTED                1076
#define ERROR_SERVICE_NEVER_STARTED                1077
#define ERROR_DUPLICATE_SERVICE_NAME               1078
#define ERROR_DIFFERENT_SERVICE_ACCOUNT            1079
#define ERROR_CANNOT_DETECT_DRIVER_FAILURE         1080
#define ERROR_CANNOT_DETECT_PROCESS_ABORT          1081
#define ERROR_NO_RECOVERY_PROGRAM                  1082
#define ERROR_END_OF_MEDIA                         1100
#define ERROR_FILEMARK_DETECTED                    1101
#define ERROR_BEGINNING_OF_MEDIA                   1102
#define ERROR_SETMARK_DETECTED                     1103
#define ERROR_NO_DATA_DETECTED                     1104
#define ERROR_PARTITION_FAILURE                    1105
#define ERROR_INVALID_BLOCK_LENGTH                 1106
#define ERROR_DEVICE_NOT_PARTITIONED               1107
#define ERROR_UNABLE_TO_LOCK_MEDIA                 1108
#define ERROR_UNABLE_TO_UNLOAD_MEDIA               1109
#define ERROR_MEDIA_CHANGED                        1110
#define ERROR_BUS_RESET                            1111
#define ERROR_NO_MEDIA_IN_DRIVE                    1112
#define ERROR_NO_UNICODE_TRANSLATION               1113
#define ERROR_DLL_INIT_FAILED                      1114
#define ERROR_SHUTDOWN_IN_PROGRESS                 1115
#define ERROR_NO_SHUTDOWN_IN_PROGRESS              1116
#define ERROR_IO_DEVICE                            1117
#define ERROR_SERIAL_NO_DEVICE                     1118
#define ERROR_IRQ_BUSY                             1119
#define ERROR_MORE_WRITES                          1120
#define ERROR_COUNTER_TIMEOUT                      1121
#define ERROR_FLOPPY_ID_MARK_NOT_FOUND             1122
#define ERROR_FLOPPY_WRONG_CYLINDER                1123
#define ERROR_FLOPPY_UNKNOWN_ERROR                 1124
#define ERROR_FLOPPY_BAD_REGISTERS                 1125
#define ERROR_DISK_RECALIBRATE_FAILED              1126
#define ERROR_DISK_OPERATION_FAILED                1127
#define ERROR_DISK_RESET_FAILED                    1128
#define ERROR_EOM_OVERFLOW                         1129
#define ERROR_NOT_ENOUGH_SERVER_MEMORY             1130
#define ERROR_POSSIBLE_DEADLOCK                    1131
#define ERROR_MAPPED_ALIGNMENT                     1132
#define ERROR_SET_POWER_STATE_VETOED               1140
#define ERROR_SET_POWER_STATE_FAILED               1141
#define ERROR_TOO_MANY_LINKS                       1142
#define ERROR_OLD_WIN_VERSION                      1150
#define ERROR_APP_WRONG_OS                         1151
#define ERROR_SINGLE_INSTANCE_APP                  1152
#define ERROR_RMODE_APP                            1153
#define ERROR_INVALID_DLL                          1154
#define ERROR_NO_ASSOCIATION                       1155
#define ERROR_DDE_FAIL                             1156
#define ERROR_DLL_NOT_FOUND                        1157
#define ERROR_NO_MORE_USER_HANDLES                 1158
#define ERROR_MESSAGE_SYNC_ONLY                    1159
#define ERROR_SOURCE_ELEMENT_EMPTY                 1160
#define ERROR_DESTINATION_ELEMENT_FULL             1161
#define ERROR_ILLEGAL_ELEMENT_ADDRESS              1162
#define ERROR_MAGAZINE_NOT_PRESENT                 1163
#define ERROR_DEVICE_REINITIALIZATION_NEEDED       1164
#define ERROR_DEVICE_REQUIRES_CLEANING             1165
#define ERROR_DEVICE_DOOR_OPEN                     1166
#define ERROR_DEVICE_NOT_CONNECTED                 1167
#define ERROR_NOT_FOUND                            1168
#define ERROR_NO_MATCH                             1169
#define ERROR_SET_NOT_FOUND                        1170
#define ERROR_POINT_NOT_FOUND                      1171
#define ERROR_NO_TRACKING_SERVICE                  1172
#define ERROR_NO_VOLUME_ID                         1173

// WinNet32 status codes
#define ERROR_BAD_DEVICE                           1200
#define ERROR_CONNECTION_UNAVAIL                   1201
#define ERROR_DEVICE_ALREADY_REMEMBERED            1202
#define ERROR_NO_NET_OR_BAD_PATH                   1203
#define ERROR_BAD_PROVIDER                         1204
#define ERROR_CANNOT_OPEN_PROFILE                  1205
#define ERROR_BAD_PROFILE                          1206
#define ERROR_NOT_CONTAINER                        1207
#define ERROR_EXTENDED_ERROR                       1208
#define ERROR_INVALID_GROUPNAME                    1209
#define ERROR_INVALID_COMPUTERNAME                 1210
#define ERROR_INVALID_EVENTNAME                    1211
#define ERROR_INVALID_DOMAINNAME                   1212
#define ERROR_INVALID_SERVICENAME                  1213
#define ERROR_INVALID_NETNAME                      1214
#define ERROR_INVALID_SHARENAME                    1215
#define ERROR_INVALID_PASSWORDNAME                 1216
#define ERROR_INVALID_MESSAGENAME                  1217
#define ERROR_INVALID_MESSAGEDEST                  1218
#define ERROR_SESSION_CREDENTIAL_CONFLICT          1219
#define ERROR_REMOTE_SESSION_LIMIT_EXCEEDED        1220
#define ERROR_DUP_DOMAINNAME                       1221
#define ERROR_NO_NETWORK                           1222
#define ERROR_CANCELLED                            1223
#define ERROR_USER_MAPPED_FILE                     1224
#define ERROR_CONNECTION_REFUSED                   1225
#define ERROR_GRACEFUL_DISCONNECT                  1226
#define ERROR_ADDRESS_ALREADY_ASSOCIATED           1227
#define ERROR_ADDRESS_NOT_ASSOCIATED               1228
#define ERROR_CONNECTION_INVALID                   1229
#define ERROR_CONNECTION_ACTIVE                    1230
#define ERROR_NETWORK_UNREACHABLE                  1231
#define ERROR_HOST_UNREACHABLE                     1232
#define ERROR_PROTOCOL_UNREACHABLE                 1233
#define ERROR_PORT_UNREACHABLE                     1234
#define ERROR_REQUEST_ABORTED                      1235
#define ERROR_CONNECTION_ABORTED                   1236
#define ERROR_RETRY                                1237
#define ERROR_CONNECTION_COUNT_LIMIT               1238
#define ERROR_LOGIN_TIME_RESTRICTION               1239
#define ERROR_LOGIN_WKSTA_RESTRICTION              1240
#define ERROR_INCORRECT_ADDRESS                    1241
#define ERROR_ALREADY_REGISTERED                   1242
#define ERROR_SERVICE_NOT_FOUND                    1243
#define ERROR_NOT_AUTHENTICATED                    1244
#define ERROR_NOT_LOGGED_ON                        1245
#define ERROR_CONTINUE                             1246
#define ERROR_ALREADY_INITIALIZED                  1247
#define ERROR_NO_MORE_DEVICES                      1248
#define ERROR_NO_SUCH_SITE                         1249
#define ERROR_DOMAIN_CONTROLLER_EXISTS             1250
#define ERROR_DS_NOT_INSTALLED                     1251
#define ERROR_CONNECTED_OTHER_PASSWORD             2108
#define ERROR_BAD_USERNAME                         2202
#define ERROR_NOT_CONNECTED                        2250
#define ERROR_OPEN_FILES                           2401
#define ERROR_ACTIVE_CONNECTIONS                   2402
#define ERROR_DEVICE_IN_USE                        2404

// Security status codes
#define ERROR_NOT_ALL_ASSIGNED                     1300
#define ERROR_SOME_NOT_MAPPED                      1301
#define ERROR_NO_QUOTAS_FOR_ACCOUNT                1302
#define ERROR_LOCAL_USER_SESSION_KEY               1303
#define ERROR_NULL_LM_PASSWORD                     1304
#define ERROR_UNKNOWN_REVISION                     1305
#define ERROR_REVISION_MISMATCH                    1306
#define ERROR_INVALID_OWNER                        1307
#define ERROR_INVALID_PRIMARY_GROUP                1308
#define ERROR_NO_IMPERSONATION_TOKEN               1309
#define ERROR_CANT_DISABLE_MANDATORY               1310
#define ERROR_NO_LOGON_SERVERS                     1311
#define ERROR_NO_SUCH_LOGON_SESSION                1312
#define ERROR_NO_SUCH_PRIVILEGE                    1313
#define ERROR_PRIVILEGE_NOT_HELD                   1314
#define ERROR_INVALID_ACCOUNT_NAME                 1315
#define ERROR_USER_EXISTS                          1316
#define ERROR_NO_SUCH_USER                         1317
#define ERROR_GROUP_EXISTS                         1318
#define ERROR_NO_SUCH_GROUP                        1319
#define ERROR_MEMBER_IN_GROUP                      1320
#define ERROR_MEMBER_NOT_IN_GROUP                  1321
#define ERROR_LAST_ADMIN                           1322
#define ERROR_WRONG_PASSWORD                       1323
#define ERROR_ILL_FORMED_PASSWORD                  1324
#define ERROR_PASSWORD_RESTRICTION                 1325
#define ERROR_LOGON_FAILURE                        1326
#define ERROR_ACCOUNT_RESTRICTION                  1327
#define ERROR_INVALID_LOGON_HOURS                  1328
#define ERROR_INVALID_WORKSTATION                  1329
#define ERROR_PASSWORD_EXPIRED                     1330
#define ERROR_ACCOUNT_DISABLED                     1331
#define ERROR_NONE_MAPPED                          1332
#define ERROR_TOO_MANY_LUIDS_REQUESTED             1333
#define ERROR_LUIDS_EXHAUSTED                      1334
#define ERROR_INVALID_SUB_AUTHORITY                1335
#define ERROR_INVALID_ACL                          1336
#define ERROR_INVALID_SID                          1337
#define ERROR_INVALID_SECURITY_DESCR               1338
#define ERROR_BAD_INHERITANCE_ACL                  1340
#define ERROR_SERVER_DISABLED                      1341
#define ERROR_SERVER_NOT_DISABLED                  1342
#define ERROR_INVALID_ID_AUTHORITY                 1343
#define ERROR_ALLOTTED_SPACE_EXCEEDED              1344
#define ERROR_INVALID_GROUP_ATTRIBUTES             1345
#define ERROR_BAD_IMPERSONATION_LEVEL              1346
#define ERROR_CANT_OPEN_ANONYMOUS                  1347
#define ERROR_BAD_VALIDATION_CLASS                 1348
#define ERROR_BAD_TOKEN_TYPE                       1349
#define ERROR_NO_SECURITY_ON_OBJECT                1350
#define ERROR_CANT_ACCESS_DOMAIN_INFO              1351
#define ERROR_INVALID_SERVER_STATE                 1352
#define ERROR_INVALID_DOMAIN_STATE                 1353
#define ERROR_INVALID_DOMAIN_ROLE                  1354
#define ERROR_NO_SUCH_DOMAIN                       1355
#define ERROR_DOMAIN_EXISTS                        1356
#define ERROR_DOMAIN_LIMIT_EXCEEDED                1357
#define ERROR_INTERNAL_DB_CORRUPTION               1358
#define ERROR_INTERNAL_ERROR                       1359
#define ERROR_GENERIC_NOT_MAPPED                   1360
#define ERROR_BAD_DESCRIPTOR_FORMAT                1361
#define ERROR_NOT_LOGON_PROCESS                    1362
#define ERROR_LOGON_SESSION_EXISTS                 1363
#define ERROR_NO_SUCH_PACKAGE                      1364
#define ERROR_BAD_LOGON_SESSION_STATE              1365
#define ERROR_LOGON_SESSION_COLLISION              1366
#define ERROR_INVALID_LOGON_TYPE                   1367
#define ERROR_CANNOT_IMPERSONATE                   1368
#define ERROR_RXACT_INVALID_STATE                  1369
#define ERROR_RXACT_COMMIT_FAILURE                 1370
#define ERROR_SPECIAL_ACCOUNT                      1371
#define ERROR_SPECIAL_GROUP                        1372
#define ERROR_SPECIAL_USER                         1373
#define ERROR_MEMBERS_PRIMARY_GROUP                1374
#define ERROR_TOKEN_ALREADY_IN_USE                 1375
#define ERROR_NO_SUCH_ALIAS                        1376
#define ERROR_MEMBER_NOT_IN_ALIAS                  1377
#define ERROR_MEMBER_IN_ALIAS                      1378
#define ERROR_ALIAS_EXISTS                         1379
#define ERROR_LOGON_NOT_GRANTED                    1380
#define ERROR_TOO_MANY_SECRETS                     1381
#define ERROR_SECRET_TOO_LONG                      1382
#define ERROR_INTERNAL_DB_ERROR                    1383
#define ERROR_TOO_MANY_CONTEXT_IDS                 1384
#define ERROR_LOGON_TYPE_NOT_GRANTED               1385
#define ERROR_NT_CROSS_ENCRYPTION_REQUIRED         1386
#define ERROR_NO_SUCH_MEMBER                       1387
#define ERROR_INVALID_MEMBER                       1388
#define ERROR_TOO_MANY_SIDS                        1389
#define ERROR_LM_CROSS_ENCRYPTION_REQUIRED         1390
#define ERROR_NO_INHERITANCE                       1391
#define ERROR_FILE_CORRUPT                         1392
#define ERROR_DISK_CORRUPT                         1393
#define ERROR_NO_USER_SESSION_KEY                  1394
#define ERROR_LICENSE_QUOTA_EXCEEDED               1395

// WinUser error codes
#define ERROR_INVALID_WINDOW_HANDLE                1400
#define ERROR_INVALID_MENU_HANDLE                  1401
#define ERROR_INVALID_CURSOR_HANDLE                1402
#define ERROR_INVALID_ACCEL_HANDLE                 1403
#define ERROR_INVALID_HOOK_HANDLE                  1404
#define ERROR_INVALID_DWP_HANDLE                   1405
#define ERROR_TLW_WITH_WSCHILD                     1406
#define ERROR_CANNOT_FIND_WND_CLASS                1407
#define ERROR_WINDOW_OF_OTHER_THREAD               1408
#define ERROR_HOTKEY_ALREADY_REGISTERED            1409
#define ERROR_CLASS_ALREADY_EXISTS                 1410
#define ERROR_CLASS_DOES_NOT_EXIST                 1411
#define ERROR_CLASS_HAS_WINDOWS                    1412
#define ERROR_INVALID_INDEX                        1413
#define ERROR_INVALID_ICON_HANDLE                  1414
#define ERROR_PRIVATE_DIALOG_INDEX                 1415
#define ERROR_LISTBOX_ID_NOT_FOUND                 1416
#define ERROR_NO_WILDCARD_CHARACTERS               1417
#define ERROR_CLIPBOARD_NOT_OPEN                   1418
#define ERROR_HOTKEY_NOT_REGISTERED                1419
#define ERROR_WINDOW_NOT_DIALOG                    1420
#define ERROR_CONTROL_ID_NOT_FOUND                 1421
#define ERROR_INVALID_COMBOBOX_MESSAGE             1422
#define ERROR_WINDOW_NOT_COMBOBOX                  1423
#define ERROR_INVALID_EDIT_HEIGHT                  1424
#define ERROR_DC_NOT_FOUND                         1425
#define ERROR_INVALID_HOOK_FILTER                  1426
#define ERROR_INVALID_FILTER_PROC                  1427
#define ERROR_HOOK_NEEDS_HMOD                      1428
#define ERROR_GLOBAL_ONLY_HOOK                     1429
#define ERROR_JOURNAL_HOOK_SET                     1430
#define ERROR_HOOK_NOT_INSTALLED                   1431
#define ERROR_INVALID_LB_MESSAGE                   1432
#define ERROR_SETCOUNT_ON_BAD_LB                   1433
#define ERROR_LB_WITHOUT_TABSTOPS                  1434
#define ERROR_DESTROY_OBJECT_OF_OTHER_THREAD       1435
#define ERROR_CHILD_WINDOW_MENU                    1436
#define ERROR_NO_SYSTEM_MENU                       1437
#define ERROR_INVALID_MSGBOX_STYLE                 1438
#define ERROR_INVALID_SPI_VALUE                    1439
#define ERROR_SCREEN_ALREADY_LOCKED                1440
#define ERROR_HWNDS_HAVE_DIFF_PARENT               1441
#define ERROR_NOT_CHILD_WINDOW                     1442
#define ERROR_INVALID_GW_COMMAND                   1443
#define ERROR_INVALID_THREAD_ID                    1444
#define ERROR_NON_MDICHILD_WINDOW                  1445
#define ERROR_POPUP_ALREADY_ACTIVE                 1446
#define ERROR_NO_SCROLLBARS                        1447
#define ERROR_INVALID_SCROLLBAR_RANGE              1448
#define ERROR_INVALID_SHOWWIN_COMMAND              1449
#define ERROR_NO_SYSTEM_RESOURCES                  1450
#define ERROR_NONPAGED_SYSTEM_RESOURCES            1451
#define ERROR_PAGED_SYSTEM_RESOURCES               1452
#define ERROR_WORKING_SET_QUOTA                    1453
#define ERROR_PAGEFILE_QUOTA                       1454
#define ERROR_COMMITMENT_LIMIT                     1455
#define ERROR_MENU_ITEM_NOT_FOUND                  1456
#define ERROR_INVALID_KEYBOARD_HANDLE              1457
#define ERROR_HOOK_TYPE_NOT_ALLOWED                1458
#define ERROR_REQUIRES_INTERACTIVE_WINDOWSTATION   1459
#define ERROR_TIMEOUT                              1460
#define ERROR_INVALID_MONITOR_HANDLE               1461

// Eventlog status codes
#define ERROR_EVENTLOG_FILE_CORRUPT                1500
#define ERROR_EVENTLOG_CANT_START                  1501
#define ERROR_LOG_FILE_FULL                        1502
#define ERROR_EVENTLOG_FILE_CHANGED                1503

// MSI error codes
#define ERROR_INSTALL_SERVICE                      1601
#define ERROR_INSTALL_USEREXIT                     1602
#define ERROR_INSTALL_FAILURE                      1603
#define ERROR_INSTALL_SUSPEND                      1604
#define ERROR_UNKNOWN_PRODUCT                      1605
#define ERROR_UNKNOWN_FEATURE                      1606
#define ERROR_UNKNOWN_COMPONENT                    1607
#define ERROR_UNKNOWN_PROPERTY                     1608
#define ERROR_INVALID_HANDLE_STATE                 1609
#define ERROR_BAD_CONFIGURATION                    1610
#define ERROR_INDEX_ABSENT                         1611
#define ERROR_INSTALL_SOURCE_ABSENT                1612
#define ERROR_BAD_DATABASE_VERSION                 1613
#define ERROR_PRODUCT_UNINSTALLED                  1614
#define ERROR_BAD_QUERY_SYNTAX                     1615
#define ERROR_INVALID_FIELD                        1616

// RPC status codes
#define RPC_S_INVALID_STRING_BINDING               1700
#define RPC_S_WRONG_KIND_OF_BINDING                1701
#define RPC_S_INVALID_BINDING                      1702
#define RPC_S_PROTSEQ_NOT_SUPPORTED                1703
#define RPC_S_INVALID_RPC_PROTSEQ                  1704
#define RPC_S_INVALID_STRING_UUID                  1705
#define RPC_S_INVALID_ENDPOINT_FORMAT              1706
#define RPC_S_INVALID_NET_ADDR                     1707
#define RPC_S_NO_ENDPOINT_FOUND                    1708
#define RPC_S_INVALID_TIMEOUT                      1709
#define RPC_S_OBJECT_NOT_FOUND                     1710
#define RPC_S_ALREADY_REGISTERED                   1711
#define RPC_S_TYPE_ALREADY_REGISTERED              1712
#define RPC_S_ALREADY_LISTENING                    1713
#define RPC_S_NO_PROTSEQS_REGISTERED               1714
#define RPC_S_NOT_LISTENING                        1715
#define RPC_S_UNKNOWN_MGR_TYPE                     1716
#define RPC_S_UNKNOWN_IF                           1717
#define RPC_S_NO_BINDINGS                          1718
#define RPC_S_NO_PROTSEQS                          1719
#define RPC_S_CANT_CREATE_ENDPOINT                 1720
#define RPC_S_OUT_OF_RESOURCES                     1721
#define RPC_S_SERVER_UNAVAILABLE                   1722
#define RPC_S_SERVER_TOO_BUSY                      1723
#define RPC_S_INVALID_NETWORK_OPTIONS              1724
#define RPC_S_NO_CALL_ACTIVE                       1725
#define RPC_S_CALL_FAILED                          1726
#define RPC_S_CALL_FAILED_DNE                      1727
#define RPC_S_PROTOCOL_ERROR                       1728
#define RPC_S_UNSUPPORTED_TRANS_SYN                1730
#define RPC_S_UNSUPPORTED_TYPE                     1732
#define RPC_S_INVALID_TAG                          1733
#define RPC_S_INVALID_BOUND                        1734
#define RPC_S_NO_ENTRY_NAME                        1735
#define RPC_S_INVALID_NAME_SYNTAX                  1736
#define RPC_S_UNSUPPORTED_NAME_SYNTAX              1737
#define RPC_S_UUID_NO_ADDRESS                      1739
#define RPC_S_DUPLICATE_ENDPOINT                   1740
#define RPC_S_UNKNOWN_AUTHN_TYPE                   1741
#define RPC_S_MAX_CALLS_TOO_SMALL                  1742
#define RPC_S_STRING_TOO_LONG                      1743
#define RPC_S_PROTSEQ_NOT_FOUND                    1744
#define RPC_S_PROCNUM_OUT_OF_RANGE                 1745
#define RPC_S_BINDING_HAS_NO_AUTH                  1746
#define RPC_S_UNKNOWN_AUTHN_SERVICE                1747
#define RPC_S_UNKNOWN_AUTHN_LEVEL                  1748
#define RPC_S_INVALID_AUTH_IDENTITY                1749
#define RPC_S_UNKNOWN_AUTHZ_SERVICE                1750
#define EPT_S_INVALID_ENTRY                        1751
#define EPT_S_CANT_PERFORM_OP                      1752
#define EPT_S_NOT_REGISTERED                       1753
#define RPC_S_NOTHING_TO_EXPORT                    1754
#define RPC_S_INCOMPLETE_NAME                      1755
#define RPC_S_INVALID_VERS_OPTION                  1756
#define RPC_S_NO_MORE_MEMBERS                      1757
#define RPC_S_NOT_ALL_OBJS_UNEXPORTED              1758
#define RPC_S_INTERFACE_NOT_FOUND                  1759
#define RPC_S_ENTRY_ALREADY_EXISTS                 1760
#define RPC_S_ENTRY_NOT_FOUND                      1761
#define RPC_S_NAME_SERVICE_UNAVAILABLE             1762
#define RPC_S_INVALID_NAF_ID                       1763
#define RPC_S_CANNOT_SUPPORT                       1764
#define RPC_S_NO_CONTEXT_AVAILABLE                 1765
#define RPC_S_INTERNAL_ERROR                       1766
#define RPC_S_ZERO_DIVIDE                          1767
#define RPC_S_ADDRESS_ERROR                        1768
#define RPC_S_FP_DIV_ZERO                          1769
#define RPC_S_FP_UNDERFLOW                         1770
#define RPC_S_FP_OVERFLOW                          1771
#define RPC_X_NO_MORE_ENTRIES                      1772
#define RPC_X_SS_CHAR_TRANS_OPEN_FAIL              1773
#define RPC_X_SS_CHAR_TRANS_SHORT_FILE             1774
#define RPC_X_SS_IN_NULL_CONTEXT                   1775
#define RPC_X_SS_CONTEXT_DAMAGED                   1777
#define RPC_X_SS_HANDLES_MISMATCH                  1778
#define RPC_X_SS_CANNOT_GET_CALL_HANDLE            1779
#define RPC_X_NULL_REF_POINTER                     1780
#define RPC_X_ENUM_VALUE_OUT_OF_RANGE              1781
#define RPC_X_BYTE_COUNT_TOO_SMALL                 1782
#define RPC_X_BAD_STUB_DATA                        1783
#define ERROR_INVALID_USER_BUFFER                  1784
#define ERROR_UNRECOGNIZED_MEDIA                   1785
#define ERROR_NO_TRUST_LSA_SECRET                  1786
#define ERROR_NO_TRUST_SAM_ACCOUNT                 1787
#define ERROR_TRUSTED_DOMAIN_FAILURE               1788
#define ERROR_TRUSTED_RELATIONSHIP_FAILURE         1789
#define ERROR_TRUST_FAILURE                        1790
#define RPC_S_CALL_IN_PROGRESS                     1791
#define ERROR_NETLOGON_NOT_STARTED                 1792
#define ERROR_ACCOUNT_EXPIRED                      1793
#define ERROR_REDIRECTOR_HAS_OPEN_HANDLES          1794
#define ERROR_PRINTER_DRIVER_ALREADY_INSTALLED     1795
#define ERROR_UNKNOWN_PORT                         1796
#define ERROR_UNKNOWN_PRINTER_DRIVER               1797
#define ERROR_UNKNOWN_PRINTPROCESSOR               1798
#define ERROR_INVALID_SEPARATOR_FILE               1799
#define ERROR_INVALID_PRIORITY                     1800
#define ERROR_INVALID_PRINTER_NAME                 1801
#define ERROR_PRINTER_ALREADY_EXISTS               1802
#define ERROR_INVALID_PRINTER_COMMAND              1803
#define ERROR_INVALID_DATATYPE                     1804
#define ERROR_INVALID_ENVIRONMENT                  1805
#define RPC_S_NO_MORE_BINDINGS                     1806
#define ERROR_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT    1807
#define ERROR_NOLOGON_WORKSTATION_TRUST_ACCOUNT    1808
#define ERROR_NOLOGON_SERVER_TRUST_ACCOUNT         1809
#define ERROR_DOMAIN_TRUST_INCONSISTENT            1810
#define ERROR_SERVER_HAS_OPEN_HANDLES              1811
#define ERROR_RESOURCE_DATA_NOT_FOUND              1812
#define ERROR_RESOURCE_TYPE_NOT_FOUND              1813
#define ERROR_RESOURCE_NAME_NOT_FOUND              1814
#define ERROR_RESOURCE_LANG_NOT_FOUND              1815
#define ERROR_NOT_ENOUGH_QUOTA                     1816
#define RPC_S_NO_INTERFACES                        1817
#define RPC_S_CALL_CANCELLED                       1818
#define RPC_S_BINDING_INCOMPLETE                   1819
#define RPC_S_COMM_FAILURE                         1820
#define RPC_S_UNSUPPORTED_AUTHN_LEVEL              1821
#define RPC_S_NO_PRINC_NAME                        1822
#define RPC_S_NOT_RPC_ERROR                        1823
#define RPC_S_UUID_LOCAL_ONLY                      1824
#define RPC_S_SEC_PKG_ERROR                        1825
#define RPC_S_NOT_CANCELLED                        1826
#define RPC_X_INVALID_ES_ACTION                    1827
#define RPC_X_WRONG_ES_VERSION                     1828
#define RPC_X_WRONG_STUB_VERSION                   1829
#define RPC_X_INVALID_PIPE_OBJECT                  1830
#define RPC_X_WRONG_PIPE_ORDER                     1831
#define RPC_X_WRONG_PIPE_VERSION                   1832
#define RPC_S_GROUP_MEMBER_NOT_FOUND               1898
#define EPT_S_CANT_CREATE                          1899
#define RPC_S_INVALID_OBJECT                       1900
#define ERROR_INVALID_TIME                         1901
#define ERROR_INVALID_FORM_NAME                    1902
#define ERROR_INVALID_FORM_SIZE                    1903
#define ERROR_ALREADY_WAITING                      1904
#define ERROR_PRINTER_DELETED                      1905
#define ERROR_INVALID_PRINTER_STATE                1906
#define ERROR_PASSWORD_MUST_CHANGE                 1907
#define ERROR_DOMAIN_CONTROLLER_NOT_FOUND          1908
#define ERROR_ACCOUNT_LOCKED_OUT                   1909
#define OR_INVALID_OXID                            1910
#define OR_INVALID_OID                             1911
#define OR_INVALID_SET                             1912
#define RPC_S_SEND_INCOMPLETE                      1913
#define RPC_S_INVALID_ASYNC_HANDLE                 1914
#define RPC_S_INVALID_ASYNC_CALL                   1915
#define RPC_X_PIPE_CLOSED                          1916
#define RPC_X_PIPE_DISCIPLINE_ERROR                1917
#define RPC_X_PIPE_EMPTY                           1918
#define ERROR_NO_SITENAME                          1919
#define ERROR_CANT_ACCESS_FILE                     1920
#define ERROR_CANT_RESOLVE_FILENAME                1921
#define ERROR_DS_MEMBERSHIP_EVALUATED_LOCALLY      1922
#define ERROR_DS_NO_ATTRIBUTE_OR_VALUE             1923
#define ERROR_DS_INVALID_ATTRIBUTE_SYNTAX          1924
#define ERROR_DS_ATTRIBUTE_TYPE_UNDEFINED          1925
#define ERROR_DS_ATTRIBUTE_OR_VALUE_EXISTS         1926
#define ERROR_DS_BUSY                              1927
#define ERROR_DS_UNAVAILABLE                       1928
#define ERROR_DS_NO_RIDS_ALLOCATED                 1929
#define ERROR_DS_NO_MORE_RIDS                      1930
#define ERROR_DS_INCORRECT_ROLE_OWNER              1931
#define ERROR_DS_RIDMGR_INIT_ERROR                 1932
#define ERROR_DS_OBJ_CLASS_VIOLATION               1933
#define ERROR_DS_CANT_ON_NON_LEAF                  1934
#define ERROR_DS_CANT_ON_RDN                       1935
#define ERROR_DS_CANT_MOD_OBJ_CLASS                1936
#define ERROR_DS_CROSS_DOM_MOVE_ERROR              1937
#define ERROR_DS_GC_NOT_AVAILABLE                  1938
#define ERROR_NO_BROWSER_SERVERS_FOUND             6118

// OpenGL error codes
#define ERROR_INVALID_PIXEL_FORMAT                 2000
#define ERROR_BAD_DRIVER                           2001
#define ERROR_INVALID_WINDOW_STYLE                 2002
#define ERROR_METAFILE_NOT_SUPPORTED               2003
#define ERROR_TRANSFORM_NOT_SUPPORTED              2004
#define ERROR_CLIPPING_NOT_SUPPORTED               2005

// Image color management error codes
#define ERROR_INVALID_CMM                          2300
#define ERROR_INVALID_PROFILE                      2301
#define ERROR_TAG_NOT_FOUND                        2302
#define ERROR_TAG_NOT_PRESENT                      2303
#define ERROR_DUPLICATE_TAG                        2304
#define ERROR_PROFILE_NOT_ASSOCIATED_WITH_DEVICE   2305
#define ERROR_PROFILE_NOT_FOUND                    2306
#define ERROR_INVALID_COLORSPACE                   2307
#define ERROR_ICM_NOT_ENABLED                      2308
#define ERROR_DELETING_ICM_XFORM                   2309
#define ERROR_INVALID_TRANSFORM                    2310
#define ERROR_UNKNOWN_PRINT_MONITOR                3000
#define ERROR_PRINTER_DRIVER_IN_USE                3001
#define ERROR_SPOOL_FILE_NOT_FOUND                 3002
#define ERROR_SPL_NO_STARTDOC                      3003
#define ERROR_SPL_NO_ADDJOB                        3004
#define ERROR_PRINT_PROCESSOR_ALREADY_INSTALLED    3005
#define ERROR_PRINT_MONITOR_ALREADY_INSTALLED      3006
#define ERROR_INVALID_PRINT_MONITOR                3007
#define ERROR_PRINT_MONITOR_IN_USE                 3008
#define ERROR_PRINTER_HAS_JOBS_QUEUED              3009
#define ERROR_SUCCESS_REBOOT_REQUIRED              3010
#define ERROR_SUCCESS_RESTART_REQUIRED             3011

// WINS error codes
#define ERROR_WINS_INTERNAL                        4000
#define ERROR_CAN_NOT_DEL_LOCAL_WINS               4001
#define ERROR_STATIC_INIT                          4002
#define ERROR_INC_BACKUP                           4003
#define ERROR_FULL_BACKUP                          4004
#define ERROR_REC_NON_EXISTENT                     4005
#define ERROR_RPL_NOT_ALLOWED                      4006

// DHCP error codes
#define ERROR_DHCP_ADDRESS_CONFLICT                4100

// WMI error codes
#define ERROR_WMI_GUID_NOT_FOUND                   4200
#define ERROR_WMI_INSTANCE_NOT_FOUND               4201
#define ERROR_WMI_ITEMID_NOT_FOUND                 4202
#define ERROR_WMI_TRY_AGAIN                        4203
#define ERROR_WMI_DP_NOT_FOUND                     4204
#define ERROR_WMI_UNRESOLVED_INSTANCE_REF          4205
#define ERROR_WMI_ALREADY_ENABLED                  4206
#define ERROR_WMI_GUID_DISCONNECTED                4207
#define ERROR_WMI_SERVER_UNAVAILABLE               4208
#define ERROR_WMI_DP_FAILED                        4209
#define ERROR_WMI_INVALID_MOF                      4210
#define ERROR_WMI_INVALID_REGINFO                  4211

// NT media services error codes
#define ERROR_INVALID_MEDIA                        4300
#define ERROR_INVALID_LIBRARY                      4301
#define ERROR_INVALID_MEDIA_POOL                   4302
#define ERROR_DRIVE_MEDIA_MISMATCH                 4303
#define ERROR_MEDIA_OFFLINE                        4304
#define ERROR_LIBRARY_OFFLINE                      4305
#define ERROR_EMPTY                                4306
#define ERROR_NOT_EMPTY                            4307
#define ERROR_MEDIA_UNAVAILABLE                    4308
#define ERROR_RESOURCE_DISABLED                    4309
#define ERROR_INVALID_CLEANER                      4310
#define ERROR_UNABLE_TO_CLEAN                      4311
#define ERROR_OBJECT_NOT_FOUND                     4312
#define ERROR_DATABASE_FAILURE                     4313
#define ERROR_DATABASE_FULL                        4314
#define ERROR_MEDIA_INCOMPATIBLE                   4315
#define ERROR_RESOURCE_NOT_PRESENT                 4316
#define ERROR_INVALID_OPERATION                    4317
#define ERROR_MEDIA_NOT_AVAILABLE                  4318
#define ERROR_DEVICE_NOT_AVAILABLE                 4319
#define ERROR_REQUEST_REFUSED                      4320

// NT remote storage service error codes
#define ERROR_FILE_OFFLINE                         4350
#define ERROR_REMOTE_STORAGE_NOT_ACTIVE            4351
#define ERROR_REMOTE_STORAGE_MEDIA_ERROR           4352

// NT reparse points error codes
#define ERROR_NOT_A_REPARSE_POINT                  4390
#define ERROR_REPARSE_ATTRIBUTE_CONFLICT           4391

// Cluster error codes
#define ERROR_DEPENDENT_RESOURCE_EXISTS            5001
#define ERROR_DEPENDENCY_NOT_FOUND                 5002
#define ERROR_DEPENDENCY_ALREADY_EXISTS            5003
#define ERROR_RESOURCE_NOT_ONLINE                  5004
#define ERROR_HOST_NODE_NOT_AVAILABLE              5005
#define ERROR_RESOURCE_NOT_AVAILABLE               5006
#define ERROR_RESOURCE_NOT_FOUND                   5007
#define ERROR_SHUTDOWN_CLUSTER                     5008
#define ERROR_CANT_EVICT_ACTIVE_NODE               5009
#define ERROR_OBJECT_ALREADY_EXISTS                5010
#define ERROR_OBJECT_IN_LIST                       5011
#define ERROR_GROUP_NOT_AVAILABLE                  5012
#define ERROR_GROUP_NOT_FOUND                      5013
#define ERROR_GROUP_NOT_ONLINE                     5014
#define ERROR_HOST_NODE_NOT_RESOURCE_OWNER         5015
#define ERROR_HOST_NODE_NOT_GROUP_OWNER            5016
#define ERROR_RESMON_CREATE_FAILED                 5017
#define ERROR_RESMON_ONLINE_FAILED                 5018
#define ERROR_RESOURCE_ONLINE                      5019
#define ERROR_QUORUM_RESOURCE                      5020
#define ERROR_NOT_QUORUM_CAPABLE                   5021
#define ERROR_CLUSTER_SHUTTING_DOWN                5022
#define ERROR_INVALID_STATE                        5023
#define ERROR_RESOURCE_PROPERTIES_STORED           5024
#define ERROR_NOT_QUORUM_CLASS                     5025
#define ERROR_CORE_RESOURCE                        5026
#define ERROR_QUORUM_RESOURCE_ONLINE_FAILED        5027
#define ERROR_QUORUMLOG_OPEN_FAILED                5028
#define ERROR_CLUSTERLOG_CORRUPT                   5029
#define ERROR_CLUSTERLOG_RECORD_EXCEEDS_MAXSIZE    5030
#define ERROR_CLUSTERLOG_EXCEEDS_MAXSIZE           5031
#define ERROR_CLUSTERLOG_CHKPOINT_NOT_FOUND        5032
#define ERROR_CLUSTERLOG_NOT_ENOUGH_SPACE          5033

// EFS error codes
#define ERROR_ENCRYPTION_FAILED                    6000
#define ERROR_DECRYPTION_FAILED                    6001
#define ERROR_FILE_ENCRYPTED                       6002
#define ERROR_NO_RECOVERY_POLICY                   6003
#define ERROR_NO_EFS                               6004
#define ERROR_WRONG_EFS                            6005
#define ERROR_NO_USER_KEYS                         6006
#define ERROR_FILE_NOT_ENCRYPTED                   6007
#define ERROR_NOT_EXPORT_FORMAT                    6008
