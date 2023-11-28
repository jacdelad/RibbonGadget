CompilerIf #PB_Compiler_Processor<>#PB_Processor_x64 And #PB_Compiler_Processor<>#PB_Processor_x86
  CompilerError "Das Modul RibbonGadget funktioniert nur in x86- und x64-Umgebungen!"
CompilerElseIf #PB_Compiler_OS<>#PB_OS_Windows;Voraussetzungen abfragen
  CompilerError "Das Modul RibbonGadget funktioniert leider nur unter Windows!"
CompilerElseIf Not #PB_Compiler_Thread;Programm muss threadsafe sein
  CompilerError "Das Modul RibbonGadget muss im threadsicheren Modus compiliert werden!"
CompilerElseIf #PB_Compiler_Version<570;Mindestversion 5.70, wegen DPI-Erkennung
  CompilerError "Das Modul RibbonGadget muss mindestens mit Compilerversion 5.70 compiliert werden!"
CompilerElseIf #PB_Compiler_Unicode<>1
  CompilerError "Das Modul RibbonGadget muss im Unicode-Modus compiliert werden!"
CompilerEndIf
DeclareModule Ribbon
  Global RibbonDate.s,RibbonVersion.s
  RibbonDate=FormatDate("%yyyy%mm%dd_%hh%ii%ss",#PB_Compiler_Date)
  #RibbonGadget_Version = "0.4.88"
  RibbonVersion=#RibbonGadget_Version
  #RibbonGadget_Status = "Alpha"
  #Ribbon_Color_Auto  = -1
  #Ribbon_Color_Error = -2
  #Ribbon_Image_None  =  0;-1
  #Ribbon_Status_Standard = 0
  #Ribbon_SystemID_Collapser = -1;Anpassen für mehrere Gadgets!
  #Ribbon_SystemID_Sidebar   = -2;Anpassen für mehrere Gadgets! Noch unbenutzt!
  #Ribbon_Event_Dummy = 65535
  #Ribbon_Metric_Standard_AccentStrength = 36
  #Ribbon_Metric_Standard_ScrollPitch    = 64
  #Ribbon_Metric_Standard_Roudnness      =  0
  ;#Ribbon_Metric_SmoothScrollPitch   = -1; Noch unbenutzt (später benutzt um immer zum Anfang/Ende des nächsten Steuerelements zu springen)
  Enumeration      ;Events
    #Ribbon_Event_None
    #Ribbon_Event_LeftClick
    #Ribbon_Event_RightClick
    #Ribbon_Event_LeftDoubleClick
    #Ribbon_Event_RightDoubleClick
    #Ribbon_Event_Hover
    #Ribbon_Event_PopupOpen
    #Ribbon_Event_PopupClose
    #Ribbon_Event_ComboboxChange
    #Ribbon_Event_ScrollDown
    #Ribbon_Event_ScrollUp
  EndEnumeration
  EnumerationBinary;Flags
    #Ribbon_Flag_AutoSize
    #Ribbon_Flag_Collapsible
    #Ribbon_Flag_HoverEvents
    #Ribbon_Flag_FullHover
    #Ribbon_Flag_UseOriginalImagesForCheckboxes
    #Ribbon_Flag_DiscardImages;nur DLL!
    #Ribbon_Flag_GadgetAutoWidth
    #Ribbon_Flag_NoHeader
    #Ribbon_Flag_NoBorder
  EndEnumeration
  Enumeration 1    ;Metric
    #Ribbon_Metric_Collapsed
    #Ribbon_Metric_Roundness
    #Ribbon_Metric_UpdateMode
    #Ribbon_Metric_Color
    #Ribbon_Metric_Style
    #Ribbon_Metric_Disabled
    #Ribbon_Metric_ScrollPitch
    #Ribbon_Metric_BackColor
    #Ribbon_Metric_AccentStrength
    #Ribbon_Metric_ToolTipDelay
    #Ribbon_Metric_ToolTipStyle
    #Ribbon_Metric_FullColor
    #Ribbon_Metric_ScrollWheel
  EndEnumeration
  EnumerationBinary;Popup-Flags
    #Ribbon_Popup_NoAutoClose
    #Ribbon_Popup_RightClick
  EndEnumeration
  Enumeration 0    ;Render
    #Ribbon_Render_NoForce  
    #Ribbon_Render_Force  
  EndEnumeration
  Enumeration -1   ;ScrollWheel
    #Ribbon_ScrollWheel_None
    #Ribbon_ScrollWheel_Auto
    #Ribbon_ScrollWheel_LeftRight
    #Ribbon_ScrollWheel_Category
  EndEnumeration
  Enumeration -1   ;Show
    #Ribbon_Show_Alternate
    #Ribbon_Show_Show
    #Ribbon_Show_Hide
  EndEnumeration
  Enumeration 0    ;Statistic
    #Ribbon_Statistic_RenderCount
    #Ribbon_Statistic_DrawCount
    #Ribbon_Statistic_RenderTime
  EndEnumeration
  EnumerationBinary;Status
    #Ribbon_Status_Deactivated
    #Ribbon_Status_Checked
    #Ribbon_Status_Hidden
    #Ribbon_Status_UseOriginalImage
    #Ribbon_Status_Inbetween
  EndEnumeration
  Enumeration 0    ;Style
    #Ribbon_Style_Auto
    #Ribbon_Style_White
    #Ribbon_Style_Black
  EndEnumeration
  Enumeration      ;SystemIcon
    #Ribbon_SystemIcon_Checked48
    #Ribbon_SystemIcon_Unchecked48
    #Ribbon_SystemIcon_Inbetween48
    #Ribbon_SystemIcon_Checked16
    #Ribbon_SystemIcon_Unchecked16
    #Ribbon_SystemIcon_Inbetween16
    #Ribbon_SystemIcon_Checked
    #Ribbon_SystemIcon_Unchecked
    #Ribbon_SystemIcon_Inbetween
    #Ribbon_SystemIcon_RadioButtonChecked16
    #Ribbon_SystemIcon_RadioButtonUnchecked16
  EndEnumeration
  Enumeration 0    ;ToolTipStyle
    #Ribbon_ToolTipStyle_Box
    #Ribbon_ToolTipStyle_Bubble
  EndEnumeration
  Enumeration 0    ;Type
    #Ribbon_Type_None
    #Ribbon_Type_Category
    #Ribbon_Type_Group
    #Ribbon_Type_Container
    #Ribbon_Type_ButtonContainer
    #Ribbon_Type_Separator
    #Ribbon_Type_Button
    #Ribbon_Type_PushButton
    #Ribbon_Type_Checkbox
    #Ribbon_Type_HeadSeparator
    #Ribbon_Type_HeadButton
    #Ribbon_Type_HeadPushButton
    #Ribbon_Type_RightHeadSeparator
    #Ribbon_Type_RightHeadButton
    #Ribbon_Type_RightHeadPushButton
    #Ribbon_Type_RightHeadText
    #Ribbon_Type_RightHeadTextButton
    #Ribbon_Type_Image
    #Ribbon_Type_ImageButton
    #Ribbon_Type_HeadImage
    #Ribbon_Type_HeadImageButton
    #Ribbon_Type_RightHeadImage
    #Ribbon_Type_RightHeadImageButton
    #Ribbon_Type_RadioButton
    #Ribbon_Type_Combobox
  EndEnumeration
  Enumeration      ;UpdateMode
    #Ribbon_Update_On  = 0
    #Ribbon_Update_Off = 1
  EndEnumeration
  CompilerIf Not Defined(CustomEvent, #PB_Enumeration)
    Enumeration CustomEvent
      #CustomEvent_Base = #PB_Event_FirstCustomValue - 1
    EndEnumeration
  Enumeration #PB_Event_FirstCustomValue
  CompilerEndIf
    #PB_Event_Ribbon
  EndEnumeration
  CompilerIf Not Defined(CustomEventType, #PB_Enumeration)
    Enumeration CustomEventType
      #CustomEventType_Base = #PB_EventType_FirstCustomValue - 1
    EndEnumeration
  CompilerEndIf
  Enumeration CustomEventType
    #PB_EventType_RibbonPopupOpened
    #PB_EventType_RibbonPopupClosed
    #PB_EventType_RibbonComboboxChange
  EndEnumeration
  Declare Render(handle,force=0)
  Declare RemoveItem(id)
  Declare AddItem(parent,id,typ,text.s="",image=#Ribbon_Image_None,status=#Ribbon_Status_Standard)
  Declare GetItemStatus(id)
  Declare GetItemStatusFlag(id,flag)
  Declare.s GetItemText(id)
  Declare SetItemText(id,text.s)
  Declare SetItemToolTip(id,text.s,header.s,symbol.i)
  Declare SetItemStatus(id,status)
  Declare AddItemStatus(id,status)
  Declare SubItemStatus(id,status)
  Declare SetItemImage(id,image)
  Declare GetItemImage(id)
  Declare GetItemType(id)
  Declare GetItemGadget(id)
  Declare Export(filename.s)
  Declare Hide(handle,status=#Ribbon_Show_Alternate)
  Declare RemoveItem(id)
  Declare Remove(handle)
  Declare SetFont(handle,font.s)
  Declare SetItemPosition(id,position)
  Declare GetItemPosition(id)
  Declare SetActiveCategory(id)
  Declare GetActiveCategory(handle)
  Declare GetMetric(handle,metric)
  Declare SetMetric(handle,metric,value)
  Declare SetSystemImage(handle,type,ihandle)
  Declare GetItemCheckStatus(id)
  Declare SetItemCheckStatus(id,status)
  Declare UnlinkPopup(id)
  Declare LinkPopup(id,head.s,w,h,flags=0)
  Declare MoveControlToPopup(id,handle,x,y)
  Declare ResizePopup(id,x,y)
  Declare GetPopupHandle(id)
  Declare ClosePopup()
  Declare AddPopupText(id,x,y,text.s,color=#Ribbon_Color_Auto)
  Declare SetPopupHeadline(id,text.s)
  Declare SetPopupText(id,tid,text.s)
  Declare MovePopupText(id,tid,x,y)
  Declare SetPopupTextColor(id,tid,color)
  Declare RemovePopupText(id,tid)
  Declare Create(parentwindow,id,color=#Ribbon_Color_Auto,backcolor=#Ribbon_Color_Auto,style=#Ribbon_Style_Auto,flags=0)
  Declare DeinitializeModule()
  Declare GetStatistic(ribbon,ribbon_stattype)
  Declare ExtendedLogging(handle,mode=#True)
  CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
    Declare SetCallbackMessage(message)
    Declare GetRibbonHandle(id)
    Declare RibbonResponder(*resp)
    Declare FlushRibbonActivity()
  CompilerEndIf
  CompilerIf #PB_Compiler_Debugger
    Declare StatisticWindow(handle)
  CompilerEndIf
EndDeclareModule
Module Ribbon
  EnableExplicit
  ;PurifierGranularity(1,1,1,1)
  UseBriefLZPacker()
  ExamineDesktops()
  #Mouse_Up   = -1
  #Mouse_Down = -545
  Global Image_Dummy=CreateImage(#PB_Any,48,48,32)
  Procedure ImageID_(MyImage)
     If Not IsImage(MyImage)
      Debug "No ImageID!"
      ProcedureReturn ImageID(Image_Dummy)
    Else
      ProcedureReturn ImageID(MyImage)
    EndIf
  EndProcedure
  Macro ImageID(MyImage)
    ImageID_(MyImage)
  EndMacro
  CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
    Structure RibbonEvent
      Ribbon.i
      id.i
      event.i
      ControlX.i
      ControlY.i
      ControlDX.i
      ControlDY.i
      MouseX.i
      MouseY.i
    EndStructure
    Global NewList RibbonResponse.Ribbonevent(),CallbackMessage
  CompilerEndIf
  Structure HookData
    id.i
    window.i
    canvas.i
  EndStructure
  Structure TextList
    x.i
    y.i
    text.s
    status.i
    color.l
  EndStructure
  Structure PopupList
    window.i
    title.s
    canvas.i
    Region.i
    Flags.l
    List text.TextList()
  EndStructure
  Structure SubItemlist ;Items in Containern und ButtonContainern
    id.i                ;Item-ID
    type.i              ;Item-Typ (#Ribbon_Type_...)
    text.s              ;Text
    ToolTip.s           ;ToolTip
    ToolTipHeader.s     ;ToolTip-Überschrift
    ToolTipSymbol.i     ;ToolTip-Symbol
    image.i             ;Gelinktes Bild
    status.i            ;Status (#Ribbon_Status_...)
    popup.i             ;Angelinktes Popup-Fenster
    x.i                 ;X-Position
    y.i                 ;Y-Position
    dx.i                ;Breite
    dy.i                ;Höhe
    AttachedWindow.i    ;Fenster für Comboboxen
    AttachedGadget.i    ;Liste für Comboboxen
    MainWindow.i        ;Fenster, auf dem das Ribbon ist
    Ribbon.i            ;Handle des Ribbons
  EndStructure
  Structure Itemlist    ;Standard-Items
    id.i                ;Item-ID
    type.i              ;Item-Typ (#Ribbon_Type_...)
    text.s              ;Text
    ToolTip.s           ;ToolTip
    ToolTipHeader.s     ;ToolTip-Überschrift
    ToolTipSymbol.i     ;ToolTip-Symbol
    image.i             ;Gelinktes Bild
    status.i            ;Status (#Ribbon_Status_...)
    popup.i             ;Angelinktes Popup-Fenster
    x.i                 ;X-Position
    y.i                 ;Y-Position
    dx.i                ;Breite
    dy.i                ;Höhe
    maxwidth.i          ;Gesamtbreite bei Multi-Items (Container/ButtonContainer...)
    List SubItems.SubItemlist();Liste von SubItems (für Container und ButtonContainer)
  EndStructure
  Structure Grouplist   ;Gruppen
    id.i
    text.s
    ToolTip.s
    ToolTipHeader.s
    ToolTipSymbol.i
    type.i
    status.i
    visstatus.b
    image.i
    List items.Itemlist()
  EndStructure
  Structure CategoryList;Kategorien (=Tabs)
    Text.s
    ToolTip.s
    ToolTipHeader.s
    ToolTipSymbol.i
    Width.i
    Position.i
    id.i
    type.i
    status.i
    image.i
    x.i
    y.i
    dx.i
    dy.i
    TotalWidth.i
    Padding.i
    LastPadding.i
    LeftButtonActive.b
    RightButtonActive.b
    List Groups.Grouplist()
  EndStructure
  Structure Coordinates
    active.i
    id.i
    oldid.i
    x.i
    y.i
    dx.i
    dy.i
  EndStructure
  Structure LogList
    Timestamp.q
    Type.a
    RenderTime.c
  EndStructure
  Structure RibbonList
    handle.i
    window.i
    thread.i
    x.i
    y.i
    font.i
    smallfont.i
    extrafont.i
    flags.i
    Style.i
    collapsed.i
    disabled.i
    roundness.i
    hidden.i
    noupdate.i
    color.i
    backcolor.i
    accentcolor.i
    offset.i
    RibbonImage.i
    InternalRenderer.i
    MoveRightImage.i
    MoveLeftImage.i
    CategoryWidth.i
    Padding.i
    ScrollPitch.i
    RenderCount.q
    DrawCount.q
    AccentStrength.a
    ToolTipDelay.l
    ToolTipStyle.l
    WheelHook.i
    WheelMode.b
    List headitems.SubItemList()
    List rightheaditems.SubItemList()
    List Categories.CategoryList()
    List Popup.PopupList()
    hover.Coordinates
    Category.i
    UseOriginalImagesForCheckboxes.i
    Map Icons.i()
    List OriginalIcons.i()
    Locked.b
    List LogList.LogList()
    extendedlogging.a
  EndStructure
  Structure ThreadStruct
    x.l
    listelement.l
    window.l
  EndStructure
  Procedure GetTaskBarHeight()
    Protected abd.APPBARDATA,height=0
    SHAppBarMessage_(#ABM_GETTASKBARPOS, abd)
    Select abd\uEdge
      Case #ABE_BOTTOM
        height = abd\rc\bottom - abd\rc\top
      Case #ABE_TOP
        height = abd\rc\bottom
      Case #ABE_LEFT
        height = abd\rc\right - abd\rc\left
      Case #ABE_RIGHT
        height = abd\rc\right - abd\rc\left
    EndSelect
    ProcedureReturn height
  EndProcedure
  Global ribbonid,ribbonevent,ItemGadgetIsVisible,hookthread,*Daten.HookData,Mouse.Point,TaskbarHeight.l=GetTaskBarHeight(),NewList Ribbons.Ribbonlist(),rMutex=CreateMutex()
  Global tooltip_aktuell.s,tooltip_id,ttmutex=CreateMutex(),ttreset,tooltip_delay,tooltip_style,tooltip_header.s,tooltip_symbol,tooltip_window
  Procedure Tooltip(sText.s , sTitel.s = "", iSymbol=#TTI_NONE, iX_Pos.i = #PB_Default, iY_Pos.i = #PB_Default, iMax_Breite.i = #PB_Default, bBallon.i = #False, bSchliessen.i = #False)
    #TTF_ABSOLUTE=$80
    #TTF_TRACK=$20
    #TTS_CLOSE=$80
    #TTS_NOFADE=$20
    Static iTooltip_ID.i = 0,iStyle_aktuell.i	= 0,iX_Pos_aktuell.i = 0,iY_Pos_aktuell.i = 0,sText_aktuell.s = "",sTitel_aktuell.s	= "",sSymbol_aktuell.s = ""
    Protected iUpdate_Inhalt.i = #False,iUpdate_Position.i = #False,iX_Pos_Offset.i = 0,iY_Pos_Offset.i = 0,iStyle.i = #WS_POPUP|#TTS_NOPREFIX|#TTS_ALWAYSTIP|#TTS_NOFADE
    Protected	iExStyle.i = #WS_EX_TOPMOST,lWindowID.l = 0,iInstanz.i = GetModuleHandle_(0),lPosition.l = 0,stParameter.TOOLINFO,stAbmessungen.RECT,temp = 0
    If sText = "" And iTooltip_ID<>0
      DestroyWindow_(iTooltip_ID)
      iTooltip_ID 	= 0
      iStyle_aktuell 	= 0
      iX_Pos_aktuell	= 0
      iY_Pos_aktuell	= 0
      sText_aktuell 	= ""
      sTitel_aktuell 	= ""
      ProcedureReturn 1
    ElseIf sText = "" And iTooltip_ID = 0
      iTooltip_ID 	= 0
      iStyle_aktuell 	= 0
      iX_Pos_aktuell	= 0
      iY_Pos_aktuell	= 0
      sText_aktuell 	= ""
      sTitel_aktuell 	= ""
      ProcedureReturn -1
    EndIf
    If (iX_Pos = #PB_Default) And (bBallon = #True)
      iX_Pos = DesktopMouseX()
      iX_Pos_Offset = 0
    ElseIf (iX_Pos = #PB_Default) And (bBallon = #False)
      iX_Pos 	= DesktopMouseX()
      iX_Pos_Offset = 16
    EndIf
    If iY_Pos = #PB_Default
      iY_Pos = DesktopMouseY()
      iY_Pos_Offset = 0
    EndIf   
    If (iMax_Breite = #PB_Default) Or (iMax_Breite<10)
      iMax_Breite = 400
    EndIf   
    If bBallon = #True
      iStyle|#TTS_BALLOON
    EndIf
    If bSchliessen = #True
      iStyle|#TTS_CLOSE
    EndIf
    If iTooltip_ID = 0
      iTooltip_ID = CreateWindowEx_(iExStyle, #TOOLTIPS_CLASS, #Null, iStyle, 0, 0, 0, 0, lWindowID, 0, iInstanz, 0)
    Else
      If iStyle_aktuell<>iStyle
        DestroyWindow_(iTooltip_ID)
        iTooltip_ID = CreateWindowEx_(iExStyle, #TOOLTIPS_CLASS, #Null, iStyle, 0, 0, 0, 0, lWindowID, 0, iInstanz, 0)
      EndIf
    EndIf
    stParameter.TOOLINFO\cbSize	= SizeOf(TOOLINFO)
    stParameter\uFlags			= #TTF_IDISHWND|#TTF_ABSOLUTE|#TTF_TRACK
    stParameter\hWnd			= lWindowID
    stParameter\uId				= lWindowID
    stParameter\lpszText		= @sText
    stParameter\hInst			= iInstanz
    If (sText<>sText_aktuell) Or (sTitel<>sTitel_aktuell) Or (sText_aktuell = "")
      iUpdate_Inhalt		= #True
    Else
      iUpdate_Inhalt		= #False
    EndIf
    If (iX_Pos<>iX_Pos_aktuell) Or (iY_Pos<>iY_Pos_aktuell)
      iUpdate_Position	= #True
    Else
      iUpdate_Position	= #False
    EndIf
    iStyle_aktuell	= iStyle
    sText_aktuell 	= sText
    sTitel_aktuell 	= sTitel
    iX_Pos_aktuell	= iX_Pos
    iY_Pos_aktuell	= iY_Pos
    If iUpdate_Inhalt=#True
      SendMessage_(iTooltip_ID,#TTM_SETTIPTEXTCOLOR,GetSysColor_(#COLOR_INFOTEXT),0)
      SendMessage_(iTooltip_ID,#TTM_SETTIPBKCOLOR,GetSysColor_(#COLOR_INFOBK),0)
      SendMessage_(iTooltip_ID,#TTM_SETMAXTIPWIDTH,0,iMax_Breite)	
      SendMessage_(iTooltip_ID,#TTM_SETTITLE,iSymbol,@sTitel)
      GetWindowRect_(lWindowID,@stParameter\rect)
      SendMessage_(iTooltip_ID,#TTM_ADDTOOL,0,@stParameter)
      SendMessage_(iTooltip_ID,#TTM_TRACKACTIVATE,1,@stParameter)
      SendMessage_(iTooltip_ID,#TTM_UPDATETIPTEXT,0,@stParameter)		
    EndIf
    If iUpdate_Position=#True
      If (ExamineDesktops()<>0)
        GetWindowRect_(iTooltip_ID,@stAbmessungen)
        If (iX_Pos + iX_Pos_Offset +(stAbmessungen\right - stAbmessungen\left)>DesktopWidth(0))
          iX_Pos = iX_Pos - iX_Pos_Offset - (stAbmessungen\right - stAbmessungen\left)
        Else
          iX_Pos = iX_Pos + iX_Pos_Offset
        EndIf
        If (iY_Pos + iY_Pos_Offset +(stAbmessungen\bottom - stAbmessungen\top)>DesktopHeight(0))
          iY_Pos = iY_Pos - (stAbmessungen\bottom - stAbmessungen\top)
        Else
          iY_Pos = iY_Pos + iY_Pos_Offset
        EndIf
      EndIf
      lPosition = (iX_Pos&$FFFF)|((iY_Pos&$FFFF) << 16)
      SendMessage_	(iTooltip_ID,	#TTM_TRACKPOSITION, 	0, lPosition)
    EndIf
    ProcedureReturn 0
  EndProcedure
  Procedure ToolTipThread(dummy)
    Protected temptip,delayedtime,open,lasttooltip,ignore
    Repeat
      Delay(100)
      LockMutex(ttmutex)
      If ttreset
        delayedtime=0
        ttreset=0
        If ignore>0:ignore-1:EndIf
        If open And ignore<=0
          open=0
          lasttooltip=temptip
          ToolTip("","",#TTI_INFO_LARGE,-1,-1,600,#True)
        EndIf
      Else
        delayedtime+1
      EndIf
      If tooltip_id<>temptip
        temptip=tooltip_id
        delayedtime=0
        If open
          ToolTip("","",#TTI_INFO_LARGE,-1,-1,600,#True)
        EndIf
        open=0
        lasttooltip=0
      ElseIf delayedtime>=tooltip_delay And tooltip_id>0 And Not open And lasttooltip<>temptip And tooltip_aktuell<>""
        If GetActiveWindow()=tooltip_window
          open=1
          ignore=2
          ToolTip(tooltip_aktuell,tooltip_header,tooltip_symbol,-1,-1,600,tooltip_style)
        Else
          ttreset=1
          tooltip_id=0
        EndIf
      EndIf
      UnlockMutex(ttmutex)
    ForEver
  EndProcedure
  Global tooltipthread=CreateThread(@ToolTipThread(),0)
  Procedure LowLevelMouseProc(nCode.l, wParam.l, lParam.l)
    Protected wp.POINT
    If wParam = #WM_MOUSEWHEEL
      ForEach Ribbons()
        ;WindowMouseY wird wohl nicht in der DLL funktionieren...
        If WindowFromPoint_(DesktopMouseX() | DesktopMouseY() << 32)=GadgetID(ribbons()\handle) And WindowMouseY(ribbons()\window)<=GadgetHeight(ribbons()\handle); And wp\x>=0 And wp\x<=WindowWidth(ribbons()\window) And wp\y>=0 And wp\y<=GadgetHeight(ribbons()\handle); And WindowFromPoint_(DesktopMouseX() | DesktopMouseY() << 32) = MouseWheelWindow
          PostMessage_(GadgetID(ribbons()\handle), #PB_EventType_MouseWheel, PeekL(lParam + 8), 0)
          Break
        EndIf
      Next
    EndIf
    ProcedureReturn CallNextHookEx_(Ribbons()\WheelHook, nCode, wParam, lParam)
  EndProcedure
  Procedure AddMouseWheelHook(*Ribbon.RibbonList)
    If *Ribbon\WheelHook=0
      *Ribbon\WheelHook=SetWindowsHookEx_(#WH_MOUSE_LL, @LowLevelMouseProc(), GetModuleHandle_(0), 0)
    EndIf
  EndProcedure
  Procedure RemoveMouseWheelHook(*Ribbon.RibbonList)
    If *Ribbon\WheelHook
      UnhookWindowsHookEx_(*Ribbon\WheelHook)
    EndIf
  EndProcedure
  Procedure FreeImage_(handle)
    If IsImage(handle):FreeImage(handle):EndIf
  EndProcedure
  Macro FreeImage(handle)
    FreeImage_(handle)
  EndMacro
  Macro DrawDeactivatedImage(x,y)
    If IsImage(tempimage)
      DrawAlphaImage(ImageID(tempimage),x,y,128)
      FreeImage(tempimage)
    EndIf
  EndMacro
  Procedure CatchImageEx(*cmem)
    Protected *dmem,csize.l=PeekL(*cmem+4),dsize.l=PeekL(*cmem),handle
    *dmem=AllocateMemory(dsize,#PB_Memory_NoClear)
    UncompressMemory(*cmem+8,csize,*dmem,dsize,#PB_PackerPlugin_BriefLZ)
    handle=CatchImage(#PB_Any,*dmem)
    FreeMemory(*dmem)
    ProcedureReturn handle
  EndProcedure
  Macro AddIcon(name,resource)
    AddElement(ribbons()\originalicons())
    ribbons()\originalicons()=CatchImageEx(resource)
    ribbons()\Icons(name)=ribbons()\originalicons()
  EndMacro
  Macro SetStatusFlags(wo)
    old=wo
    If status&#Ribbon_Status_Checked
      If old&#Ribbon_Status_Inbetween
        old=old&~#Ribbon_Status_Inbetween
      EndIf
    ElseIf status&#Ribbon_Status_Inbetween
      If old&#Ribbon_Status_Checked
        old=old&~#Ribbon_Status_Checked
      EndIf
    EndIf
    wo=status
  EndMacro
  Macro SetCheckFlags(wo)
    old=wo
    ctemp=old&~#Ribbon_Status_Checked&~#Ribbon_Status_Inbetween
    If status&#Ribbon_Status_Checked
      status=status|#Ribbon_Status_Checked
    ElseIf status&#Ribbon_Status_Inbetween
      status=status|#Ribbon_Status_Inbetween
    EndIf
    wo=status
  EndMacro
  Macro GetCheckFlag(wo)
    If wo&#Ribbon_Status_Checked
      old=#Ribbon_Status_Checked
    ElseIf wo&#Ribbon_Status_Inbetween
      old=#Ribbon_Status_Inbetween
    Else
      old=0
    EndIf
  EndMacro
  CompilerIf #PB_Compiler_Version>=600;Limit(n)
    Procedure Limit(n)
      CompilerIf #PB_Compiler_Backend=#PB_Backend_Asm
        !mov eax,dword[p.v_n]
        !xor edx,edx
        !cmp eax,0
        !cmovl eax,edx
        !mov edx,255
        !cmp eax,edx
        !cmovg eax,edx
        ProcedureReturn
      CompilerElse
        If n>255:n=255:ElseIf n<0:n=0:EndIf
        ProcedureReturn n
      CompilerEndIf
    EndProcedure
  CompilerElse
    Procedure Limit(n)
      !mov eax,dword[p.v_n]
      !xor edx,edx
      !cmp eax,0
      !cmovl eax,edx
      !mov edx,255
      !cmp eax,edx
      !cmovg eax,edx
      ProcedureReturn
    EndProcedure
  CompilerEndIf
  Macro RGBD(color,delta)
    RGB(Limit(Red(color)+delta),Limit(Green(color)+delta),Limit(Blue(color)+delta))
  EndMacro
  CompilerIf #PB_Compiler_OS = #PB_OS_MacOS;GetCocoaColor
    Procedure.q GetCocoaColor(ColorName.s)
      Protected.CGFloat r,g,b,a
      NSColor=CocoaMessage(#Null,#Null,"NSColor colorWithCatalogName:$",@"System","colorName:$",@ColorName)
      If NSColor
        NSColor=CocoaMessage(#Null,NSColor,"colorUsingColorSpaceName:$",@"NSCalibratedRGBColorSpace")
        If NSColor
          CocoaMessage(@R.CGFloat, NSColor,"redComponent")
          CocoaMessage(@G.CGFloat, NSColor,"greenComponent")
          CocoaMessage(@B.CGFloat, NSColor,"blueComponent")
          CocoaMessage(@A.CGFloat, NSColor,"alphaComponent")
          ProcedureReturn (RGBA(Int(R*255), Int(G*255), Int(B*255), Int(A*255))&$FFFFFFFF)
        EndIf
      EndIf
      ProcedureReturn (-1)
    EndProcedure
  CompilerEndIf    
  Declare SimpleWindowCloser()
  Declare.s GetItemToolTip(id)
  Declare.s GetItemToolTipHeader(id)
  Declare GetItemToolTipSymbol(id)
  Procedure ExtendedLogging(handle,mode=#True)
    ForEach ribbons()
      If ribbons()\handle=handle
        ribbons()\extendedlogging=mode
        If Not mode
          ClearList(ribbons()\LogList())
        EndIf
        Break
      EndIf
    Next
  EndProcedure
  Procedure Export(filename.s)
    Protected json
    json=CreateJSON(#PB_Any)
    If json
      InsertJSONList(JSONValue(json),ribbons())
      If filename=""
        filename=GetPathPart(ProgramFilename())+"Ribbon.json.txt"
      ElseIf Not FindString(filename,"\")
        filename=GetPathPart(ProgramFilename())+filename
      EndIf
      If SaveJSON(json,filename,#PB_JSON_PrettyPrint)
        FreeJSON(json)
        ProcedureReturn 1
      EndIf
      FreeJSON(json)
    EndIf
    ProcedureReturn 0
  EndProcedure
  Procedure Rectangle(x,xa,xb,y,ya,yb,id,gs)
    If gs<>1 And x>=xa And x<=(xa+xb) And y>=ya And y<=(ya+yb); And hover\id<>id
      With ribbons()\hover
        \active=1
        \id=id
        \x=xa
        \dx=xb
        \y=ya
        \dy=yb
        If ribbonevent<>#Ribbon_Event_None
          ribbonid=id
        EndIf
      EndWith
      ProcedureReturn 1
    Else
      ProcedureReturn 0
    EndIf
  EndProcedure
  Macro DrawRibbonText(x,y,t)
    DrawingMode(#PB_2DDrawing_Transparent)
    DrawText(x,y,t,ribbons()\accentcolor)
  EndMacro
  Procedure SetPointerToItem(id)
    ForEach ribbons()
      ForEach ribbons()\headitems()
        If ribbons()\headitems()\id=id
          ProcedureReturn 5
        EndIf
      Next
      ForEach ribbons()\rightheaditems()
        If ribbons()\rightheaditems()\id=id
          ProcedureReturn 6
        EndIf
      Next
      ForEach ribbons()\Categories()
        If ribbons()\Categories()\id=id
          ProcedureReturn 1
        EndIf
        ForEach ribbons()\Categories()\Groups()
          If ribbons()\Categories()\Groups()\id=id
            ProcedureReturn 2
          EndIf
          ForEach ribbons()\Categories()\Groups()\items()
            If ribbons()\Categories()\Groups()\items()\id=id
              ProcedureReturn 3
            EndIf
            ForEach ribbons()\Categories()\Groups()\items()\SubItems()
              If ribbons()\Categories()\Groups()\items()\SubItems()\id=id
                ProcedureReturn 4
              EndIf
            Next
          Next
        Next
      Next
    Next
    ProcedureReturn 0
  EndProcedure
  Procedure CreatePopupWindow()
    Protected w,h,text.s
    w=GadgetWidth(ribbons()\Popup()\canvas,#PB_Gadget_ActualSize)
    h=GadgetHeight(ribbons()\Popup()\canvas,#PB_Gadget_ActualSize)
    SetWindowLongPtr_(WindowID(ribbons()\popup()\window),#GWL_EXSTYLE, GetWindowLongPtr_(WindowID(ribbons()\popup()\window),#GWL_EXSTYLE) &~#WS_EX_CLIENTEDGE)
    SetWindowPos_(WindowID(ribbons()\popup()\window),0,0,0,0,0,#SWP_NOMOVE|#SWP_NOSIZE|#SWP_NOOWNERZORDER|#SWP_NOACTIVATE|#SWP_FRAMECHANGED)
    Ribbons()\Popup()\Region=CreateRoundRectRgn_(0,0,w+1,h+1,ribbons()\roundness,ribbons()\roundness)
    SetWindowRgn_(WindowID(ribbons()\popup()\window),Ribbons()\Popup()\Region,#True)
    StartDrawing(CanvasOutput(ribbons()\Popup()\canvas))
    Box(0,0,w,h,ribbons()\color)
    Box(0,0,w,22,rgbd(ribbons()\color,-36))
    DrawingMode(#PB_2DDrawing_Outlined)
    RoundBox(0,0,w,h,ribbons()\roundness,ribbons()\roundness,rgbd(ribbons()\color,-56))
    DrawingFont(FontID(ribbons()\font))
    DrawingMode(#PB_2DDrawing_Transparent)
    text=ribbons()\Popup()\title
    h=TextWidth(text)
    If h>(w-8)
      text=text+"..."
      While h>(w-8)
        text=Left(text,Len(text)-4)+"..."
        h=TextWidth(text)
      Wend
    EndIf
    DrawRibbonText(Int((w-h)/2),2,text)
    ForEach ribbons()\Popup()\text()
      If ribbons()\Popup()\text()\status=0
        If ribbons()\Popup()\text()\color=#Ribbon_Color_Auto
          DrawRibbonText(ribbons()\Popup()\text()\x,ribbons()\Popup()\text()\y+22,ribbons()\Popup()\text()\text)
        Else
          DrawRibbonText(ribbons()\Popup()\text()\x,ribbons()\Popup()\text()\y+22,ribbons()\Popup()\text()\text)
        EndIf
      EndIf
    Next
    StopDrawing()
    ;HideGadget(ribbons()\Popup()\canvas,1)
  EndProcedure
  Procedure UnlinkPopup(id)
    Protected level
    level=SetPointerToItem(id)
    Select level
      Case 3;Items
        CloseWindow(ribbons()\Categories()\Groups()\items()\popup)
        ribbons()\Categories()\Groups()\items()\popup=0
      Case 4;SubItems
        CloseWindow(ribbons()\Categories()\Groups()\items()\subitems()\popup)
        ribbons()\Categories()\Groups()\items()\subitems()\popup=0
      Case 5;HeadButtons
        CloseWindow(ribbons()\headitems()\popup)
        ribbons()\headitems()\popup=0
      Case 6;RightHeadButtons
        CloseWindow(ribbons()\rightheaditems()\popup)
        ribbons()\rightheaditems()\popup=0
    EndSelect
    If level<3 Or level>6
      ProcedureReturn 0
    Else
      ProcedureReturn 1
    EndIf
  EndProcedure
  Procedure LinkPopup(id,head.s,w,h,flags=0)
    Protected level,window,canvas,old,pwindow
    level=SetPointerToItem(id)
    If level>1 And level <7
      LastElement(ribbons()\Popup())
      AddElement(ribbons()\Popup())
      ribbons()\Popup()\title=head
      CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL 
        pwindow=ribbons()\window
      CompilerElse
        pwindow=WindowID(ribbons()\window)
      CompilerEndIf
      old=UseGadgetList(pwindow)
      window=OpenWindow(#PB_Any,0,0,w+2,h+22,head,#PB_Window_Invisible|#PB_Window_BorderLess,pwindow)
      canvas=CanvasGadget(#PB_Any,0,0,w+2,h+22)
      UseGadgetList(old)
      If IsWindow(ribbons()\Popup()\window)
        DeleteObject_(ribbons()\Popup()\Region)
        CloseWindow(ribbons()\Popup()\window)
      EndIf
      ribbons()\Popup()\window=window
      ribbons()\Popup()\canvas=canvas
      ribbons()\Popup()\Flags=flags
      SetWindowLongPtr_(GadgetID(canvas), #GWL_STYLE, GetWindowLongPtr_(GadgetID(canvas), #GWL_STYLE)|#WS_CLIPCHILDREN|#WS_CLIPSIBLINGS)
      Select level
        Case 3;Items
          ribbons()\Categories()\Groups()\items()\popup=ListSize(ribbons()\Popup())
        Case 4;SubItems
          ribbons()\Categories()\Groups()\items()\subitems()\popup=ListSize(ribbons()\Popup())
        Case 5;HeadButtons
          ribbons()\headitems()\popup=ListSize(ribbons()\Popup())
        Case 6;RightHeadButtons
          ribbons()\rightheaditems()\popup=ListSize(ribbons()\Popup())
      EndSelect
      ProcedureReturn ListSize(ribbons()\Popup())
    Else
      ProcedureReturn -1
    EndIf
  EndProcedure
  Procedure MoveControlToPopup(id,handle,x,y)
    Protected r.rect
    If id>0 And id<=ListSize(ribbons()\Popup())
      SelectElement(ribbons()\Popup(),id-1)
      CompilerIf Not #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
        handle=GadgetID(handle)
      CompilerEndIf
      GetWindowRect_(handle,r)
      If SetParent_(handle,WindowID(ribbons()\popup()\window)) And MoveWindow_(handle,x+1,y+22,r\right-r\left,r\bottom-r\top,#True)
        SendMessage_(handle,#WM_SETFONT,FontID(ribbons()\font),0)
        ProcedureReturn 1
      EndIf
    EndIf
    ProcedureReturn -1
  EndProcedure
  Procedure AddPopupText(id,x,y,text.s,color=#Ribbon_Color_Auto)
    If id<=0 Or id>ListSize(ribbons()\Popup()):ProcedureReturn 0:EndIf
    SelectElement(ribbons()\Popup(),id-1)
    AddElement(ribbons()\Popup()\text())
    ribbons()\Popup()\text()\text=text
    ribbons()\popup()\text()\x=x
    ribbons()\popup()\text()\y=y
    ribbons()\popup()\text()\color=color
    CreatePopupWindow()
    ProcedureReturn ListSize(ribbons()\Popup()\text())
  EndProcedure
  Procedure SetPopupText(id,tid,text.s);tid=0 -> Fensterüberschrift setzen (nur bei dieser Funktion!)
    If id<1 Or id>ListSize(ribbons()\Popup()):ProcedureReturn 0:EndIf
    SelectElement(ribbons()\Popup(),id-1)
    If tid=0
      ribbons()\Popup()\title=text
      CreatePopupWindow()
      ProcedureReturn 1
    ElseIf tid<=ListSize(ribbons()\Popup()\text())
      SelectElement(ribbons()\Popup()\text(),tid-1)
      ribbons()\Popup()\text()\text=text
      CreatePopupWindow()
      ProcedureReturn 1
    Else
      ProcedureReturn 0
    EndIf
  EndProcedure
  Procedure MovePopupText(id,tid,x,y)
    If id>0 And id<=ListSize(ribbons()\Popup())
      SelectElement(ribbons()\Popup(),id-1)
      If tid>0 Or tid<=ListSize(ribbons()\Popup()\text())
        SelectElement(ribbons()\Popup()\text(),tid-1)
        ribbons()\Popup()\text()\x=x
        ribbons()\Popup()\text()\y=y
        CreatePopupWindow()
        ProcedureReturn 1
      EndIf
    EndIf
    ProcedureReturn 0
  EndProcedure
  Procedure RemovePopupText(id,tid)
    If id>0 And id<=ListSize(ribbons()\Popup())
      SelectElement(ribbons()\Popup(),id-1)
      If tid>0 Or tid<=ListSize(ribbons()\Popup()\text())
        SelectElement(ribbons()\Popup()\text(),tid-1)
        ribbons()\Popup()\text()\status=1
        CreatePopupWindow()
        ProcedureReturn 1
      EndIf
    EndIf
    ProcedureReturn 0
  EndProcedure
  Procedure SetPopupTextColor(id,tid,color)
    If id>0 And id<=ListSize(ribbons()\Popup())
      SelectElement(ribbons()\Popup(),id-1)
      If tid>0 Or tid<=ListSize(ribbons()\Popup()\text())
        SelectElement(ribbons()\Popup()\text(),tid-1)
        ribbons()\Popup()\text()\color=color
        CreatePopupWindow()
        ProcedureReturn 1
      EndIf
    EndIf
    ProcedureReturn 0
  EndProcedure
  Procedure FreeWindow()
    Protected p1.Point
    GetCursorPos_(p1)
    ScreenToClient_(WindowID(*Daten\Window),p1)
    If p1\y<0 Or p1\x<0 Or p1\x>WindowWidth(*Daten\window) Or p1\y>WindowHeight(*Daten\window)
      UnbindEvent(#PB_Event_DeactivateWindow,@FreeWindow(),*Daten\window)
      HideWindow(*Daten\Window,#True)
      CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL 
        If ribbons()\disabled=0
          If ribbons()\disabled=0
            AddElement(RibbonResponse())
            ribbonresponse()\event=#Ribbon_Event_PopupClose
            RibbonResponse()\id=*Daten\id
            RibbonResponse()\ControlX=ribbons()\hover\x
            RibbonResponse()\ControlY=ribbons()\hover\y
            RibbonResponse()\ControlDX=ribbons()\hover\dx
            RibbonResponse()\ControlDY=ribbons()\hover\dy
            SendMessage_(ribbons()\window,CallBackMessage,0,0)
          EndIf
        EndIf
      CompilerElse
        PostEvent(#PB_Event_Ribbon,*Daten\Window,*Daten\id,#PB_EventType_RibbonPopupClosed)
      CompilerEndIf
      *Daten\Window=0
    EndIf
    ClearStructure(p1,Point)
  EndProcedure
  Procedure ClosePopup()
    If *Daten\Window<>0
      UnbindEvent(#PB_Event_DeactivateWindow,@FreeWindow(),*Daten\window)
      HideWindow(*Daten\Window,#True)
      CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL 
        If ribbons()\disabled=0
          AddElement(RibbonResponse())
          ribbonresponse()\event=#Ribbon_Event_PopupClose
          RibbonResponse()\id=*Daten\id
          RibbonResponse()\ControlX=ribbons()\hover\x
          RibbonResponse()\ControlY=ribbons()\hover\y
          RibbonResponse()\ControlDX=ribbons()\hover\dx
          RibbonResponse()\ControlDY=ribbons()\hover\dy
          SendMessage_(ribbons()\window,CallBackMessage,0,0)
        EndIf
      CompilerElse
        PostEvent(#PB_Event_Ribbon,*Daten\Window,*Daten\id,#PB_EventType_RibbonPopupClosed)
      CompilerEndIf
      *Daten\Window=0
    EndIf
  EndProcedure
  Procedure GetPopupHandle(id)
    If id>0 And id<=ListSize(ribbons()\Popup())
      SelectElement(ribbons()\Popup(),id-1)
      CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
        ProcedureReturn WindowID(ribbons()\Popup()\window)
      CompilerElse
        ProcedureReturn ribbons()\Popup()\window
      CompilerEndIf
    Else
      ProcedureReturn 0
    EndIf
  EndProcedure
  Procedure OpenSubWindow(id,x,y,MouseButton)
    If id<1 Or id>ListSize(ribbons()\Popup()):ProcedureReturn:EndIf
    Protected p1.Point
    p1\x=x:p1\y=y
    If ribbons()\flags&#Ribbon_Flag_NoHeader:p1\y-22:EndIf
    CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL 
      ClientToScreen_(ribbons()\window,p1)
    CompilerElse
      ClientToScreen_(WindowID(ribbons()\window),p1)
    CompilerEndIf
    SelectElement(ribbons()\Popup(),id-1)
    If (ribbons()\Popup()\Flags&#Ribbon_Popup_RightClick And MouseButton=#Ribbon_Event_RightClick) Or (Not ribbons()\Popup()\Flags&#Ribbon_Popup_RightClick And MouseButton=#Ribbon_Event_LeftClick)
      If p1\x<0:p1\x=0:EndIf
      If p1\x+WindowWidth(ribbons()\Popup()\window)+2>DesktopWidth(0)
        p1\x=DesktopWidth(0)-WindowWidth(ribbons()\Popup()\window)-2
      EndIf
      If p1\y<0:p1\y=0:EndIf
      If p1\y+WindowHeight(ribbons()\Popup()\window)+2>DesktopHeight(0)-TaskbarHeight
        p1\y=DesktopHeight(0)-TaskbarHeight-WindowHeight(ribbons()\Popup()\window)-2
      EndIf
      ResizeWindow(ribbons()\Popup()\window,p1\x,p1\y+1,#PB_Ignore,#PB_Ignore)
      *Daten=AllocateMemory(SizeOf(HookData))
      *Daten\canvas=ribbons()\Popup()\canvas
      *Daten\id=id
      While *Daten\window<>0
        Delay(10)  
      Wend
      *Daten\window=ribbons()\Popup()\window
      HideWindow(ribbons()\Popup()\window,#False)
      CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL 
        If ribbons()\disabled=0
          AddElement(RibbonResponse())
          ribbonresponse()\event=#Ribbon_Event_PopupOpen
          RibbonResponse()\id=id
          RibbonResponse()\ControlX=ribbons()\hover\x
          RibbonResponse()\ControlY=ribbons()\hover\y
          RibbonResponse()\ControlDX=ribbons()\hover\dx
          RibbonResponse()\ControlDY=ribbons()\hover\dy
          SendMessage_(ribbons()\window,CallBackMessage,0,0)
        EndIf
      CompilerElse
        PostEvent(#PB_Event_Ribbon,*Daten\Window,*Daten\id,#PB_EventType_RibbonPopupOpened)
      CompilerEndIf 
      If Not ribbons()\Popup()\Flags&#Ribbon_Popup_NoAutoClose
        BindEvent(#PB_Event_DeactivateWindow,@FreeWindow(),ribbons()\Popup()\window)
      EndIf
    EndIf
  EndProcedure
  Procedure OpenGadget()
    Protected p1.Point
    p1\x=ribbons()\Categories()\Groups()\items()\SubItems()\x:p1\y=ribbons()\Categories()\Groups()\items()\SubItems()\y+ribbons()\Categories()\Groups()\items()\SubItems()\dy
    If ribbons()\flags&#Ribbon_Flag_NoHeader:p1\y-22:EndIf
    CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL 
      ClientToScreen_(ribbons()\window,p1)
    CompilerElse
      ClientToScreen_(WindowID(ribbons()\window),p1)
    CompilerEndIf
    If p1\x<0:p1\y=0:EndIf
    If p1\x+WindowWidth(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedWindow)+2>DesktopWidth(0)
      p1\x=DesktopWidth(0)-WindowWidth(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedWindow)-2
    EndIf
    If p1\y<0:p1\y=0:EndIf
    If p1\y+WindowHeight(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedWindow)+2>DesktopHeight(0)-TaskbarHeight
      p1\y=DesktopHeight(0)-TaskbarHeight-WindowHeight(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedWindow)-2
    EndIf
    
    
    ResizeWindow(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedWindow,p1\x+(ribbons()\Categories()\Groups()\items()\SubItems()\dx-GadgetWidth(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget))/2,p1\y,GadgetWidth(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget),GadgetHeight(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget))
    ;ItemGadgetIsVisible=ribbons()\Categories()\Groups()\items()\SubItems()\id
    ;Render(ribbons(),#True)
    SetActiveGadget(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget)
    HideWindow(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedWindow,#False)
  EndProcedure
  Procedure ResizePopup(id,x,y)
    If id<=0 Or id>ListSize(ribbons()\Popup()):ProcedureReturn:EndIf
    SelectElement(ribbons()\Popup(),id-1)
    MoveWindow_(WindowID(ribbons()\Popup()\window),0,0,x+2,y+22,#False)
    MoveWindow_(GadgetID(ribbons()\Popup()\canvas),0,0,x+2,y+22,#False)
    CreatePopupWindow()
  EndProcedure
  Procedure SetPopupHeadline(id,text.s)
    If id<=0 Or id>ListSize(ribbons()\Popup()):ProcedureReturn:EndIf
    SelectElement(ribbons()\Popup(),id-1)
    ribbons()\Popup()\title=text
    CreatePopupWindow()
  EndProcedure
  Procedure ComboboxHandler()
    Protected *element.SubItemList=GetGadgetData(EventGadget())
    If GetGadgetState(*element\AttachedGadget)<>-1
      SetActiveWindow(*element\MainWindow)
      SetItemText(*element\id,GetGadgetText(*element\AttachedGadget))
      CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL 
        AddElement(RibbonResponse())
        RibbonResponse()\event=#Ribbon_Event_ComboboxChange
        RibbonResponse()\id=*element\id
        SendMessage_(ribbons()\window,CallBackMessage,0,0)
      CompilerElse
        PostEvent(#PB_Event_Ribbon,*element\MainWindow,*element\id,#PB_EventType_RibbonComboboxChange)
      CompilerEndIf
    EndIf
  EndProcedure
  Procedure SimpleWindowCloser()
    Protected *element.SubItemList=GetWindowData(EventWindow())
    If IsWindowVisible_(WindowID(*element\AttachedWindow))
      ItemGadgetIsVisible=0
      HideWindow(*element\AttachedWindow,#True)
      ;Render(*element\Ribbon,#True);?
    EndIf
  EndProcedure
  Macro DrawRibbonImage(image,x,y,dx=0,dy=0)
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    If dy=0
      DrawImage(image,x,y)
    Else
      DrawImage(image,x,y,dx,dy)
    EndIf
  EndMacro
  Procedure RenderCorpus(handle)
    Protected *element,width,cwidth,spacing,tempimage,visiblecount.l,position,delta,ddelta,edelta,pos,bcolor,groupstatus,categorystatus,text.s,temp1,temp2
    position=ribbons()\Categories()\Padding+8
    ;*element=@ribbons()
    ForEach ribbons()
      If ribbons()\handle=handle
        ForEach ribbons()\headitems()
          If (ribbons()\headitems()\status&#Ribbon_Status_Hidden)=0
            Select ribbons()\headitems()\type
              Case #Ribbon_Type_HeadSeparator
                spacing+5
              Case #Ribbon_Type_HeadButton,#Ribbon_Type_HeadPushButton
                spacing+22
              Case #Ribbon_Type_HeadImage
                If IsImage(ribbons()\headitems()\image)
                  spacing+2+ImageWidth(ribbons()\headitems()\image)
                EndIf
              Case #Ribbon_Type_HeadImageButton
                If IsImage(ribbons()\headitems()\image)
                  spacing+2+ImageWidth(ribbons()\headitems()\image)
                EndIf
            EndSelect
          EndIf
        Next
        If spacing=0
          ribbons()\offset=8
        Else
          ribbons()\offset=spacing+4
        EndIf
        
        CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
          Protected rect.Rect
          GetClientRect_(ribbons()\window,rect)
          width=rect\right
        CompilerElse
          width=WindowWidth(ribbons()\window,#PB_Window_InnerCoordinate)
        CompilerEndIf
        If ribbons()\x<>width And width>0
          ribbons()\x=width
          FreeImage(ribbons()\InternalRenderer);If IsImage(ribbons()\InternalRenderer):FreeImage(ribbons()\InternalRenderer):EndIf
                                               ;If IsImage(ribbons()\InternalRenderer):ResizeImage(ribbons()\InternalRenderer,ribbons()\x,ribbons()\y):EndIf
                                               ;If IsImage(ribbons()\MoveRightImage):FreeImage(ribbons()\MoveRightImage):EndIf
                                               ;If IsImage(ribbons()\MoveLeftImage):FreeImage(ribbons()\MoveLeftImage):EndIf
        EndIf
        
        ;Verschoben nach RenderElements:
        If Not IsImage(ribbons()\InternalRenderer)
          ribbons()\InternalRenderer=CreateImage(#PB_Any,ribbons()\x,ribbons()\y)
        EndIf
        ribbons()\RenderCount+1
        ribbons()\RibbonImage=CreateImage(#PB_Any,ribbons()\x,ribbons()\y)
        StartDrawing(ImageOutput(ribbons()\RibbonImage))
        Box(0,0,ribbons()\x,ribbons()\y,ribbons()\backcolor);FillArea(0,0,-1,ribbons()\backcolor)
        DrawingMode(#PB_2DDrawing_Gradient)
        FrontColor(RGBD(ribbons()\color,ribbons()\AccentStrength));RGB(227,244,255))
        BackColor(RGBD(ribbons()\color,-1*ribbons()\AccentStrength));RGB(207,222,239))
        EllipticalGradient(0,Int(ribbons()\y/2)+12,ribbons()\x*6,Int(ribbons()\y/2))
        RoundBox(ribbons()\padding,23,ribbons()\x-2*ribbons()\padding,ribbons()\y-24-2,ribbons()\roundness,ribbons()\roundness)
        StopDrawing()
        If Not IsImage(ribbons()\MoveRightImage)
          ribbons()\MoveRightImage=GrabImage(ribbons()\RibbonImage,#PB_Any,0,27,16,94)
          StartDrawing(ImageOutput(ribbons()\MoveRightImage))
          ;DrawingMode(#PB_2DDrawing_Transparent)
          RoundBox(0,0,16,96,ribbons()\roundness,ribbons()\roundness,RGBD(ribbons()\color,-32))
          StopDrawing()
          ribbons()\MoveLeftImage=CopyImage(ribbons()\MoveRightImage,#PB_Any)
          StartDrawing(ImageOutput(ribbons()\MoveRightImage))
          DrawingMode(#PB_2DDrawing_Transparent)
          DrawingFont(FontID(ribbons()\extrafont))
          DrawRibbonText(0,36,"3")
          StopDrawing()
          StartDrawing(ImageOutput(ribbons()\MoveLeftImage))
          DrawingMode(#PB_2DDrawing_Transparent)
          DrawingFont(FontID(ribbons()\extrafont))
          DrawRibbonText(-2,36,"4")
          StopDrawing()
        EndIf
        StartDrawing(ImageOutput(ribbons()\RibbonImage))
        If Not ribbons()\flags&#Ribbon_Flag_NoBorder
          FrontColor(RGBD(ribbons()\color,ribbons()\AccentStrength));RGB(227,244,255))
          BackColor(RGBD(ribbons()\color,-1*ribbons()\AccentStrength));RGB(207,222,239))
          DrawingMode(#PB_2DDrawing_Outlined)
          RoundBox(ribbons()\padding,23,ribbons()\x-2*ribbons()\padding,ribbons()\y-24-2,ribbons()\roundness,ribbons()\roundness,RGBD(ribbons()\color,-32))
        EndIf
        
        ;Collapser rendern
        DrawingMode(#PB_2DDrawing_Transparent)
        If ribbons()\flags&#Ribbon_Flag_Collapsible = #Ribbon_Flag_Collapsible
          DrawingFont(FontID(ribbons()\extrafont))
          If ribbons()\collapsed
            DrawRibbonText(ribbons()\x-22,-1,"6")
          Else
            DrawRibbonText(ribbons()\x-22,0,"5")
          EndIf
        EndIf
        
        ;Kategorien rendern
        If Not ribbons()\flags&#Ribbon_Flag_NoHeader
          DrawingFont(FontID(ribbons()\font))
          ForEach ribbons()\Categories()
            If ribbons()\Categories()\status&#Ribbon_Status_Hidden=0
              ribbons()\Categories()\Position=ribbons()\offset
              width=TextWidth(ribbons()\Categories()\text)
              If IsImage(ribbons()\Categories()\image)
                width+20
              EndIf
              cwidth=width+24
              If cwidth<64:cwidth=64:EndIf
              ribbons()\Categories()\Width=cwidth
              FrontColor(rgbd(ribbons()\color,24))
              If ribbons()\Categories()\status&#Ribbon_Status_Deactivated<>0
                tempimage=GrabDrawingImage(#PB_Any,ribbons()\Categories()\Position,0,ribbons()\Categories()\Width,22)
              EndIf
              If IsImage(ribbons()\Categories()\image)
                DrawRibbonImage(ImageID(ribbons()\Categories()\image),ribbons()\Categories()\Position+Int((ribbons()\Categories()\Width-width)/2),4,16,16)
                DrawRibbonText(ribbons()\Categories()\Position+Int((ribbons()\Categories()\Width-width)/2)+20,4,ribbons()\Categories()\Text)
              Else              
                DrawRibbonText(ribbons()\Categories()\Position+Int((ribbons()\Categories()\Width-width)/2),4,ribbons()\Categories()\Text)
              EndIf
              If ribbons()\Categories()\status&#Ribbon_Status_Deactivated<>0
                DrawAlphaImage(ImageID(tempimage),ribbons()\Categories()\Position,0,128)
                FreeImage(tempimage)
              EndIf
              ribbons()\offset=ribbons()\offset+cwidth+2
            EndIf
          Next
        EndIf
        
        StopDrawing()
        
        If ListSize(ribbons()\Categories())<>0
          ForEach ribbons()\Categories()
            If ribbons()\Categories()\id=ribbons()\Category
              Break
            EndIf
          Next
          categorystatus=ribbons()\Categories()\status&#Ribbon_Status_Deactivated
          StartDrawing(ImageOutput(ribbons()\RibbonImage))
          bcolor=Point(5,27)
          ClipOutput(0,0,ribbons()\x-5,24)
          RoundBox(ribbons()\Categories()\Position,2,ribbons()\Categories()\Width,30,ribbons()\roundness,ribbons()\roundness,bcolor)
          If Not ribbons()\flags%#Ribbon_Flag_NoBorder
            DrawingMode(#PB_2DDrawing_Outlined)
          EndIf
          RoundBox(ribbons()\Categories()\Position,2,ribbons()\Categories()\Width,64,ribbons()\roundness,ribbons()\roundness,rgbd(ribbons()\color,-28))
          DrawingFont(FontID(ribbons()\font))
          width=TextWidth(ribbons()\Categories()\Text)
          DrawingMode(#PB_2DDrawing_Transparent)
          If IsImage(ribbons()\Categories()\image)
            DrawRibbonImage(ImageID(ribbons()\Categories()\image),ribbons()\Categories()\Position+Int((ribbons()\Categories()\Width-width)/2)-10,4,16,16)
            DrawRibbonText(ribbons()\Categories()\Position+Int((ribbons()\Categories()\Width-width)/2)+10,4,ribbons()\Categories()\Text)
          Else              
            DrawRibbonText(ribbons()\Categories()\Position+Int((ribbons()\Categories()\Width-width)/2),4,ribbons()\Categories()\Text)
          EndIf
          DrawingFont(FontID(ribbons()\smallfont))
          
          ;HeadButtons rendern
          pos=0
          ForEach ribbons()\headitems()
            If ribbons()\headitems()\status&#Ribbon_Status_Hidden=0
              Select ribbons()\headitems()\type
                Case #Ribbon_Type_HeadImage
                  If IsImage(ribbons()\headitems()\image)
                    If (ribbons()\headitems()\status&#Ribbon_Status_Deactivated)<>0:tempimage=GrabDrawingImage(#PB_Any,pos+4,2,ImageWidth(ribbons()\headitems()\image),20):EndIf
                    temp1=CreateImage(#PB_Any,ImageWidth(ribbons()\headitems()\image),20,32,ribbons()\color)
                    temp2=GrabDrawingImage(#PB_Any,pos+4,2,ImageWidth(ribbons()\headitems()\image),20)
                    StopDrawing()
                    StartDrawing(ImageOutput(temp1))
                    DrawRibbonImage(ImageID(temp2),0,0)
                    FreeImage(temp2)
                    DrawingMode(#PB_2DDrawing_AlphaChannel)
                    RoundBox(0,0,ImageWidth(temp1),20,ribbons()\roundness,ribbons()\roundness,0)
                    StopDrawing()
                    StartDrawing(ImageOutput(ribbons()\RibbonImage))
                    DrawingMode(#PB_2DDrawing_AlphaBlend)
                    DrawRibbonImage(ImageID(ribbons()\headitems()\image),pos+4,2)
                    DrawRibbonImage(ImageID(temp1),pos+4,2)
                    DrawingMode(#PB_2DDrawing_Transparent)
                    DrawingFont(FontID(ribbons()\smallfont))
                    FreeImage(temp1)
                    DrawDeactivatedImage(pos+4,2)
                    pos+2+ImageWidth(ribbons()\headitems()\image)
                  EndIf
                Case #Ribbon_Type_HeadImageButton
                  If IsImage(ribbons()\headitems()\image)
                    If (ribbons()\headitems()\status&#Ribbon_Status_Deactivated)<>0:tempimage=GrabDrawingImage(#PB_Any,pos+5,3,ImageWidth(ribbons()\headitems()\image),18):EndIf
                    temp1=CreateImage(#PB_Any,ImageWidth(ribbons()\headitems()\image),18,32,ribbons()\color)
                    temp2=GrabDrawingImage(#PB_Any,pos+5,3,ImageWidth(ribbons()\headitems()\image),18)
                    StopDrawing()
                    StartDrawing(ImageOutput(temp1))
                    DrawRibbonImage(ImageID(temp2),0,0)
                    FreeImage(temp2)
                    DrawingMode(#PB_2DDrawing_AlphaChannel)
                    RoundBox(0,0,ImageWidth(temp1),18,ribbons()\roundness,ribbons()\roundness,0)
                    StopDrawing()
                    StartDrawing(ImageOutput(ribbons()\RibbonImage))
                    DrawingMode(#PB_2DDrawing_AlphaBlend)
                    DrawRibbonImage(ImageID(ribbons()\headitems()\image),pos+4,3)
                    DrawRibbonImage(ImageID(temp1),pos+5,3)
                    DrawingMode(#PB_2DDrawing_Transparent)
                    DrawingFont(FontID(ribbons()\smallfont))
                    FreeImage(temp1)
                    DrawDeactivatedImage(pos+5,3)
                    ribbons()\headitems()\x=pos+4
                    ribbons()\headitems()\y=2
                    ribbons()\headitems()\dx=ImageWidth(ribbons()\headitems()\image)+2
                    ribbons()\headitems()\dy=20
                    pos+2+ImageWidth(ribbons()\headitems()\image)
                  EndIf
                Case #Ribbon_Type_HeadSeparator
                  Line(pos+5,3,1,18,rgbd(ribbons()\color,-36))
                  ;Line(pos+4,5,1,14,rgbd(ribbons()\color,-16))
                  ;Line(pos+6,5,1,14,rgbd(ribbons()\color,-16))
                  pos+5
                Case #Ribbon_Type_HeadButton,#Ribbon_Type_HeadPushButton
                  ribbons()\headitems()\x=4+pos
                  ribbons()\headitems()\y=2
                  ribbons()\headitems()\dx=20
                  ribbons()\headitems()\dy=20
                  If ribbons()\headitems()\type=#Ribbon_Type_HeadPushButton And (ribbons()\headitems()\status&#Ribbon_Status_Checked)=#Ribbon_Status_Checked:RoundBox(5+pos,3,18,18,ribbons()\roundness,ribbons()\roundness,rgbd(ribbons()\color,-30)):EndIf
                  If (ribbons()\headitems()\status&#Ribbon_Status_Deactivated)<>0:tempimage=GrabDrawingImage(#PB_Any,4+pos,4,20,20):EndIf
                  If ribbons()\headitems()\image<>#Ribbon_Image_None And IsImage(ribbons()\headitems()\image)
                    DrawRibbonImage(ImageID(ribbons()\headitems()\image),6+pos,4,16,16)
                  EndIf
                  DrawDeactivatedImage(4+pos,4)
                  If ribbons()\headitems()\popup<>0
                    StopDrawing()
                    SelectElement(ribbons()\Popup(),ribbons()\headitems()\popup-1)
                    CreatePopupWindow()
                    StartDrawing(ImageOutput(ribbons()\RibbonImage))
                    DrawingMode(#PB_2DDrawing_Transparent)
                    DrawingFont(FontID(ribbons()\smallfont))
                  EndIf
                  pos+22
              EndSelect
            EndIf
          Next
          
          ;RightHeadButtons rendern
          pos=ribbons()\x-25
          If ribbons()\flags&#Ribbon_Flag_Collapsible = #Ribbon_Flag_Collapsible
            pos-19
          EndIf
          If ListSize(ribbons()\rightheaditems())>0
            UnclipOutput()
            For delta=ListSize(ribbons()\rightheaditems())-1 To 0 Step -1
              SelectElement(ribbons()\rightheaditems(),delta)
              If ribbons()\rightheaditems()\status&#Ribbon_Status_Hidden=0
                Select ribbons()\rightheaditems()\type
                  Case #Ribbon_Type_RightHeadImage
                    If IsImage(ribbons()\rightheaditems()\image)
                      If (ribbons()\rightheaditems()\status&#Ribbon_Status_Deactivated)<>0:tempimage=GrabDrawingImage(#PB_Any,pos,2,ImageWidth(ribbons()\rightheaditems()\image),20):EndIf
                      temp1=CreateImage(#PB_Any,ImageWidth(ribbons()\rightheaditems()\image),20,32,ribbons()\color)
                      temp2=GrabDrawingImage(#PB_Any,pos,2,ImageWidth(ribbons()\rightheaditems()\image),20)
                      StopDrawing()
                      StartDrawing(ImageOutput(temp1))
                      DrawRibbonImage(ImageID(temp2),0,0)
                      FreeImage(temp2)
                      DrawingMode(#PB_2DDrawing_AlphaChannel)
                      RoundBox(0,0,ImageWidth(temp1),20,ribbons()\roundness,ribbons()\roundness,0)
                      StopDrawing()
                      StartDrawing(ImageOutput(ribbons()\RibbonImage))
                      DrawingMode(#PB_2DDrawing_AlphaBlend)
                      DrawRibbonImage(ImageID(ribbons()\rightheaditems()\image),pos,2)
                      DrawRibbonImage(ImageID(temp1),pos,2)
                      DrawingMode(#PB_2DDrawing_Transparent)
                      DrawingFont(FontID(ribbons()\smallfont))
                      FreeImage(temp1)
                      DrawDeactivatedImage(pos,2)
                      pos-2-ImageWidth(ribbons()\rightheaditems()\image)
                    EndIf
                  Case #Ribbon_Type_RightHeadImageButton
                    If IsImage(ribbons()\rightheaditems()\image)
                      If (ribbons()\rightheaditems()\status&#Ribbon_Status_Deactivated)<>0:tempimage=GrabDrawingImage(#PB_Any,pos+1,3,ImageWidth(ribbons()\rightheaditems()\image),18):EndIf
                      temp1=CreateImage(#PB_Any,ImageWidth(ribbons()\rightheaditems()\image),18,32,ribbons()\color)
                      temp2=GrabDrawingImage(#PB_Any,pos+1,3,ImageWidth(ribbons()\rightheaditems()\image),18)
                      StopDrawing()
                      StartDrawing(ImageOutput(temp1))
                      DrawRibbonImage(ImageID(temp2),0,0)
                      FreeImage(temp2)
                      DrawingMode(#PB_2DDrawing_AlphaChannel)
                      RoundBox(0,0,ImageWidth(temp1),18,ribbons()\roundness,ribbons()\roundness,0)
                      StopDrawing()
                      StartDrawing(ImageOutput(ribbons()\RibbonImage))
                      DrawingMode(#PB_2DDrawing_AlphaBlend)
                      DrawRibbonImage(ImageID(ribbons()\rightheaditems()\image),pos+1,3)
                      DrawRibbonImage(ImageID(temp1),pos+1,3)
                      DrawingMode(#PB_2DDrawing_Transparent)
                      DrawingFont(FontID(ribbons()\smallfont))
                      FreeImage(temp1)
                      DrawDeactivatedImage(pos+1,3)
                      ribbons()\rightheaditems()\x=pos
                      ribbons()\rightheaditems()\y=2
                      ribbons()\rightheaditems()\dx=ImageWidth(ribbons()\rightheaditems()\image)+2
                      ribbons()\rightheaditems()\dy=20
                      pos-2-ImageWidth(ribbons()\rightheaditems()\image)
                    EndIf
                  Case #Ribbon_Type_RightHeadSeparator
                    Line(pos+18,3,1,18,rgbd(ribbons()\color,-36))
                    ;                 Line(pos+17,5,1,14,rgbd(ribbons()\color,-16))
                    ;                 Line(pos+19,5,1,14,rgbd(ribbons()\color,-16))
                    pos-5
                  Case #Ribbon_Type_RightHeadButton,#Ribbon_Type_RightHeadPushButton
                    ribbons()\rightheaditems()\x=pos
                    ribbons()\rightheaditems()\y=2
                    ribbons()\rightheaditems()\dx=20
                    ribbons()\rightheaditems()\dy=20
                    If ribbons()\rightheaditems()\type=#Ribbon_Type_RightHeadPushButton And (ribbons()\rightheaditems()\status&#Ribbon_Status_Checked)=#Ribbon_Status_Checked:RoundBox(pos+1,3,18,18,ribbons()\roundness,ribbons()\roundness,rgbd(ribbons()\color,-30)):EndIf
                    If (ribbons()\rightheaditems()\status&#Ribbon_Status_Deactivated)<>0:tempimage=GrabDrawingImage(#PB_Any,pos,4,20,20):EndIf
                    If ribbons()\rightheaditems()\image<>#Ribbon_Image_None And IsImage(ribbons()\rightheaditems()\image)
                      DrawRibbonImage(ImageID(ribbons()\rightheaditems()\image),pos+2,4,16,16)
                    EndIf
                    DrawDeactivatedImage(4+pos,4)
                    If ribbons()\rightheaditems()\popup<>0
                      StopDrawing()
                      SelectElement(ribbons()\Popup(),ribbons()\rightheaditems()\popup-1)
                      CreatePopupWindow()
                      StartDrawing(ImageOutput(ribbons()\RibbonImage))
                      DrawingMode(#PB_2DDrawing_Transparent)
                      DrawingFont(FontID(ribbons()\smallfont))
                    EndIf
                    pos-22
                  Case #Ribbon_Type_RightHeadText,#Ribbon_Type_RightHeadTextButton
                    If ribbons()\rightheaditems()\text<>""
                      If ribbons()\rightheaditems()\type=#Ribbon_Type_RightHeadTextButton:pos-4:EndIf
                      DrawingFont(FontID(ribbons()\font))
                      ddelta=TextWidth(ribbons()\rightheaditems()\text)
                      If (ribbons()\rightheaditems()\status&#Ribbon_Status_Deactivated)<>0:tempimage=GrabDrawingImage(#PB_Any,pos-ddelta+16,2,ddelta,20):EndIf
                      DrawRibbonText(pos-ddelta+19,3,ribbons()\rightheaditems()\text)
                      ribbons()\rightheaditems()\x=pos-ddelta+16
                      ribbons()\rightheaditems()\y=2
                      ribbons()\rightheaditems()\dx=ddelta+8
                      ribbons()\rightheaditems()\dy=20
                      DrawingFont(FontID(ribbons()\smallfont))
                      DrawDeactivatedImage(pos-ddelta+16,2)
                      pos-ddelta-2
                      If ribbons()\rightheaditems()\type=#Ribbon_Type_RightHeadTextButton:pos-4:EndIf
                    EndIf
                EndSelect  
              EndIf
            Next
            ClipOutput(8,0,ribbons()\x-5,ribbons()\y)
          EndIf
          
          ;Gruppenbreite berechnen
          visiblecount=0
          If ribbons()\flags&#Ribbon_Flag_NoBorder
            ForEach ribbons()\Categories()\Groups()
              ribbons()\Categories()\Groups()\visstatus=0
              If Not ribbons()\Categories()\Groups()\status&#Ribbon_Status_Hidden
                ForEach ribbons()\Categories()\Groups()\items()
                  If Not ribbons()\Categories()\Groups()\Items()\status&#Ribbon_Status_Hidden
                    If ListSize(ribbons()\Categories()\Groups()\Items()\SubItems())
                      ForEach ribbons()\Categories()\Groups()\items()\SubItems()
                        If Not ribbons()\Categories()\Groups()\Items()\SubItems()\status&#Ribbon_Status_Hidden
                          ribbons()\Categories()\Groups()\visstatus=1
                          Break 2
                        EndIf
                      Next
                    Else
                      ribbons()\Categories()\Groups()\visstatus=1
                      Break
                    EndIf
                  EndIf
                Next          
              EndIf
            Next
            ForEach ribbons()\Categories()\Groups()
              visiblecount+ribbons()\Categories()\Groups()\visstatus
            Next
          EndIf
          ForEach ribbons()\Categories()\Groups()
            If Not ribbons()\Categories()\Groups()\status&#Ribbon_Status_Hidden
              visiblecount-ribbons()\Categories()\Groups()\visstatus
              delta=4
              ;Gruppenbreite ermitteln
              ForEach ribbons()\Categories()\Groups()\items()
                If ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Hidden = 0
                  If ribbons()\Categories()\Groups()\items()\popup<>0
                    StopDrawing()
                    SelectElement(ribbons()\Popup(),ribbons()\Categories()\Groups()\items()\popup-1)
                    CreatePopupWindow()
                    StartDrawing(ImageOutput(ribbons()\RibbonImage))
                    ;ClipOutput(0,0,ribbons()\x-5,ribbons()\y)
                    DrawingMode(#PB_2DDrawing_Transparent)
                    DrawingFont(FontID(ribbons()\smallfont))
                  EndIf
                  Select ribbons()\Categories()\Groups()\items()\type
                    Case #Ribbon_Type_Image
                      If IsImage(ribbons()\Categories()\Groups()\items()\image)
                        delta+4+ImageWidth(ribbons()\Categories()\Groups()\items()\image)
                      EndIf
                    Case #Ribbon_Type_ImageButton
                      If IsImage(ribbons()\Categories()\Groups()\items()\image)
                        delta+6+ImageWidth(ribbons()\Categories()\Groups()\items()\image)
                      EndIf
                    Case #Ribbon_Type_Separator
                      delta+5
                    Case #Ribbon_Type_Button,#Ribbon_Type_PushButton,#Ribbon_Type_Checkbox
                      ddelta=TextWidth(ribbons()\Categories()\Groups()\items()\text)
                      If ddelta>58
                        delta+ddelta+12
                      Else
                        delta+66
                      EndIf
                    Case #Ribbon_Type_ButtonContainer
                      ddelta=0
                      pos=0
                      ForEach ribbons()\Categories()\Groups()\items()\SubItems()
                        If ribbons()\Categories()\Groups()\items()\SubItems()\status&#Ribbon_Status_Hidden = 0
                          Select ribbons()\Categories()\Groups()\items()\SubItems()\type
                            Case #Ribbon_Type_Separator
                              ddelta+Round(pos/2,#PB_Round_Up)*34+3
                              pos=0
                            Case #Ribbon_Type_Button,#Ribbon_Type_PushButton
                              pos+1
                          EndSelect  
                        EndIf
                      Next
                      If pos>0
                        ddelta+Round(pos/2,#PB_Round_Up)*34
                      EndIf
                      If ddelta>0
                        delta+ddelta-2
                        ribbons()\Categories()\Groups()\items()\maxwidth=ddelta-2
                      EndIf
                    Case #Ribbon_Type_Container
                      edelta=0
                      ForEach ribbons()\Categories()\Groups()\items()\SubItems()
                        If ribbons()\Categories()\Groups()\items()\SubItems()\status&#Ribbon_Status_Hidden = 0
                          If ddelta>edelta:edelta=ddelta:EndIf
                          Select ribbons()\Categories()\Groups()\items()\SubItems()\type
                            Case #Ribbon_Type_Combobox
                              If GetGadgetState(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget)<>-1
                                ribbons()\Categories()\Groups()\items()\SubItems()\text=GetGadgetText(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget)
                              EndIf
                              ddelta=40+TextWidth(ribbons()\Categories()\Groups()\items()\SubItems()\text)
                              If ddelta>edelta:edelta=ddelta:EndIf
                              ddelta=2+GadgetWidth(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget,#PB_Gadget_ActualSize)
                            Default
                              ddelta=20+TextWidth(ribbons()\Categories()\Groups()\items()\SubItems()\text)
                          EndSelect
                          If ddelta>edelta:edelta=ddelta:EndIf
                        EndIf
                        If ListIndex(ribbons()\Categories()\Groups()\items()\SubItems())>=2
                          Break
                        EndIf
                      Next
                      If edelta>0
                        delta+edelta+6
                        ribbons()\Categories()\Groups()\items()\maxwidth=edelta+6
                      EndIf
                  EndSelect
                EndIf
              Next
              
              ;Gruppe rendern
              If delta>4; And position<ribbons()\x; And (position+delta>8);Renderfehler (keine Gruppen gerendert, wenn eine aus dem Bild springt)
                StopDrawing()
                StartDrawing(ImageOutput(ribbons()\RibbonImage))
                ClipOutput(8,0,ribbons()\x-16,ribbons()\y)
                DrawingFont(FontID(ribbons()\smallfont))
                If ribbons()\flags&#Ribbon_Flag_NoBorder
                  If visiblecount>0
                    Line(position+delta+2,24,1,96,rgbd(ribbons()\color,-36))
                  EndIf
                Else
                  DrawingMode(#PB_2DDrawing_Outlined)
                  RoundBox(position,27,delta,ribbons()\y-34,ribbons()\roundness,ribbons()\roundness,rgbd(ribbons()\color,-36))
                  Line(position,ribbons()\y-26,delta,1,rgbd(ribbons()\color,-36))
                  If position<0
                    Line(8,ribbons()\y-26,1,18,rgbd(ribbons()\color,-36))
                    FillArea(position+delta-1,ribbons()\y-25,rgbd(ribbons()\color,-36),rgbd(ribbons()\color,-36))
                  Else
                    FillArea(position+1,ribbons()\y-25,rgbd(ribbons()\color,-36),rgbd(ribbons()\color,-36))
                  EndIf
                EndIf
                DrawingMode(#PB_2DDrawing_Transparent)
                text=ribbons()\Categories()\Groups()\text
                If TextWidth(text)>delta-6
                  text=text+"..."
                  While TextWidth(text)>delta-6
                    If Len(text)=3
                      Break
                    Else
                      text=Left(text,Len(text)-6)+"..."
                    EndIf
                  Wend
                EndIf
                DrawRibbonText(position+Int((delta-TextWidth(text))/2),ribbons()\y-24,text)
                If ribbons()\Categories()\Groups()\status=#Ribbon_Status_Deactivated
                  groupstatus=1
                Else
                  groupstatus=0
                EndIf
                ddelta=0
                position+4
                ForEach ribbons()\Categories()\Groups()\items()
                  If ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Hidden = 0
                    Select ribbons()\Categories()\Groups()\items()\type
                      Case #Ribbon_Type_Image
                        If IsImage(ribbons()\Categories()\Groups()\items()\image)
                          If (ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Deactivated)<>0 Or groupstatus Or categorystatus:tempimage=GrabDrawingImage(#PB_Any,position,30,ImageWidth(ribbons()\Categories()\Groups()\items()\image),70):EndIf
                          temp1=CreateImage(#PB_Any,ImageWidth(ribbons()\Categories()\Groups()\items()\image),70,32,ribbons()\color)
                          temp2=GrabDrawingImage(#PB_Any,position,30,ImageWidth(ribbons()\Categories()\Groups()\items()\image),70)
                          StopDrawing()
                          StartDrawing(ImageOutput(temp1))
                          DrawRibbonImage(ImageID(temp2),0,0)
                          FreeImage(temp2)
                          DrawingMode(#PB_2DDrawing_AlphaChannel)
                          RoundBox(0,0,ImageWidth(temp1),70,ribbons()\roundness,ribbons()\roundness,0)
                          StopDrawing()
                          StartDrawing(ImageOutput(ribbons()\RibbonImage))
                          ClipOutput(8,0,ribbons()\x-16,ribbons()\y)
                          DrawingMode(#PB_2DDrawing_AlphaBlend)
                          DrawRibbonImage(ImageID(ribbons()\Categories()\Groups()\items()\image),position,30)
                          DrawRibbonImage(ImageID(temp1),position,30)
                          DrawingMode(#PB_2DDrawing_Transparent)
                          DrawingFont(FontID(ribbons()\smallfont))
                          FreeImage(temp1)
                          DrawDeactivatedImage(position,30)
                          position+4+ImageWidth(ribbons()\Categories()\Groups()\items()\image)
                        EndIf
                      Case #Ribbon_Type_ImageButton  
                        If IsImage(ribbons()\Categories()\Groups()\items()\image)
                          If (ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Deactivated)<>0 Or groupstatus Or categorystatus:tempimage=GrabDrawingImage(#PB_Any,position+1,31,ImageWidth(ribbons()\Categories()\Groups()\items()\image),68):EndIf
                          temp1=CreateImage(#PB_Any,ImageWidth(ribbons()\Categories()\Groups()\items()\image),68,32,ribbons()\color)
                          temp2=GrabDrawingImage(#PB_Any,position,31,ImageWidth(ribbons()\Categories()\Groups()\items()\image),68)
                          StopDrawing()
                          StartDrawing(ImageOutput(temp1))
                          DrawRibbonImage(ImageID(temp2),0,0)
                          FreeImage(temp2)
                          DrawingMode(#PB_2DDrawing_AlphaChannel)
                          RoundBox(0,0,ImageWidth(temp1),68,ribbons()\roundness,ribbons()\roundness,0)
                          StopDrawing()
                          StartDrawing(ImageOutput(ribbons()\RibbonImage))
                          ClipOutput(8,0,ribbons()\x-16,ribbons()\y)
                          DrawingMode(#PB_2DDrawing_AlphaBlend)
                          DrawRibbonImage(ImageID(ribbons()\Categories()\Groups()\items()\image),position+1,31)
                          DrawRibbonImage(ImageID(temp1),position+1,31)
                          DrawingMode(#PB_2DDrawing_Transparent)
                          DrawingFont(FontID(ribbons()\smallfont))
                          FreeImage(temp1)
                          DrawDeactivatedImage(position+1,31)
                          ribbons()\categories()\groups()\items()\x=position
                          ribbons()\categories()\groups()\items()\y=ribbons()\y-98
                          ribbons()\categories()\groups()\items()\dx=ImageWidth(ribbons()\Categories()\Groups()\items()\image)
                          ribbons()\categories()\groups()\items()\dy=70
                          position+6+ImageWidth(ribbons()\Categories()\Groups()\items()\image)
                        EndIf
                      Case #Ribbon_Type_Button,#Ribbon_Type_PushButton,#Ribbon_Type_Checkbox
                        ddelta=TextWidth(ribbons()\Categories()\Groups()\items()\text)
                        ribbons()\categories()\groups()\items()\x=position-1
                        ribbons()\categories()\groups()\items()\y=ribbons()\y-98
                        ribbons()\categories()\groups()\items()\dy=70
                        DrawingMode(#PB_2DDrawing_AlphaBlend)
                        If ddelta>58
                          ribbons()\categories()\groups()\items()\dx=ddelta+10
                          If ribbons()\Categories()\Groups()\items()\type=#Ribbon_Type_PushButton And (ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Checked)=#Ribbon_Status_Checked:RoundBox(position-1,ribbons()\y-97,ddelta+12,67,ribbons()\roundness,ribbons()\roundness,rgbd(ribbons()\color,-36)):EndIf
                          If (ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Deactivated)<>0 Or groupstatus Or categorystatus:tempimage=GrabDrawingImage(#PB_Any,position-1,ribbons()\y-97,ddelta+10,68):EndIf
                          Select ribbons()\Categories()\Groups()\items()\type
                            Case #Ribbon_Type_Button,#Ribbon_Type_PushButton
                              If ribbons()\Categories()\Groups()\items()\image<>#Ribbon_Image_None And IsImage(ribbons()\Categories()\Groups()\items()\image)
                                DrawRibbonImage(ImageID(ribbons()\Categories()\Groups()\items()\image),position+Int((ddelta-43)/2),ribbons()\y-92,48,48)
                              EndIf
                            Case #Ribbon_Type_Checkbox
                              If (ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Checked)<>0
                                DrawRibbonImage(ImageID(ribbons()\Icons("Checked48")),position+Int((ddelta-43)/2),ribbons()\y-92,48,48)
                              ElseIf (ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Inbetween)<>0
                                DrawRibbonImage(ImageID(ribbons()\Icons("Inbetween48")),position+Int((ddelta-43)/2),ribbons()\y-92,48,48)
                              Else
                                DrawRibbonImage(ImageID(ribbons()\Icons("Unchecked48")),position+Int((ddelta-43)/2),ribbons()\y-92,48,48)
                              EndIf
                          EndSelect
                          DrawRibbonText(position+4,ribbons()\y-43,ribbons()\Categories()\Groups()\items()\text)
                          DrawDeactivatedImage(position-1,ribbons()\y-97)
                          position+ddelta+12
                        Else
                          ribbons()\categories()\groups()\items()\dx=64
                          If ribbons()\Categories()\Groups()\items()\type=#Ribbon_Type_PushButton And (ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Checked)=#Ribbon_Status_Checked:RoundBox(position-1,ribbons()\y-97,64,68,ribbons()\roundness,ribbons()\roundness,rgbd(ribbons()\color,-36)):EndIf
                          If (ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Deactivated)<>0 Or groupstatus Or categorystatus:tempimage=GrabDrawingImage(#PB_Any,position-1,ribbons()\y-97,64,68):EndIf
                          Select ribbons()\Categories()\Groups()\items()\type
                            Case #Ribbon_Type_Button,#Ribbon_Type_PushButton
                              If ribbons()\Categories()\Groups()\items()\image<>#Ribbon_Image_None And IsImage(ribbons()\Categories()\Groups()\items()\image)
                                DrawRibbonImage(ImageID(ribbons()\Categories()\Groups()\items()\image),position+8,ribbons()\y-92,48,48)
                              EndIf
                            Case #Ribbon_Type_Checkbox
                              If (ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Checked)<>0
                                DrawRibbonImage(ImageID(ribbons()\Icons("Checked48")),position+8,ribbons()\y-92,48,48)
                              ElseIf (ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Inbetween)<>0
                                DrawRibbonImage(ImageID(ribbons()\Icons("Inbetween48")),position+8,ribbons()\y-92,48,48)
                              Else
                                DrawRibbonImage(ImageID(ribbons()\Icons("Unchecked48")),position+8,ribbons()\y-92,48,48)
                              EndIf
                          EndSelect
                          DrawRibbonText(position+Int((64-ddelta)/2),ribbons()\y-43,ribbons()\Categories()\Groups()\items()\text)
                          DrawDeactivatedImage(position-1,ribbons()\y-97)
                          position+66
                        EndIf
                      Case #Ribbon_Type_Separator
                        Line(position,ribbons()\y-98,1,70,rgbd(ribbons()\color,-36))
                        ;                     Line(position-1,ribbons()\y-96,1,66,rgbd(ribbons()\color,-24))
                        ;                     Line(position+1,ribbons()\y-96,1,66,rgbd(ribbons()\color,-24))
                        position+5
                      Case #Ribbon_Type_ButtonContainer
                        edelta=position
                        pos=0
                        ForEach ribbons()\Categories()\Groups()\items()\SubItems()
                          If ribbons()\Categories()\Groups()\items()\SubItems()\status&#Ribbon_Status_Hidden = 0
                            If ribbons()\Categories()\Groups()\items()\subitems()\popup<>0
                              StopDrawing()
                              SelectElement(ribbons()\Popup(),ribbons()\Categories()\Groups()\items()\subitems()\popup-1)
                              CreatePopupWindow()
                              StartDrawing(ImageOutput(ribbons()\RibbonImage))
                              ClipOutput(8,0,ribbons()\x-16,ribbons()\y)
                              DrawingMode(#PB_2DDrawing_Transparent)
                              DrawingFont(FontID(ribbons()\smallfont))
                            EndIf
                            Select ribbons()\Categories()\Groups()\items()\SubItems()\type
                              Case #Ribbon_Type_Separator
                                delta=Round(pos/2,#PB_Round_Up)*34
                                Line(position-2+delta,ribbons()\y-98,1,70,rgbd(ribbons()\color,-36))
                                ;                             Line(position-3+delta,ribbons()\y-95,1,64,rgbd(ribbons()\color,-24))
                                ;                             Line(position-1+delta,ribbons()\y-95,1,64,rgbd(ribbons()\color,-24))
                                position+3+delta
                                pos=0
                              Case #Ribbon_Type_Button,#Ribbon_Type_PushButton
                                ribbons()\categories()\groups()\items()\subitems()\x=position-2+Int(pos/2)*34
                                ribbons()\categories()\groups()\items()\subitems()\y=31+Mod(pos,2)*35
                                ribbons()\categories()\groups()\items()\subitems()\dx=32
                                ribbons()\categories()\groups()\items()\subitems()\dy=32
                                If ribbons()\Categories()\Groups()\items()\subitems()\type=#Ribbon_Type_PushButton And ribbons()\Categories()\Groups()\items()\subitems()\status=#Ribbon_Status_Checked:RoundBox(position-1+Int(pos/2)*34,32+Mod(pos,2)*35,30,30,ribbons()\roundness,ribbons()\roundness,rgbd(ribbons()\color,-36)):EndIf
                                If (ribbons()\Categories()\Groups()\items()\Subitems()\status&#Ribbon_Status_Deactivated)<>0 Or (ribbons()\Categories()\Groups()\items()\status& #Ribbon_Status_Deactivated)<>0 Or groupstatus Or categorystatus:tempimage=GrabDrawingImage(#PB_Any,position-1+Int(pos/2)*34,30,34+Mod(pos,2)*35,30):EndIf
                                If ribbons()\Categories()\Groups()\items()\Subitems()\image<>#Ribbon_Image_None And IsImage(ribbons()\Categories()\Groups()\items()\SubItems()\image)
                                  DrawRibbonImage(ImageID(ribbons()\Categories()\Groups()\items()\subitems()\image),position+2+Int(pos/2)*34,35+Mod(pos,2)*35,24,24)
                                EndIf
                                DrawDeactivatedImage(position-1+Int(pos/2)*34,34+Mod(pos,2)*35)
                                pos+1
                            EndSelect  
                          EndIf  
                        Next
                        position=edelta+ribbons()\Categories()\Groups()\items()\maxwidth
                      Case #Ribbon_Type_Container
                        pos=0
                        ForEach ribbons()\Categories()\Groups()\items()\SubItems()
                          If ribbons()\Categories()\Groups()\items()\SubItems()\status&#Ribbon_Status_Hidden = 0
                            If ribbons()\Categories()\Groups()\items()\subitems()\popup<>0
                              StopDrawing()
                              SelectElement(ribbons()\Popup(),ribbons()\Categories()\Groups()\items()\subitems()\popup-1)
                              CreatePopupWindow()
                              StartDrawing(ImageOutput(ribbons()\RibbonImage))
                              ClipOutput(8,0,ribbons()\x-16,ribbons()\y)
                              DrawingMode(#PB_2DDrawing_Transparent)
                              DrawingFont(FontID(ribbons()\smallfont))
                            EndIf
                            ribbons()\categories()\groups()\items()\subitems()\x=position-2
                            ribbons()\categories()\groups()\items()\subitems()\y=31+22*pos
                            ribbons()\categories()\groups()\items()\subitems()\dx=ribbons()\Categories()\Groups()\items()\maxwidth
                            ribbons()\categories()\groups()\items()\subitems()\dy=22
                            If ribbons()\Categories()\Groups()\items()\subitems()\type=#Ribbon_Type_PushButton And ribbons()\Categories()\Groups()\items()\subitems()\status=#Ribbon_Status_Checked:RoundBox(position-1,32+22*pos,ribbons()\Categories()\Groups()\items()\maxwidth-2,20,ribbons()\roundness,ribbons()\roundness,rgbd(ribbons()\color,-36)):EndIf
                            If (ribbons()\Categories()\Groups()\items()\Subitems()\status&#Ribbon_Status_Deactivated)<>0 Or (ribbons()\Categories()\Groups()\items()\status& #Ribbon_Status_Deactivated)<>0 Or groupstatus Or categorystatus:tempimage=GrabDrawingImage(#PB_Any,position-1,32+22*pos,ribbons()\Categories()\Groups()\items()\maxwidth-2,22):EndIf
                            Select ribbons()\Categories()\Groups()\items()\SubItems()\type
                              Case #Ribbon_Type_Button,#Ribbon_Type_PushButton
                                If ribbons()\Categories()\Groups()\items()\SubItems()\image<>#Ribbon_Image_None And IsImage(ribbons()\Categories()\Groups()\items()\SubItems()\image)
                                  DrawRibbonImage(ImageID(ribbons()\Categories()\Groups()\items()\subitems()\image),position+2,34+22*pos,16,16)
                                EndIf
                              Case #Ribbon_Type_Checkbox
                                If (ribbons()\Categories()\Groups()\items()\subitems()\status&#Ribbon_Status_Checked)<>0
                                  DrawRibbonImage(ImageID(ribbons()\Icons("Checked16")),position+2,34+22*pos,16,16)
                                ElseIf (ribbons()\Categories()\Groups()\items()\subitems()\status&#Ribbon_Status_Inbetween)<>0
                                  DrawRibbonImage(ImageID(ribbons()\Icons("Inbetween16")),position+2,34+22*pos,16,16)
                                Else
                                  DrawRibbonImage(ImageID(ribbons()\Icons("Unchecked16")),position+2,34+22*pos,16,16)
                                EndIf
                              Case #Ribbon_Type_RadioButton
                                If (ribbons()\Categories()\Groups()\items()\subitems()\status&#Ribbon_Status_Checked)<>0
                                  DrawRibbonImage(ImageID(ribbons()\Icons("RadioChecked16")),position+2,34+22*pos,16,16)
                                Else
                                  DrawRibbonImage(ImageID(ribbons()\Icons("RadioUnchecked16")),position+2,34+22*pos,16,16)
                                EndIf
                              Case #Ribbon_Type_Combobox
                                If ribbons()\Categories()\Groups()\items()\SubItems()\image<>#Ribbon_Image_None And IsImage(ribbons()\Categories()\Groups()\items()\SubItems()\image)
                                  DrawRibbonImage(ImageID(ribbons()\Categories()\Groups()\items()\subitems()\image),position+2,34+22*pos,16,16)
                                EndIf
                                ;DrawingMode(#PB_2DDrawing_Outlined)
                                ;Box(position+1,33+22*pos,GadgetWidth(ribbons()\Categories()\Groups()\items()\subitems()\AttachedGadget,#PB_Gadget_ActualSize)+2,18,rgbd(ribbons()\color,-24))
                                ;DrawingMode(#PB_2DDrawing_Transparent)
                                DrawingFont(FontID(ribbons()\extrafont))
                                If ItemGadgetIsVisible=ribbons()\Categories()\Groups()\items()\subitems()\id
                                  DrawRibbonText(position+ribbons()\Categories()\Groups()\items()\subitems()\dx-24,30+22*pos,"5")
                                Else
                                  DrawRibbonText(position+ribbons()\Categories()\Groups()\items()\subitems()\dx-24,28+22*pos,"6")
                                EndIf
                                DrawingFont(FontID(ribbons()\smallfont))
                            EndSelect
                            DrawRibbonText(position+20,35+22*pos,ribbons()\Categories()\Groups()\items()\subitems()\text)
                            DrawDeactivatedImage(position-1,32+20*pos)
                            pos+1
                            If pos>=3
                              Break
                            EndIf
                          EndIf  
                        Next
                        position+ribbons()\Categories()\Groups()\items()\maxwidth
                    EndSelect
                    ;Steuerelemente rendern  
                  EndIf  
                Next
                position+4
              EndIf
            EndIf
          Next
          ribbons()\Categories()\TotalWidth=position+4
        EndIf
        StopDrawing()
        
        Break  
      EndIf
    Next
    
    
    ;ChangeCurrentElement(ribbons(),*element)
  EndProcedure
  Procedure RenderElements(force=0)
    Protected position=8,delta,ddelta,edelta,pos,*cache,bcolor,width,tempimage,groupstatus,text.s,x,y,coldraw,isclipfree.b,iswindowenabled.b,ry,time=ElapsedMilliseconds(),rendertype.a
    
    LockMutex(rMutex)
    If ribbons()\hidden<>#Ribbon_Show_Show Or ribbons()\noupdate<>0
      UnlockMutex(rMutex)
      ProcedureReturn 0
    EndIf
    CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
      If GetForegroundWindow_()<>ribbons()\window And Not force
        UnlockMutex(rMutex)
        ProcedureReturn 0
      EndIf
      GetCursorPos_(Mouse)
      ScreenToClient_(ribbons()\window,Mouse)
      x=Mouse\x
      y=Mouse\y
    CompilerElse
      If GetForegroundWindow_()<>WindowID(ribbons()\window) And Not force
        UnlockMutex(rMutex)
        ProcedureReturn 0
      EndIf
      x=WindowMouseX(ribbons()\window)
      y=WindowMouseY(ribbons()\window)
      Mouse\x=x
      Mouse\y=y
    CompilerEndIf
    If ribbons()\flags&#Ribbon_Flag_NoHeader:y+22:EndIf
    If force=0 And (y>128 Or y<0 Or x<ribbons()\padding+4 Or x>ribbons()\x-ribbons()\padding-4)
      UnlockMutex(rMutex)
      ProcedureReturn 0
    ElseIf y<24
      ForEach ribbons()\Categories()
        If ribbons()\Categories()\status&#Ribbon_Status_Hidden=0 And x>=ribbons()\Categories()\Position And x<=(ribbons()\Categories()\Position+ribbons()\Categories()\Width) And ribbonevent=#Ribbon_Event_LeftClick And ribbons()\Categories()\status&#Ribbon_Status_Deactivated=0
          ribbons()\Category=ribbons()\Categories()\id
          ribbonid=ribbons()\Category
          force=#Ribbon_Render_Force
          ;ribbonevent=#Ribbon_Event_Activated
          Break
        EndIf
      Next
    Else
    EndIf
    
    If Not IsImage(ribbons()\RibbonImage)
      rendertype=1
      RenderCorpus(ribbons()\handle)
    EndIf
    
    ;Aus RenderCorpus:
    If Not IsImage(ribbons()\InternalRenderer):ribbons()\InternalRenderer=CreateImage(#PB_Any,ribbons()\x,ribbons()\y):EndIf
    StartDrawing(ImageOutput(ribbons()\InternalRenderer))
    DrawingFont(FontID(ribbons()\font))
    ForEach ribbons()\Categories()
      If ribbons()\Categories()\id=ribbons()\Category
        Break
      EndIf
    Next
    If ListSize(ribbons()\Categories())<>0
      ribbons()\hover\active=0
      ribbons()\hover\oldid=ribbons()\hover\id
      ribbons()\hover\id=0
      *cache=@ribbons()\Categories()
      ForEach ribbons()\Categories()
        ;If ribbons()\Categories()\status&#Ribbon_Status_Deactivated=0 And ribbons()\Categories()\status&#Ribbon_Status_Hidden=0 And ribbons()\Category<>ribbons()\Categories()\id And Rectangle(x,ribbons()\Categories()\Position,ribbons()\Categories()\Width,y,2,20,ribbons()\Categories()\id,0)
        If ribbons()\Categories()\status&(#Ribbon_Status_Deactivated|#Ribbon_Status_Hidden)=0 And Rectangle(x,ribbons()\Categories()\Position,ribbons()\Categories()\Width,y,2,20,ribbons()\Categories()\id,0)
          isclipfree=#True
          Break
        EndIf
      Next
      ChangeCurrentElement(ribbons()\Categories(),*cache)
      
      ;Collapser abfragen
      If ribbons()\flags&#Ribbon_Flag_Collapsible<>0
        If Rectangle(x,ribbons()\x-23,20,y,2,20,-1,0)
          isclipfree=1
          coldraw=ribbonevent
          If ribbonevent=#Ribbon_Event_LeftClick
            ribbons()\collapsed=1-ribbons()\collapsed
            force=#Ribbon_Render_Force
          EndIf
        ElseIf  (GadgetHeight(ribbons()\handle)=ribbons()\y And ribbons()\collapsed) Or (GadgetHeight(ribbons()\handle)<>ribbons()\y And Not ribbons()\collapsed)
          coldraw=#Ribbon_Event_Dummy
          ;force=#Ribbon_Render_Force;?
        EndIf
      EndIf
      
      ;HeadItems abfragen
      pos=0
      ForEach ribbons()\headitems()
        If ribbons()\headitems()\status&#Ribbon_Status_Hidden=0
          Select ribbons()\headitems()\type
            Case #Ribbon_Type_HeadButton,#Ribbon_Type_HeadPushButton,#Ribbon_Type_HeadImageButton
              If Rectangle(x,ribbons()\headitems()\x,ribbons()\headitems()\dx,y,ribbons()\headitems()\y,ribbons()\headitems()\dy,ribbons()\headitems()\id,0)
                isclipfree=#True
                If Not ribbons()\headitems()\status&#Ribbon_Status_Deactivated
                  Select ribbonevent
                    Case #Ribbon_Event_LeftClick
                      Select ribbons()\headitems()\type
                        Case #Ribbon_Type_HeadPushButton
                          If ribbons()\headitems()\status&#Ribbon_Status_Checked
                            ribbons()\headitems()\status=ribbons()\headitems()\status-#Ribbon_Status_Checked
                          Else
                            ribbons()\headitems()\status=ribbons()\headitems()\status+#Ribbon_Status_Checked
                          EndIf
                          force=#Ribbon_Render_Force
                      EndSelect
                      If ribbons()\headitems()\popup
                        OpenSubWindow(ribbons()\headitems()\popup,ribbons()\headitems()\x,ribbons()\headitems()\y+ribbons()\headitems()\dy,#Ribbon_Event_LeftClick)
                      EndIf                  
                    Case #Ribbon_Event_RightClick
                      If ribbons()\headitems()\popup
                        OpenSubWindow(ribbons()\headitems()\popup,ribbons()\headitems()\x,ribbons()\headitems()\y+ribbons()\headitems()\dy,#Ribbon_Event_RightClick)
                      EndIf                  
                  EndSelect
                EndIf
              EndIf
          EndSelect
        EndIf
      Next
      
      ;RightHeadItems abfragen
      ForEach ribbons()\rightheaditems()
        If ribbons()\rightheaditems()\status&#Ribbon_Status_Hidden=0
          Select ribbons()\rightheaditems()\type
            Case #Ribbon_Type_RightHeadButton,#Ribbon_Type_RightHeadPushButton,#Ribbon_Type_RightHeadTextButton,#Ribbon_Type_RightHeadImageButton
              If Rectangle(x,ribbons()\rightheaditems()\x,ribbons()\rightheaditems()\dx,y,ribbons()\rightheaditems()\y,ribbons()\rightheaditems()\dy,ribbons()\rightheaditems()\id,0)
                isclipfree=#True
                If Not ribbons()\rightheaditems()\status&#Ribbon_Status_Deactivated
                  Select ribbonevent
                    Case #Ribbon_Event_LeftClick
                      Select ribbons()\rightheaditems()\type
                        Case #Ribbon_Type_RightHeadPushButton
                          If ribbons()\rightheaditems()\status&#Ribbon_Status_Checked
                            ribbons()\rightheaditems()\status=ribbons()\rightheaditems()\status-#Ribbon_Status_Checked
                          Else
                            ribbons()\rightheaditems()\status=ribbons()\rightheaditems()\status+#Ribbon_Status_Checked
                          EndIf
                          force=#Ribbon_Render_Force
                      EndSelect  
                      If ribbons()\rightheaditems()\popup
                        OpenSubWindow(ribbons()\rightheaditems()\popup,ribbons()\rightheaditems()\x,ribbons()\rightheaditems()\y+ribbons()\rightheaditems()\dy,#Ribbon_Event_LeftClick)
                      EndIf
                    Case #Ribbon_Event_RightClick
                      If ribbons()\rightheaditems()\popup
                        OpenSubWindow(ribbons()\rightheaditems()\popup,ribbons()\rightheaditems()\x,ribbons()\rightheaditems()\y+ribbons()\rightheaditems()\dy,#Ribbon_Event_RightClick)
                      EndIf
                  EndSelect
                EndIf
              EndIf
          EndSelect  
        EndIf
      Next
      
      ;Schiebebuttons und Mausrad abfragen
      Select ribbonevent
        Case #Ribbon_Event_LeftClick,#Ribbon_Event_ScrollDown,#Ribbon_Event_ScrollUp
          If ribbonevent=#Ribbon_Event_ScrollUp Or (ribbons()\Categories()\LeftButtonActive And x>8 And x<=24 And y>27 And y<=120)
            ribbons()\Categories()\Padding+ribbons()\ScrollPitch
            If ribbons()\Categories()\Padding>0:ribbons()\Categories()\Padding=0:EndIf
            ribbons()\Categories()\LastPadding=ribbons()\Categories()\Padding
            FreeImage(ribbons()\RibbonImage);If IsImage(ribbons()\RibbonImage):FreeImage(ribbons()\RibbonImage):EndIf
            StopDrawing()
            rendertype=1
            RenderCorpus(ribbons()\handle)
            StartDrawing(ImageOutput(ribbons()\InternalRenderer))
            x=-1:y=-1:force=#Ribbon_Render_Force
          ElseIf ribbonevent=#Ribbon_Event_ScrollDown Or (ribbons()\Categories()\RightButtonActive And x>ribbons()\x-24 And x<=ribbons()\x-8 And y>27 And y<=120)
            ribbons()\Categories()\Padding-ribbons()\ScrollPitch
            If ribbons()\Categories()\TotalWidth<ribbons()\x;+ribbons()\ScrollPitch
              ribbons()\Categories()\Padding+ribbons()\Categories()\TotalWidth-ribbons()\x
              ribbons()\Categories()\TotalWidth=ribbons()\x
            EndIf
            ribbons()\Categories()\LastPadding=ribbons()\Categories()\Padding
            FreeImage(ribbons()\RibbonImage);If IsImage(ribbons()\RibbonImage):FreeImage(ribbons()\RibbonImage):EndIf
            StopDrawing()
            rendertype=1
            RenderCorpus(ribbons()\handle)
            StartDrawing(ImageOutput(ribbons()\InternalRenderer))
            x=-1:y=-1:force=#Ribbon_Render_Force
          EndIf
      EndSelect
      
      ;Aktuelles Padding gegebenenfalls nachkorrigieren
      If ribbons()\Categories()\Padding<0 And ribbons()\Categories()\TotalWidth<ribbons()\x
        ribbons()\Categories()\Padding+ribbons()\x-ribbons()\Categories()\TotalWidth
        If ribbons()\Categories()\Padding>0
          ribbons()\Categories()\Padding=0
        EndIf
        ribbons()\Categories()\LastPadding=ribbons()\Categories()\Padding
        FreeImage(ribbons()\RibbonImage)
        StopDrawing()
        rendertype=1
        RenderCorpus(ribbons()\handle)
        StartDrawing(ImageOutput(ribbons()\InternalRenderer))
      EndIf
      
      ForEach ribbons()\Categories()\Groups()
        If ribbons()\Categories()\Groups()\status=#Ribbon_Status_Deactivated
          groupstatus=1
        Else
          groupstatus=0
        EndIf
        ;Gruppe abfragen
        ForEach ribbons()\Categories()\Groups()\items()
          If Not ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Hidden
            Select ribbons()\Categories()\Groups()\items()\type
              Case #Ribbon_Type_Button,#Ribbon_Type_PushButton,#Ribbon_Type_Checkbox,#Ribbon_Type_ImageButton
                If Rectangle(x,ribbons()\Categories()\Groups()\items()\x,ribbons()\Categories()\Groups()\items()\dx,y,ribbons()\Categories()\Groups()\items()\y,ribbons()\Categories()\Groups()\items()\dy,ribbons()\Categories()\Groups()\items()\id,groupstatus) And ((ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Deactivated)=0 And groupstatus=0)
                  Select ribbonevent
                    Case #Ribbon_Event_LeftClick
                      Select  ribbons()\Categories()\Groups()\items()\type
                        Case #Ribbon_Type_PushButton,#Ribbon_Type_Checkbox
                          If (ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Checked)<>0
                            ribbons()\Categories()\Groups()\items()\status=ribbons()\Categories()\Groups()\items()\status&~#Ribbon_Status_Checked
                          Else
                            ribbons()\Categories()\Groups()\items()\status=ribbons()\Categories()\Groups()\items()\status|#Ribbon_Status_Checked
                          EndIf
                          ribbons()\Categories()\Groups()\items()\status=ribbons()\Categories()\Groups()\items()\status&~#Ribbon_Status_Inbetween
                          force=#Ribbon_Render_Force
                      EndSelect
                      If ribbons()\Categories()\groups()\items()\popup
                        OpenSubWindow(ribbons()\Categories()\groups()\items()\popup,ribbons()\Categories()\groups()\items()\x,ribbons()\Categories()\groups()\items()\y+ribbons()\Categories()\groups()\items()\dy,#Ribbon_Event_LeftClick)
                      EndIf
                    Case #Ribbon_Event_RightClick
                      If ribbons()\Categories()\groups()\items()\popup
                        OpenSubWindow(ribbons()\Categories()\groups()\items()\popup,ribbons()\Categories()\groups()\items()\x,ribbons()\Categories()\groups()\items()\y+ribbons()\Categories()\groups()\items()\dy,#Ribbon_Event_RightClick)
                      EndIf
                  EndSelect
                EndIf
              Case #Ribbon_Type_ButtonContainer
                If (ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Deactivated)=0 And groupstatus=0
                  ForEach ribbons()\Categories()\Groups()\items()\SubItems()
                    If Not ribbons()\Categories()\Groups()\items()\SubItems()\status&#Ribbon_Status_Hidden
                      If Rectangle(x,ribbons()\Categories()\Groups()\items()\SubItems()\x,ribbons()\Categories()\Groups()\items()\SubItems()\dx,y,ribbons()\Categories()\Groups()\items()\SubItems()\y,ribbons()\Categories()\Groups()\items()\SubItems()\dy,ribbons()\Categories()\Groups()\items()\SubItems()\id,groupstatus) And ((ribbons()\Categories()\Groups()\items()\SubItems()\status&#Ribbon_Status_Deactivated)=0 And groupstatus=0)
                        Select ribbonevent
                          Case #Ribbon_Event_LeftClick
                            Select ribbons()\Categories()\Groups()\items()\SubItems()\type
                              Case #Ribbon_Type_PushButton
                                If ribbons()\Categories()\Groups()\items()\SubItems()\status&#Ribbon_Status_Checked
                                  ribbons()\Categories()\Groups()\items()\SubItems()\status=ribbons()\Categories()\Groups()\items()\SubItems()\status&~#Ribbon_Status_Checked
                                Else
                                  ribbons()\Categories()\Groups()\items()\SubItems()\status=ribbons()\Categories()\Groups()\items()\SubItems()\status|#Ribbon_Status_Checked
                                EndIf
                                ribbons()\Categories()\Groups()\items()\SubItems()\status=ribbons()\Categories()\Groups()\items()\SubItems()\status&~#Ribbon_Status_Inbetween
                                force=#Ribbon_Render_Force
                            EndSelect  
                            If ribbons()\Categories()\groups()\items()\subitems()\popup
                              OpenSubWindow(ribbons()\Categories()\groups()\items()\subitems()\popup,ribbons()\Categories()\groups()\items()\subitems()\x,ribbons()\Categories()\groups()\items()\subitems()\y+ribbons()\Categories()\groups()\items()\subitems()\dy,#Ribbon_Event_LeftClick)
                            EndIf
                          Case #Ribbon_Event_RightClick
                            If ribbons()\Categories()\groups()\items()\subitems()\popup
                              OpenSubWindow(ribbons()\Categories()\groups()\items()\subitems()\popup,ribbons()\Categories()\groups()\items()\subitems()\x,ribbons()\Categories()\groups()\items()\subitems()\y+ribbons()\Categories()\groups()\items()\subitems()\dy,#Ribbon_Event_RightClick)
                            EndIf
                        EndSelect
                      EndIf
                    EndIf  
                  Next
                EndIf
              Case #Ribbon_Type_Container
                If (ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_Deactivated)=0 And groupstatus=0
                  ForEach ribbons()\Categories()\Groups()\items()\SubItems()
                    If Not ribbons()\Categories()\Groups()\items()\SubItems()\status&#Ribbon_Status_Hidden
                      If Rectangle(x,ribbons()\Categories()\Groups()\items()\SubItems()\x,ribbons()\Categories()\Groups()\items()\SubItems()\dx,y,ribbons()\Categories()\Groups()\items()\SubItems()\y,ribbons()\Categories()\Groups()\items()\SubItems()\dy,ribbons()\Categories()\Groups()\items()\SubItems()\id,groupstatus) And ((ribbons()\Categories()\Groups()\items()\SubItems()\status&#Ribbon_Status_Deactivated)=0 And groupstatus=0)
                        Select ribbonevent
                          Case #Ribbon_Event_LeftClick
                            Select ribbons()\Categories()\Groups()\items()\SubItems()\type
                              Case #Ribbon_Type_PushButton,#Ribbon_Type_Checkbox
                                If ribbons()\Categories()\Groups()\items()\SubItems()\status&#Ribbon_Status_Checked
                                  ribbons()\Categories()\Groups()\items()\SubItems()\status=ribbons()\Categories()\Groups()\items()\SubItems()\status&~#Ribbon_Status_Checked
                                Else
                                  ribbons()\Categories()\Groups()\items()\SubItems()\status=ribbons()\Categories()\Groups()\items()\SubItems()\status|#Ribbon_Status_Checked
                                EndIf
                                ribbons()\Categories()\Groups()\items()\SubItems()\status=ribbons()\Categories()\Groups()\items()\SubItems()\status&~#Ribbon_Status_Inbetween
                                force=#Ribbon_Render_Force
                              Case #Ribbon_Type_RadioButton
                                ribbons()\Categories()\Groups()\items()\SubItems()\status=ribbons()\Categories()\Groups()\items()\SubItems()\status|#Ribbon_Status_Checked
                                *cache=@ribbons()\Categories()\Groups()\items()\SubItems()
                                ForEach ribbons()\Categories()\Groups()\items()\SubItems()
                                  ribbons()\Categories()\Groups()\items()\SubItems()\status=ribbons()\Categories()\Groups()\items()\SubItems()\status&~#Ribbon_Status_Checked
                                Next
                                ChangeCurrentElement(ribbons()\Categories()\Groups()\items()\SubItems(),*cache)
                                ribbons()\Categories()\Groups()\items()\SubItems()\status=ribbons()\Categories()\Groups()\items()\SubItems()\status|#Ribbon_Status_Checked
                                force=#Ribbon_Render_Force
                              Case #Ribbon_Type_Combobox
                                ItemGadgetIsVisible=ribbons()\Categories()\Groups()\items()\SubItems()\id
                                Render(ribbons(),#True)
                                OpenGadget()
                            EndSelect
                            If ribbons()\Categories()\groups()\items()\subitems()\popup
                              OpenSubWindow(ribbons()\Categories()\groups()\items()\subitems()\popup,ribbons()\Categories()\groups()\items()\subitems()\x,ribbons()\Categories()\groups()\items()\subitems()\y+ribbons()\Categories()\groups()\items()\subitems()\dy,#Ribbon_Event_LeftClick)
                            EndIf
                          Case #Ribbon_Event_RightClick
                            If ribbons()\Categories()\groups()\items()\subitems()\popup
                              OpenSubWindow(ribbons()\Categories()\groups()\items()\subitems()\popup,ribbons()\Categories()\groups()\items()\subitems()\x,ribbons()\Categories()\groups()\items()\subitems()\y+ribbons()\Categories()\groups()\items()\subitems()\dy,#Ribbon_Event_RightClick)
                            EndIf
                        EndSelect
                      EndIf
                      If ListIndex(ribbons()\Categories()\Groups()\items()\SubItems())=2:Break:EndIf;Nicht mehr als 3 Elemente zulassen!
                    EndIf  
                  Next
                EndIf
            EndSelect
          EndIf  
        Next
      Next
      
      If force
        FreeImage(ribbons()\RibbonImage)
        StopDrawing()
        rendertype=1
        RenderCorpus(ribbons()\handle)
        StartDrawing(ImageOutput(ribbons()\InternalRenderer))
        ;ClipOutput(0,0,ribbons()\x-5,ribbons()\y)
      EndIf
      
      ;"If" muss eigentlich raus!
      If IsImage(ribbons()\RibbonImage):DrawImage(ImageID(ribbons()\RibbonImage),0,0):EndIf
      
      ;Zeichnen der Schiebebuttons und ggf. Löschen der Hovermaske
      If ribbons()\Categories()\Padding<0;Linker Schiebebutton
        DrawImage(ImageID(ribbons()\MoveRightImage),8,27)
        ribbons()\Categories()\LeftButtonActive=#True
        If x>=8 And x<=24 And y>27 And y<=120
          ribbons()\hover\id=0
        EndIf
      Else
        ribbons()\Categories()\LeftButtonActive=#False
      EndIf
      If ribbons()\Categories()\TotalWidth>ribbons()\x;Rechter Schiebebutton
        DrawImage(ImageID(ribbons()\MoveLeftImage),ribbons()\x-24,27)
        ribbons()\Categories()\RightButtonActive=#True
        If x>=ribbons()\x-24 And x<=ribbons()\x-8 And y>27 And y<=120
          ribbons()\hover\id=0
        EndIf
      Else
        ribbons()\Categories()\RightButtonActive=#False
      EndIf
      
      CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL;IsWindowEnabled
        iswindowenabled=IsWindowEnabled_(ribbons()\Window)
      CompilerElse
        iswindowenabled=IsWindowEnabled_(WindowID(ribbons()\Window))
      CompilerEndIf
      If ribbons()\hover\id<>ribbons()\hover\oldid And ribbons()\hover\active And ribbons()\Category<>ribbons()\hover\id And ribbons()\disabled=0 And ribbons()\hover\id And ((GetItemStatus(ribbons()\hover\id)&#Ribbon_Status_Deactivated)=0 Or ribbons()\hover\id<0) And iswindowenabled
        ribbonid=ribbons()\hover\id
        If ribbons()\flags&#Ribbon_Flag_FullHover<>0
          StopDrawing()
          If ribbons()\hover\x<0
            tempimage=GrabImage(ribbons()\InternalRenderer,#PB_Any,0,ribbons()\hover\y,ribbons()\hover\dx+ribbons()\hover\x,ribbons()\hover\dy)
          Else
            tempimage=GrabImage(ribbons()\InternalRenderer,#PB_Any,ribbons()\hover\x,ribbons()\hover\y,ribbons()\hover\dx,ribbons()\hover\dy)
          EndIf
          StartDrawing(ImageOutput(tempimage))
          If ribbons()\hover\x<0
            RoundBox(ribbons()\hover\x,0,ribbons()\hover\dx,ribbons()\hover\dy,ribbons()\roundness,ribbons()\roundness,0)
          Else
            RoundBox(0,0,ribbons()\hover\dx,ribbons()\hover\dy,ribbons()\roundness,ribbons()\roundness,0)
          EndIf
          StopDrawing()
          StartDrawing(ImageOutput(ribbons()\InternalRenderer))
          If isclipfree
            ClipOutput(0,0,ribbons()\x,ribbons()\y)
          Else
            If ribbons()\Categories()\LeftButtonActive And ribbons()\Categories()\RightButtonActive
              ClipOutput(24,0,ribbons()\x-48,ribbons()\y)
            ElseIf ribbons()\Categories()\RightButtonActive
              ClipOutput(8,0,ribbons()\x-32,ribbons()\y)
            ElseIf ribbons()\Categories()\LeftButtonActive
              ClipOutput(24,0,ribbons()\x-32,ribbons()\y)
            Else
              ClipOutput(8,0,ribbons()\x-16,ribbons()\y)
            EndIf
          EndIf
          If ribbons()\hover\x<0
            DrawAlphaImage(ImageID(tempimage),0,ribbons()\hover\y,56)
          Else
            DrawAlphaImage(ImageID(tempimage),ribbons()\hover\x,ribbons()\hover\y,56)
          EndIf
          FreeImage(tempimage)
        Else
          If isclipfree
            ClipOutput(0,0,ribbons()\x,ribbons()\y)
          Else
            If ribbons()\Categories()\LeftButtonActive And ribbons()\Categories()\RightButtonActive
              ClipOutput(24,0,ribbons()\x-48,ribbons()\y)
            ElseIf ribbons()\Categories()\RightButtonActive
              ClipOutput(8,0,ribbons()\x-32,ribbons()\y)
            ElseIf ribbons()\Categories()\LeftButtonActive
              ClipOutput(24,0,ribbons()\x-32,ribbons()\y)
            Else
              ClipOutput(8,0,ribbons()\x-16,ribbons()\y)
            EndIf
          EndIf
          DrawingMode(#PB_2DDrawing_Outlined)
          RoundBox(ribbons()\hover\x,ribbons()\hover\y,ribbons()\hover\dx,ribbons()\hover\dy,ribbons()\roundness,ribbons()\roundness,rgbd(ribbons()\color,-56))
        EndIf  
      EndIf
      StopDrawing()
    EndIf
    
    If (ribbons()\hover\id<>ribbons()\hover\oldid Or force=#Ribbon_Render_Force Or ribbons()\Categories()\LastPadding<>ribbons()\Categories()\Padding) And Not ribbons()\noupdate And Not ItemGadgetIsVisible
      LockMutex(ttmutex)
      tooltip_aktuell=GetItemToolTip(ribbons()\hover\id)
      tooltip_header=GetItemToolTipHeader(ribbons()\hover\id)
      tooltip_symbol=GetItemToolTipSymbol(ribbons()\hover\id)
      tooltip_window=ribbons()\window
      tooltip_id=ribbons()\hover\id
      tooltip_delay=ribbons()\ToolTipDelay
      tooltip_style=ribbons()\ToolTipStyle
      UnlockMutex(ttmutex)
      If GadgetWidth(ribbons()\handle,#PB_Gadget_ActualSize)<>ribbons()\x
        ResizeGadget(ribbons()\handle,#PB_Ignore,#PB_Ignore,ribbons()\x,#PB_Ignore)
      EndIf
      If coldraw>0
        If ribbons()\flags&#Ribbon_Flag_NoHeader
          ry=106
        Else
          ry=128
        EndIf
        If coldraw=#Ribbon_Event_Dummy
          If ribbons()\collapsed
            ResizeGadget(ribbons()\handle,#PB_Ignore,#PB_Ignore,#PB_Ignore,24)
          Else
            ResizeGadget(ribbons()\handle,#PB_Ignore,#PB_Ignore,#PB_Ignore,ry)
          EndIf
        Else
          If coldraw=#Ribbon_Event_LeftClick
            If ribbons()\collapsed
              ResizeGadget(ribbons()\handle,#PB_Ignore,#PB_Ignore,#PB_Ignore,24)
            Else
              ResizeGadget(ribbons()\handle,#PB_Ignore,#PB_Ignore,#PB_Ignore,ry)
            EndIf
          EndIf
          ribbonevent=coldraw
          ribbonid=-1
        EndIf
      EndIf
      StopDrawing()
      StartDrawing(CanvasOutput(ribbons()\handle))
      If ribbons()\flags&#Ribbon_Flag_NoHeader
        DrawImage(ImageID(ribbons()\InternalRenderer),0,-22)
      Else
        DrawImage(ImageID(ribbons()\InternalRenderer),0,0)
      EndIf
      StopDrawing()
      ribbons()\DrawCount+1
    EndIf
    If ribbons()\extendedlogging
      LastElement(ribbons()\LogList())
      AddElement(ribbons()\LogList())
      ribbons()\LogList()\Timestamp=Date()
      ribbons()\LogList()\Type=rendertype;0=zeichnen,1=rendern
      ribbons()\LogList()\RenderTime=ElapsedMilliseconds()-time
    EndIf
    UnlockMutex(rMutex)
  EndProcedure
  Procedure Render(handle,force=0)
    Protected winstatus
    ForEach ribbons()
      If Not ribbons()\Locked
        CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
          winstatus=Bool(Not IsIconic_(ribbons()\window))
        CompilerElse
          winstatus=Bool(GetWindowState(ribbons()\window)<>#PB_Window_Minimize)
        CompilerEndIf
        If ribbons()\handle=handle And winstatus
          If force=#Ribbon_Render_Force:FreeImage(ribbons()\RibbonImage):EndIf
          ribbons()\Locked=#True
          RenderElements(1)
          ;If ListIndex(ribbons()\Categories())>-1 And ribbons()\Categories()\LastPadding<>ribbons()\Categories()\Padding
          ;  RenderElements(1)
          ;EndIf
          ribbons()\Locked=#False
          Break
        EndIf
      EndIf
    Next
  EndProcedure
  Procedure SetActiveCategory(id)
    Protected oldcat=-1
    ForEach ribbons()
      ForEach ribbons()\Categories()
        If ribbons()\Categories()\id=id
          oldcat=ribbons()\Category
          ribbons()\Category=id
          Render(ribbons()\handle,#Ribbon_Render_Force)
          Break 2
        EndIf
      Next
    Next
    ProcedureReturn oldcat
  EndProcedure
  Procedure Hide(handle,status=#Ribbon_Show_Alternate)
    Protected old=-1
    ForEach ribbons()
      If ribbons()\handle=handle
        old=ribbons()\hidden
        Select status
          Case #Ribbon_Show_Alternate
            ribbons()\hidden=#Ribbon_Show_Hide-ribbons()\hidden
          Case #Ribbon_Show_Hide,#Ribbon_Show_Show
            ribbons()\hidden=status
        EndSelect  
        If ribbons()\hidden=#Ribbon_Show_Show
          Render(ribbons()\handle,#Ribbon_Render_Force)
          HideGadget(ribbons()\handle,0)
        Else
          HideGadget(ribbons()\handle,1)
        EndIf
      EndIf
    Next
    ProcedureReturn old
  EndProcedure
  Procedure RemoveSubItems()
    ForEach ribbons()\Categories()\Groups()\items()\SubItems()
      SelectElement(ribbons()\Categories()\Groups()\items()\SubItems(),0)
      FreeImage(ribbons()\Categories()\Groups()\items()\SubItems()\image);If IsImage(ribbons()\Categories()\Groups()\items()\SubItems()\image):FreeImage(ribbons()\Categories()\Groups()\items()\SubItems()\image):EndIf
      If ribbons()\Categories()\Groups()\items()\SubItems()\type=#Ribbon_Type_Combobox
        UnbindEvent(#PB_Event_DeactivateWindow,@SimpleWindowCloser(),ribbons()\Categories()\Groups()\items()\SubItems()\AttachedWindow)
        UnbindGadgetEvent(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget,@ComboboxHandler(),#PB_EventType3D_Change)
      EndIf
      DeleteElement(ribbons()\Categories()\Groups()\items()\SubItems(),1)
    Next
  EndProcedure
  Procedure RemoveItems()
    ForEach ribbons()\Categories()\Groups()\items()
      SelectElement(ribbons()\Categories()\Groups()\items(),0)
      FreeImage(ribbons()\Categories()\Groups()\items()\image);If IsImage(ribbons()\Categories()\Groups()\items()\image):FreeImage(ribbons()\Categories()\Groups()\items()\image):EndIf
      RemoveSubItems()
      DeleteElement(ribbons()\Categories()\Groups()\items(),1)
    Next
  EndProcedure
  Procedure RemoveGroups()
    ForEach ribbons()\Categories()\Groups()
      SelectElement(ribbons()\Categories()\Groups(),0)
      FreeImage(ribbons()\Categories()\Groups()\image);If IsImage(ribbons()\Categories()\Groups()\image):FreeImage(ribbons()\Categories()\Groups()\image):EndIf
      RemoveItems()
      DeleteElement(ribbons()\Categories()\Groups(),1)
    Next
  EndProcedure
  Procedure RemoveCategories()
    ForEach ribbons()\Categories()
      SelectElement(ribbons()\Categories(),0)
      FreeImage(ribbons()\Categories()\image);If IsImage(ribbons()\Categories()\image):FreeImage(ribbons()\Categories()\image):EndIf
      RemoveGroups()
      DeleteElement(ribbons()\Categories(),1)
    Next
  EndProcedure
  Procedure InternalRemover(level)
    Select level
      Case 3
        RemoveSubItems()
      Case 2
        RemoveItems()
      Case 1
        RemoveGroups()
      Case 0
        RemoveCategories()
    EndSelect        
  EndProcedure
  Procedure RemoveItem(id)
    Protected level
    level=SetPointerToItem(id)
    If level>0 And level<4:InternalRemover(level):EndIf
    Select level
      Case 1
        FreeImage(ribbons()\Categories()\image);If IsImage(ribbons()\Categories()\image):FreeImage(ribbons()\Categories()\image):EndIf
        DeleteElement(ribbons()\Categories())
        Render(ribbons()\handle,#Ribbon_Render_Force)
        ProcedureReturn 1
      Case 2
        FreeImage(ribbons()\Categories()\Groups()\image);If IsImage(ribbons()\Categories()\Groups()\image):FreeImage(ribbons()\Categories()\Groups()\image):EndIf
        DeleteElement(ribbons()\Categories()\Groups())
      Case 3
        FreeImage(ribbons()\Categories()\Groups()\items()\image);If IsImage(ribbons()\Categories()\Groups()\items()\image):FreeImage(ribbons()\Categories()\Groups()\items()\image):EndIf
        DeleteElement(ribbons()\Categories()\Groups()\items())
      Case 4
        FreeImage(ribbons()\Categories()\Groups()\items()\SubItems()\image);If IsImage(ribbons()\Categories()\Groups()\items()\SubItems()\image):FreeImage(ribbons()\Categories()\Groups()\items()\SubItems()\image):EndIf
        DeleteElement(ribbons()\Categories()\Groups()\items()\SubItems())
      Case 5
        FreeImage(ribbons()\headitems()\image);If IsImage(ribbons()\headitems()\image):FreeImage(ribbons()\headitems()\image):EndIf
        DeleteElement(ribbons()\headitems(),1)
      Case 6
        FreeImage(ribbons()\rightheaditems()\image);If IsImage(ribbons()\rightheaditems()\image):FreeImage(ribbons()\rightheaditems()\image):EndIf
        DeleteElement(ribbons()\rightheaditems(),1)
      Default;Case 0
        ProcedureReturn 0
    EndSelect
    Render(ribbons()\handle)
    ProcedureReturn 1
  EndProcedure
  Procedure.s GetItemText(id)
    Select SetPointerToItem(id)
      Case 1
        ProcedureReturn ribbons()\Categories()\Text
      Case 2
        ProcedureReturn ribbons()\Categories()\Groups()\Text
      Case 3
        ProcedureReturn ribbons()\Categories()\Groups()\items()\Text
      Case 4
        ProcedureReturn ribbons()\Categories()\Groups()\items()\SubItems()\Text
      Case 5
        ProcedureReturn ribbons()\headitems()\Text
      Case 6
        ProcedureReturn ribbons()\rightheaditems()\Text
      Default
        ProcedureReturn ""
    EndSelect
  EndProcedure
  Procedure.s GetItemToolTip(id)
    Select SetPointerToItem(id)
      Case 1
        ProcedureReturn ribbons()\Categories()\ToolTip
      Case 2
        ProcedureReturn ribbons()\Categories()\Groups()\ToolTip
      Case 3
        ProcedureReturn ribbons()\Categories()\Groups()\items()\ToolTip
      Case 4
        ProcedureReturn ribbons()\Categories()\Groups()\items()\SubItems()\ToolTip
      Case 5
        ProcedureReturn ribbons()\headitems()\ToolTip
      Case 6
        ProcedureReturn ribbons()\rightheaditems()\ToolTip
      Default
        ProcedureReturn ""
    EndSelect
  EndProcedure
  Procedure.s GetItemToolTipHeader(id)
    Select SetPointerToItem(id)
      Case 1
        ProcedureReturn ribbons()\Categories()\ToolTipHeader
      Case 2
        ProcedureReturn ribbons()\Categories()\Groups()\ToolTipHeader
      Case 3
        ProcedureReturn ribbons()\Categories()\Groups()\items()\ToolTipHeader
      Case 4
        ProcedureReturn ribbons()\Categories()\Groups()\items()\SubItems()\ToolTipHeader
      Case 5
        ProcedureReturn ribbons()\headitems()\ToolTipHeader
      Case 6
        ProcedureReturn ribbons()\rightheaditems()\ToolTipHeader
      Default
        ProcedureReturn ""
    EndSelect
  EndProcedure
  Procedure GetItemToolTipSymbol(id)
    Select SetPointerToItem(id)
      Case 1
        ProcedureReturn ribbons()\Categories()\ToolTipSymbol
      Case 2
        ProcedureReturn ribbons()\Categories()\Groups()\ToolTipSymbol
      Case 3
        ProcedureReturn ribbons()\Categories()\Groups()\items()\ToolTipSymbol
      Case 4
        ProcedureReturn ribbons()\Categories()\Groups()\items()\SubItems()\ToolTipSymbol
      Case 5
        ProcedureReturn ribbons()\headitems()\ToolTipSymbol
      Case 6
        ProcedureReturn ribbons()\rightheaditems()\ToolTipSymbol
      Default
        ProcedureReturn 0
    EndSelect
  EndProcedure
  Procedure SetItemText(id,text.s)
    Select SetPointerToItem(id)
      Case 1
        ribbons()\Categories()\Text=text
        Render(ribbons()\handle,#Ribbon_Render_Force)
        ProcedureReturn 1
      Case 2
        ribbons()\Categories()\Groups()\Text=text
      Case 3
        ribbons()\Categories()\Groups()\items()\Text=text
      Case 4
        ribbons()\Categories()\Groups()\items()\SubItems()\Text=text
      Case 5
        ribbons()\headitems()\Text=text
      Case 6
        ribbons()\rightheaditems()\Text=text
      Default;Case 0
        ProcedureReturn 0
    EndSelect
    Render(ribbons()\handle)
    ProcedureReturn 1
  EndProcedure
  Procedure SetItemToolTip(id,text.s,header.s,symbol.i)
    Select SetPointerToItem(id)
      Case 1
        ribbons()\Categories()\ToolTip=text
        ribbons()\Categories()\ToolTipHeader=header
        ribbons()\Categories()\ToolTipSymbol=symbol
      Case 2
        ribbons()\Categories()\Groups()\ToolTip=text
        ribbons()\Categories()\Groups()\ToolTipHeader=header
        ribbons()\Categories()\Groups()\ToolTipSymbol=symbol
      Case 3
        ribbons()\Categories()\Groups()\items()\ToolTip=text
        ribbons()\Categories()\Groups()\items()\ToolTipHeader=header
        ribbons()\Categories()\Groups()\items()\ToolTipSymbol=symbol
      Case 4
        ribbons()\Categories()\Groups()\items()\SubItems()\ToolTip=text
        ribbons()\Categories()\Groups()\items()\SubItems()\ToolTipHeader=header
        ribbons()\Categories()\Groups()\items()\SubItems()\ToolTipSymbol=symbol
      Case 5
        ribbons()\headitems()\ToolTip=text
        ribbons()\headitems()\ToolTipHeader=header
        ribbons()\headitems()\ToolTipSymbol=symbol
      Case 6
        ribbons()\rightheaditems()\ToolTip=text
        ribbons()\rightheaditems()\ToolTipHeader=header
        ribbons()\rightheaditems()\ToolTipSymbol=symbol
      Default;Case 0
        ProcedureReturn 0
    EndSelect
    ProcedureReturn 1
  EndProcedure
  Procedure GetItemStatusFlag(id,flag)
    Select SetPointerToItem(id)
      Case 1
        ProcedureReturn ribbons()\Categories()\status&flag
      Case 2
        ProcedureReturn ribbons()\Categories()\Groups()\status&flag
      Case 3
        ProcedureReturn ribbons()\Categories()\Groups()\items()\status&flag
      Case 4
        ProcedureReturn ribbons()\Categories()\Groups()\items()\SubItems()\status&flag
      Case 5
        ProcedureReturn ribbons()\headitems()\status&flag
      Case 6
        ProcedureReturn ribbons()\rightheaditems()\status&flag
      Default
        ProcedureReturn -1
    EndSelect
  EndProcedure
  Procedure GetItemStatus(id)
    Select SetPointerToItem(id)
      Case 1
        ProcedureReturn ribbons()\Categories()\status
      Case 2
        ProcedureReturn ribbons()\Categories()\Groups()\status
      Case 3
        ProcedureReturn ribbons()\Categories()\Groups()\items()\status
      Case 4
        ProcedureReturn ribbons()\Categories()\Groups()\items()\SubItems()\status
      Case 5
        ProcedureReturn ribbons()\headitems()\status
      Case 6
        ProcedureReturn ribbons()\rightheaditems()\status
      Default
        ProcedureReturn -1
    EndSelect
  EndProcedure
  Procedure SetItemCheckStatus(id,status)
    Protected old,ctemp
    Select SetPointerToItem(id)
      Case 1
        SetCheckFlags(ribbons()\Categories()\status)
      Case 2
        SetCheckFlags(ribbons()\Categories()\Groups()\status)
      Case 3
        SetCheckFlags(ribbons()\Categories()\Groups()\items()\status)
      Case 4
        SetCheckFlags(ribbons()\Categories()\Groups()\items()\SubItems()\status)
      Case 5
        SetCheckFlags(ribbons()\headitems()\status)
      Case 6
        SetCheckFlags(ribbons()\rightheaditems()\status)
      Default;Case 0
        ProcedureReturn -1
    EndSelect
    Render(ribbons()\handle)
    ProcedureReturn old
  EndProcedure
  Procedure GetItemCheckStatus(id)
    Protected old
    Select SetPointerToItem(id)
      Case 1
        GetCheckFlag(ribbons()\Categories()\status)
      Case 2
        GetCheckFlag(ribbons()\Categories()\Groups()\status)
      Case 3
        GetCheckFlag(ribbons()\Categories()\Groups()\items()\status)
      Case 4
        GetCheckFlag(ribbons()\Categories()\Groups()\items()\SubItems()\status)
      Case 5
        GetCheckFlag(ribbons()\headitems()\status)
      Case 6
        GetCheckFlag(ribbons()\rightheaditems()\status)
      Default;Case 0
        ProcedureReturn -1
    EndSelect
    ProcedureReturn old
  EndProcedure
  Procedure SetItemStatus(id,status)
    Protected old
    Select SetPointerToItem(id)
      Case 1
        SetStatusFlags(ribbons()\Categories()\status)
        If (ribbons()\Categories()\status&#Ribbon_Status_Hidden<>0) And ribbons()\Category=id
          ribbons()\Category=-1
        EndIf
        ;FreeImage(ribbons()\InternalRenderer);If IsImage(ribbons()\InternalRenderer):FreeImage(ribbons()\InternalRenderer):EndIf
        Render(ribbons()\handle,#Ribbon_Render_Force)
        ProcedureReturn old
      Case 2
        SetStatusFlags(ribbons()\Categories()\Groups()\status)
      Case 3
        SetStatusFlags(ribbons()\Categories()\Groups()\items()\status)
      Case 4
        SetStatusFlags(ribbons()\Categories()\Groups()\items()\SubItems()\status)
      Case 5
        SetStatusFlags(ribbons()\headitems()\status)
      Case 6
        SetStatusFlags(ribbons()\rightheaditems()\status)
      Default;Case 0
        ProcedureReturn -1
    EndSelect
    Render(ribbons()\handle)
    ProcedureReturn old
  EndProcedure
  Procedure AddItemStatus(id,status)
    Protected old
    Select SetPointerToItem(id)
      Case 1
        old=ribbons()\Categories()\status
        ribbons()\Categories()\status=ribbons()\Categories()\status|status
      Case 2
        old=ribbons()\Categories()\Groups()\status
        ribbons()\Categories()\Groups()\status=ribbons()\Categories()\Groups()\status|status
      Case 3
        old=ribbons()\Categories()\Groups()\items()\status
        ribbons()\Categories()\Groups()\items()\status=ribbons()\Categories()\Groups()\items()\status|status
      Case 4
        old=ribbons()\Categories()\Groups()\items()\SubItems()\status
        ribbons()\Categories()\Groups()\items()\SubItems()\status=ribbons()\Categories()\Groups()\items()\SubItems()\status|status
      Case 5
        old=ribbons()\headitems()\status
        ribbons()\headitems()\status=ribbons()\headitems()\status|status
      Case 6
        old=ribbons()\rightheaditems()\status
        ribbons()\rightheaditems()\status=ribbons()\rightheaditems()\status|status
      Default;Case 0
        ProcedureReturn -1
    EndSelect
    Render(ribbons()\handle)
    ProcedureReturn old
  EndProcedure
  Procedure SubItemStatus(id,status)
    Protected old
    Select SetPointerToItem(id)
      Case 1
        old=ribbons()\Categories()\status
        ribbons()\Categories()\status=ribbons()\Categories()\status&~status
      Case 2
        old=ribbons()\Categories()\Groups()\status
        ribbons()\Categories()\Groups()\status=ribbons()\Categories()\Groups()\status&~status
      Case 3
        old=ribbons()\Categories()\Groups()\items()\status
        ribbons()\Categories()\Groups()\items()\status=ribbons()\Categories()\Groups()\items()\status&~status
      Case 4
        old=ribbons()\Categories()\Groups()\items()\SubItems()\status
        ribbons()\Categories()\Groups()\items()\SubItems()\status=ribbons()\Categories()\Groups()\items()\SubItems()\status&~status
      Case 5
        old=ribbons()\headitems()\status
        ribbons()\headitems()\status=ribbons()\headitems()\status&~status
      Case 6
        old=ribbons()\rightheaditems()\status
        ribbons()\rightheaditems()\status=ribbons()\rightheaditems()\status&~status
      Default;Case 0
        ProcedureReturn -1
    EndSelect
    Render(ribbons()\handle)
    ProcedureReturn old
  EndProcedure
  Procedure GetItemImage(id)
    Select SetPointerToItem(id)
      Case 1
        ProcedureReturn ribbons()\Categories()\image
      Case 2
        ProcedureReturn ribbons()\Categories()\Groups()\image
      Case 3
        ProcedureReturn ribbons()\Categories()\Groups()\items()\image
      Case 4
        ProcedureReturn ribbons()\Categories()\Groups()\items()\SubItems()\image
      Case 5
        ProcedureReturn ribbons()\headitems()\image
      Case 6
        ProcedureReturn ribbons()\rightheaditems()\image
      Default
        ProcedureReturn -1
    EndSelect
  EndProcedure
  Procedure SetItemImage(id,image)
    Protected old,tempimage,dimensions.bitmap,temp
    Select SetPointerToItem(id)
      Case 1
        old=ribbons()\Categories()\image
        
        temp=20;18?
        CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
          If image=#Ribbon_Image_None
            tempimage=#Ribbon_Image_None
          Else
            GetObject_(image,SizeOf(dimensions),dimensions)
            tempimage=CreateImage(#PB_Any,dimensions\bmWidth,dimensions\bmHeight)
            StartDrawing(ImageOutput(tempimage))
            DrawImage(image,0,0)
            StopDrawing()
            If ImageFormat(tempimage)<>#PB_ImagePlugin_ICON And dimensions\bmHeight<>temp:ResizeImage(tempimage,Int(temp*dimensions\bmWidth/dimensions\bmHeight),temp,#PB_Image_Smooth):EndIf
          EndIf
        CompilerElse
          If IsImage(image);image<>#Ribbon_Image_None And 
            If ribbons()\Categories()\status&#Ribbon_Status_UseOriginalImage
              tempimage=image
            Else
              tempimage=CopyImage(image,#PB_Any)
            EndIf
            If ImageFormat(tempimage)<>#PB_ImagePlugin_ICON And ImageHeight(image)<>temp:ResizeImage(tempimage,Int(temp*ImageWidth(image)/ImageHeight(image)),temp,#PB_Image_Smooth):EndIf
          Else
            tempimage=#Ribbon_Image_None
          EndIf
        CompilerEndIf
        
        ribbons()\Categories()\image=tempimage;image
      Case 2
        old=ribbons()\Categories()\Groups()\image
        
        temp=20;18?
        CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
          If image=#Ribbon_Image_None
            tempimage=#Ribbon_Image_None
          Else
            GetObject_(image,SizeOf(dimensions),dimensions)
            tempimage=CreateImage(#PB_Any,dimensions\bmWidth,dimensions\bmHeight)
            StartDrawing(ImageOutput(tempimage))
            DrawImage(image,0,0)
            StopDrawing()
            If ImageFormat(tempimage)<>#PB_ImagePlugin_ICON And dimensions\bmHeight<>temp:ResizeImage(tempimage,Int(temp*dimensions\bmWidth/dimensions\bmHeight),temp,#PB_Image_Smooth):EndIf
          EndIf
        CompilerElse
          If image<>#Ribbon_Image_None And IsImage(image)
            If ribbons()\Categories()\Groups()\status&#Ribbon_Status_UseOriginalImage
              tempimage=image
            Else
              tempimage=CopyImage(image,#PB_Any)
            EndIf
            If ImageFormat(tempimage)<>#PB_ImagePlugin_ICON And ImageHeight(image)<>temp:ResizeImage(tempimage,Int(temp*ImageWidth(image)/ImageHeight(image)),temp,#PB_Image_Smooth):EndIf
          Else
            tempimage=#Ribbon_Image_None
          EndIf
        CompilerEndIf
        
        ribbons()\Categories()\Groups()\image=tempimage;image
      Case 3
        old=ribbons()\Categories()\Groups()\items()\image
        Select ribbons()\Categories()\Groups()\items()\type
          Case #Ribbon_Type_Image,#Ribbon_Type_ImageButton,#Ribbon_Type_Button
            If ribbons()\Categories()\Groups()\items()\type=#Ribbon_Type_Button:temp=48:Else:temp=68:EndIf
            CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
              If image=#Ribbon_Image_None
                tempimage=#Ribbon_Image_None
              Else
                GetObject_(image,SizeOf(dimensions),dimensions)
                tempimage=CreateImage(#PB_Any,dimensions\bmWidth,dimensions\bmHeight)
                StartDrawing(ImageOutput(tempimage))
                DrawImage(image,0,0)
                StopDrawing()
                If ImageFormat(tempimage)<>#PB_ImagePlugin_ICON And dimensions\bmHeight<>temp:ResizeImage(tempimage,Int(temp*dimensions\bmWidth/dimensions\bmHeight),temp,#PB_Image_Smooth):EndIf
              EndIf
            CompilerElse
              If IsImage(image);image<>#Ribbon_Image_None And 
                If ribbons()\Categories()\Groups()\items()\status&#Ribbon_Status_UseOriginalImage
                  tempimage=image
                Else
                  tempimage=CopyImage(image,#PB_Any)
                EndIf
                If ImageFormat(tempimage)<>#PB_ImagePlugin_ICON And ImageHeight(image)<>temp:ResizeImage(tempimage,Int(temp*ImageWidth(image)/ImageHeight(image)),temp,#PB_Image_Smooth):EndIf
              Else
                tempimage=#Ribbon_Image_None
              EndIf
            CompilerEndIf
        EndSelect
        ribbons()\Categories()\Groups()\items()\image=tempimage
      Case 4
        old=ribbons()\Categories()\Groups()\items()\SubItems()\image
        temp=20;18?
        CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
          If image=#Ribbon_Image_None
            tempimage=#Ribbon_Image_None
          Else
            GetObject_(image,SizeOf(dimensions),dimensions)
            tempimage=CreateImage(#PB_Any,dimensions\bmWidth,dimensions\bmHeight)
            StartDrawing(ImageOutput(tempimage))
            DrawImage(image,0,0)
            StopDrawing()
            If ImageFormat(tempimage)<>#PB_ImagePlugin_ICON And dimensions\bmHeight<>temp:ResizeImage(tempimage,Int(temp*dimensions\bmWidth/dimensions\bmHeight),temp,#PB_Image_Smooth):EndIf
          EndIf
        CompilerElse
          If IsImage(image);image<>#Ribbon_Image_None And 
            If ribbons()\Categories()\Groups()\items()\SubItems()\status&#Ribbon_Status_UseOriginalImage
              tempimage=image
            Else
              tempimage=CopyImage(image,#PB_Any)
            EndIf
            If ImageFormat(tempimage)<>#PB_ImagePlugin_ICON And ImageHeight(image)<>temp:ResizeImage(tempimage,Int(temp*ImageWidth(image)/ImageHeight(image)),temp,#PB_Image_Smooth):EndIf
          Else
            tempimage=#Ribbon_Image_None
          EndIf
        CompilerEndIf
        ribbons()\Categories()\Groups()\items()\SubItems()\image=tempimage;image
      Case 5
        old=ribbons()\headitems()\image
        Select ribbons()\headitems()\type
          Case #Ribbon_Type_HeadImage,#Ribbon_Type_HeadImageButton
            If ribbons()\headitems()\type=#Ribbon_Type_HeadImage:temp=20:Else:temp=18:EndIf
            CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
              If image=#Ribbon_Image_None
                tempimage=#Ribbon_Image_None
              Else
                GetObject_(image,SizeOf(dimensions),dimensions)
                tempimage=CreateImage(#PB_Any,dimensions\bmWidth,dimensions\bmHeight)
                StartDrawing(ImageOutput(tempimage))
                DrawImage(image,0,0)
                StopDrawing()
                If ImageFormat(tempimage)<>#PB_ImagePlugin_ICON And dimensions\bmHeight<>temp:ResizeImage(tempimage,Int(temp*dimensions\bmWidth/dimensions\bmHeight),temp,#PB_Image_Smooth):EndIf
              EndIf
            CompilerElse
              If IsImage(image);image<>#Ribbon_Image_None And 
                If ribbons()\headitems()\status&#Ribbon_Status_UseOriginalImage
                  tempimage=image
                Else
                  tempimage=CopyImage(image,#PB_Any)
                EndIf
                If ImageFormat(tempimage)<>#PB_ImagePlugin_ICON And ImageHeight(image)<>temp:ResizeImage(tempimage,Int(temp*ImageWidth(image)/ImageHeight(image)),temp,#PB_Image_Smooth):EndIf
              Else
                tempimage=#Ribbon_Image_None
              EndIf
            CompilerEndIf
        EndSelect
        ribbons()\headitems()\image=tempimage
      Case 6
        old=ribbons()\rightheaditems()\image
        Select ribbons()\rightheaditems()\type
          Case #Ribbon_Type_RightHeadImage,#Ribbon_Type_RightHeadImageButton
            If ribbons()\rightheaditems()\type=#Ribbon_Type_RightHeadImage:temp=20:Else:temp=18:EndIf
            CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
              If image=#Ribbon_Image_None
                tempimage=#Ribbon_Image_None
              Else
                GetObject_(image,SizeOf(dimensions),dimensions)
                tempimage=CreateImage(#PB_Any,dimensions\bmWidth,dimensions\bmHeight)
                StartDrawing(ImageOutput(tempimage))
                DrawImage(image,0,0)
                StopDrawing()
                If ImageFormat(tempimage)<>#PB_ImagePlugin_ICON And dimensions\bmHeight<>temp:ResizeImage(tempimage,Int(temp*dimensions\bmWidth/dimensions\bmHeight),temp,#PB_Image_Smooth):EndIf
              EndIf
            CompilerElse
              If IsImage(image);image<>#Ribbon_Image_None And 
                If ribbons()\rightheaditems()\status&#Ribbon_Status_UseOriginalImage
                  tempimage=image
                Else
                  tempimage=CopyImage(image,#PB_Any)
                EndIf
                If ImageFormat(tempimage)<>#PB_ImagePlugin_ICON And ImageHeight(image)<>temp:ResizeImage(tempimage,Int(temp*ImageWidth(image)/ImageHeight(image)),temp,#PB_Image_Smooth):EndIf
              Else
                tempimage=#Ribbon_Image_None
              EndIf
            CompilerEndIf
        EndSelect
        ribbons()\rightheaditems()\image=tempimage
      Default;Case 0
        ProcedureReturn -1
    EndSelect
    FreeImage(old);If IsImage(old):FreeImage(old):EndIf
    Render(ribbons()\handle)
    ProcedureReturn old
  EndProcedure
  Procedure GetItemType(id)
    Select SetPointerToItem(id)
      Case 1
        ProcedureReturn ribbons()\Categories()\type
      Case 2
        ProcedureReturn ribbons()\Categories()\Groups()\type
      Case 3
        ProcedureReturn ribbons()\Categories()\Groups()\items()\type
      Case 4
        ProcedureReturn ribbons()\Categories()\Groups()\items()\SubItems()\type
      Case 5
        ProcedureReturn ribbons()\headitems()\type
      Case 6
        ProcedureReturn ribbons()\rightheaditems()\type
      Default
        ProcedureReturn #Ribbon_Type_None
    EndSelect
  EndProcedure
  Procedure SetFont(handle,font.s)
    Protected old
    ForEach ribbons()
      If ribbons()\handle=handle
        old+1
        FreeFont(ribbons()\font)
        FreeFont(ribbons()\smallfont)
        ribbons()\font=LoadFont(#PB_Any,font,10,#PB_Font_HighQuality)
        ribbons()\smallfont=LoadFont(#PB_Any,font,8,#PB_Font_HighQuality)
        Render(ribbons()\handle,#Ribbon_Render_Force)
        Break
      EndIf
    Next
    ProcedureReturn old
  EndProcedure
  Macro PrepareImage(resize=0)
    CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
      If image=#Ribbon_Image_None
        tempimage=#Ribbon_Image_None
      Else
        tempimage=CreateImage(#PB_Any,dimensions\bmWidth,dimensions\bmHeight,32,#PB_Image_Transparent)
        If tempimage
          StartDrawing(ImageOutput(tempimage))
          DrawingMode(#PB_2DDrawing_AllChannels)
          DrawImage(image,0,0)
          StopDrawing()
          If resize And ImageFormat(tempimage)<>#PB_ImagePlugin_ICON And dimensions\bmHeight<>resize:ResizeImage(tempimage,Int(resize*dimensions\bmWidth/dimensions\bmHeight),resize,#PB_Image_Smooth):EndIf
        Else
          tempimage=#Ribbon_Image_None
        EndIf  
      EndIf
    CompilerElse
      If image<>#Ribbon_Image_None And IsImage(image)
        If status&#Ribbon_Status_UseOriginalImage
          tempimage=image
        Else
          tempimage=CopyImage(image,#PB_Any)
        EndIf
        If resize And ImageFormat(tempimage)<>#PB_ImagePlugin_ICON And ImageHeight(image)<>resize:ResizeImage(tempimage,Int(resize*ImageWidth(image)/ImageHeight(image)),resize,#PB_Image_Smooth):EndIf
      Else
        tempimage=#Ribbon_Image_None
      EndIf
    CompilerEndIf
  EndMacro
  Procedure AddItem(parent,id,typ,text.s="",image=#Ribbon_Image_None,status=0);Rückgabe:-2->ID ungültig,-1->ID schon vorhanden,0->Item konnte nicht angelegt werden,>0->ID des neuen Elements
    Protected tempimage,tempid=1,ogl
    
    Protected icoinfo.iconinfo,x,y,color
    
    If id<1
      If id=#PB_Any
        While SetPointerToItem(tempid)>0
          tempid+1
        Wend
        id=tempid
      Else  
        ProcedureReturn -2
      EndIf
    ElseIf SetPointerToItem(id)>0
      ProcedureReturn -1
    EndIf
    
    CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL;Test, ob image ein Bild enthält (nur DLL)
      Protected gotemp,dimensions.bitmap,icon.iconinfo
      gotemp=GetObject_(image,SizeOf(dimensions),@dimensions)
      If Not gotemp
        GetIconInfo_(image,icon)
        gotemp=GetObject_(icon\hbmMask,SizeOf(dimensions),@dimensions)
      EndIf
      If Not gotemp
        tempimage=#Ribbon_Image_None
      EndIf
    CompilerEndIf
    
    Select typ
        
      Case #Ribbon_Type_Category
        ForEach ribbons()
          If ribbons()\handle=parent
            AddElement(ribbons()\Categories())
            ribbons()\Categories()\id=id
            ribbons()\Categories()\status=0
            ribbons()\Categories()\text=text
            ribbons()\Categories()\status=status
            
            PrepareImage(20);18
            ribbons()\Categories()\image=tempimage
            
            ribbons()\Categories()\type=typ
            If ListSize(ribbons()\Categories())=1
              ribbons()\Category=id  
            EndIf
            Break
          EndIf
        Next
        
      Case #Ribbon_Type_HeadButton,#Ribbon_Type_HeadPushButton,#Ribbon_Type_HeadSeparator
        ForEach ribbons()
          If ribbons()\handle=parent
            AddElement(ribbons()\headitems())
            ribbons()\headitems()\id=id
            ribbons()\headitems()\status=0
            ribbons()\headitems()\status=status
            
            PrepareImage(20);18
            ribbons()\headitems()\image=tempimage
            
            ribbons()\headitems()\type=typ
            ribbons()\headitems()\text=text
            Break
          EndIf
        Next
        
      Case #Ribbon_Type_RightHeadButton,#Ribbon_Type_RightHeadPushButton,#Ribbon_Type_RightHeadText,#Ribbon_Type_RightHeadSeparator,#Ribbon_Type_RightHeadTextButton
        ForEach ribbons()
          If ribbons()\handle=parent
            AddElement(ribbons()\rightheaditems())
            ribbons()\rightheaditems()\id=id
            ribbons()\rightheaditems()\status=0
            ribbons()\rightheaditems()\status=status
            
            PrepareImage(20);18
            ribbons()\rightheaditems()\image=tempimage
            
            ribbons()\rightheaditems()\type=typ
            ribbons()\rightheaditems()\text=text
            Break
          EndIf
        Next
        
      Case #Ribbon_Type_HeadImage,#Ribbon_Type_HeadImageButton
        ForEach ribbons()
          If ribbons()\handle=parent
            AddElement(ribbons()\headitems())
            If typ=#Ribbon_Type_HeadImage
              PrepareImage(20)
            Else
              PrepareImage(18)
            EndIf
            ribbons()\headitems()\image=tempimage
            ribbons()\headitems()\id=id
            ribbons()\headitems()\status=0
            ribbons()\headitems()\text=text
            ribbons()\headitems()\status=status
            ribbons()\headitems()\type=typ
            Break
          EndIf
        Next
        
      Case #Ribbon_Type_RightHeadImage,#Ribbon_Type_RightHeadImageButton
        ForEach ribbons()
          If ribbons()\handle=parent
            AddElement(ribbons()\rightheaditems())
            If typ=#Ribbon_Type_RightHeadImage
              PrepareImage(20)
            Else
              PrepareImage(18)
            EndIf
            ribbons()\rightheaditems()\image=tempimage
            ribbons()\rightheaditems()\id=id
            ribbons()\rightheaditems()\status=0
            ribbons()\rightheaditems()\text=text
            ribbons()\rightheaditems()\status=status
            ribbons()\rightheaditems()\type=typ
            Break
          EndIf
        Next
        
      Default
        Select SetPointerToItem(parent)
          Case 1;Category
            If typ=#Ribbon_Type_Group
              AddElement(ribbons()\Categories()\Groups())
              ribbons()\Categories()\Groups()\id=id
              ribbons()\Categories()\Groups()\status=0
              ribbons()\Categories()\Groups()\text=text
              ribbons()\Categories()\Groups()\status=status
              PrepareImage(20);18
              ribbons()\Categories()\Groups()\image=tempimage
              ribbons()\Categories()\Groups()\type=typ
            Else
              ProcedureReturn 0
            EndIf
          Case 2;Group
            Select typ
              Case #Ribbon_Type_Button,#Ribbon_Type_ButtonContainer,#Ribbon_Type_Checkbox,#Ribbon_Type_Checkbox,#Ribbon_Type_Container,#Ribbon_Type_PushButton,#Ribbon_Type_Separator
                AddElement(ribbons()\Categories()\Groups()\items())
                ribbons()\Categories()\Groups()\items()\id=id
                ribbons()\Categories()\Groups()\items()\status=0
                ribbons()\Categories()\Groups()\items()\text=text
                ribbons()\Categories()\Groups()\items()\status=status
                PrepareImage(48)
                ribbons()\Categories()\Groups()\items()\image=tempimage
                ribbons()\Categories()\Groups()\items()\type=typ
              Case #Ribbon_Type_Image,#Ribbon_Type_ImageButton
                AddElement(ribbons()\Categories()\Groups()\items())
                If typ=#Ribbon_Type_Image
                  PrepareImage(70)
                Else
                  PrepareImage(68)
                EndIf
                ribbons()\Categories()\Groups()\items()\image=tempimage
                ribbons()\Categories()\Groups()\items()\id=id
                ribbons()\Categories()\Groups()\items()\status=0
                ribbons()\Categories()\Groups()\items()\text=text
                ribbons()\Categories()\Groups()\items()\status=status
                ribbons()\Categories()\Groups()\items()\type=typ
              Default
                ProcedureReturn 0    
            EndSelect
          Case 3;Container/ButtonContainer
            Select ribbons()\Categories()\Groups()\items()\type
              Case #Ribbon_Type_Container
                Select typ
                  Case #Ribbon_Type_Button,#Ribbon_Type_PushButton,#Ribbon_Type_Checkbox,#Ribbon_Type_RadioButton,#Ribbon_Type_Combobox
                    If ListSize(ribbons()\Categories()\Groups()\items()\SubItems())>=3
                      ProcedureReturn 0
                    Else
                      AddElement(ribbons()\Categories()\Groups()\items()\SubItems())
                      ribbons()\Categories()\Groups()\items()\SubItems()\id=id
                      ribbons()\Categories()\Groups()\items()\SubItems()\status=0
                      ribbons()\Categories()\Groups()\items()\SubItems()\text=text
                      ribbons()\Categories()\Groups()\items()\SubItems()\status=status
                      PrepareImage(20);18
                      ribbons()\Categories()\Groups()\items()\SubItems()\image=tempimage
                      ribbons()\Categories()\Groups()\items()\SubItems()\type=typ
                      If typ=#Ribbon_Type_Combobox
                        ogl=UseGadgetList(0)
                        CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
                          ribbons()\Categories()\Groups()\items()\SubItems()\AttachedWindow=OpenWindow(#PB_Any,0,0,100,100,"",#PB_Window_Invisible|#PB_Window_BorderLess|#PB_Window_NoActivate,ribbons()\window)
                        CompilerElse
                          ribbons()\Categories()\Groups()\items()\SubItems()\AttachedWindow=OpenWindow(#PB_Any,0,0,100,100,"",#PB_Window_Invisible|#PB_Window_BorderLess|#PB_Window_NoActivate,WindowID(ribbons()\window))
                        CompilerEndIf
                        ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget=ListIconGadget(#PB_Any,0,0,100,100,"",0,#PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_FullRowSelect|#LVS_NOCOLUMNHEADER)
                        ;SendMessage_(GadgetID(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget),#LVM_SETEXTENDEDLISTVIEWSTYLE,#LVS_EX_GRIDLINES,#LVS_EX_GRIDLINES)
                        SendMessage_(GadgetID(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget),#WM_SETFONT,FontID(ribbons()\smallfont),0)
                        SendMessage_(GadgetID(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget),#LVM_DELETECOLUMN,0,0)
                        SetGadgetColor(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget,#PB_Gadget_BackColor,ribbons()\color)
                        SetGadgetColor(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget,#PB_Gadget_FrontColor,ribbons()\accentcolor)
                        ;SetGadgetColor(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget,#PB_Gadget_LineColor,0)
                        SetWindowData(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedWindow,@ribbons()\Categories()\Groups()\items()\SubItems())
                        SetGadgetData(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget,@ribbons()\Categories()\Groups()\items()\SubItems())
                        ribbons()\Categories()\Groups()\items()\SubItems()\MainWindow=ribbons()\window
                        ribbons()\Categories()\Groups()\items()\SubItems()\Ribbon=ribbons()\handle
                        BindGadgetEvent(ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget,@ComboboxHandler(),#PB_EventType_Change)
                        BindEvent(#PB_Event_DeactivateWindow,@SimpleWindowCloser(),ribbons()\Categories()\Groups()\items()\SubItems()\AttachedWindow)
                        UseGadgetList(ogl)
                      EndIf
                    EndIf
                  Default
                    ProcedureReturn 0
                EndSelect
              Case #Ribbon_Type_ButtonContainer
                Select typ
                  Case #Ribbon_Type_Button,#Ribbon_Type_PushButton,#Ribbon_Type_Separator
                    AddElement(ribbons()\Categories()\Groups()\items()\SubItems())
                    ribbons()\Categories()\Groups()\items()\SubItems()\id=id
                    ribbons()\Categories()\Groups()\items()\SubItems()\status=0
                    ribbons()\Categories()\Groups()\items()\SubItems()\text=text
                    ribbons()\Categories()\Groups()\items()\SubItems()\status=status
                    PrepareImage(20);18                  
                    ribbons()\Categories()\Groups()\items()\SubItems()\image=tempimage
                    ribbons()\Categories()\Groups()\items()\SubItems()\type=typ
                  Default
                    ProcedureReturn 0
                EndSelect
            EndSelect
          Default
            ProcedureReturn 0
        EndSelect   
    EndSelect
    CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
      If IsImage(tempimage) And ribbons()\flags&#Ribbon_Flag_DiscardImages
        Select ImageFormat(tempimage)
          Case #PB_ImagePlugin_ICON
            DestroyIcon_(image)
          Case #PB_ImagePlugin_BMP
            DeleteObject_(image)
        EndSelect
      EndIf
    CompilerEndIf
    ProcedureReturn id
  EndProcedure
  Procedure GetItemGadget(id)
    Select SetPointerToItem(id)
      Case 4
        ProcedureReturn ribbons()\Categories()\Groups()\items()\SubItems()\AttachedGadget
      Default
        ProcedureReturn -1
    EndSelect
  EndProcedure
  Procedure SetItemPosition(id,position)
    Protected level,*quell,*ziel,oldpos
    level=SetPointerToItem(id)
    Select level
      Case 1
        oldpos=ListIndex(ribbons()\Categories())
        *quell=@ribbons()\Categories()
        ResetList(ribbons()\Categories())
        SelectElement(ribbons()\Categories(),position)
        *ziel=InsertElement(ribbons()\Categories())
        SwapElements(ribbons()\Categories(),*quell,*ziel)
        ChangeCurrentElement(ribbons()\Categories(),*ziel)
        DeleteElement(ribbons()\Categories())
        Render(ribbons()\handle,#Ribbon_Render_Force)
        ProcedureReturn oldpos
      Case 2
        oldpos=ListIndex(ribbons()\Categories()\Groups())
        *quell=@ribbons()\Categories()\Groups()
        ResetList(ribbons()\Categories()\Groups())
        SelectElement(ribbons()\Categories()\Groups(),position)
        *ziel=InsertElement(ribbons()\Categories()\Groups())
        SwapElements(ribbons()\Categories()\Groups(),*quell,*ziel)
        ChangeCurrentElement(ribbons()\Categories()\Groups(),*ziel)
        DeleteElement(ribbons()\Categories()\Groups())
      Case 3
        oldpos=ListIndex(ribbons()\Categories()\Groups()\items())
        *quell=@ribbons()\Categories()\Groups()\items()
        ResetList(ribbons()\Categories()\Groups()\items())
        SelectElement(ribbons()\Categories()\Groups()\items(),position)
        *ziel=InsertElement(ribbons()\Categories()\Groups()\items())
        SwapElements(ribbons()\Categories()\Groups()\items(),*quell,*ziel)
        ChangeCurrentElement(ribbons()\Categories()\Groups()\items(),*ziel)
        DeleteElement(ribbons()\Categories()\Groups()\items())
      Case 4
        oldpos=ListIndex(ribbons()\Categories()\Groups()\items()\SubItems())
        *quell=@ribbons()\Categories()\Groups()\items()\SubItems()
        ResetList(ribbons()\Categories()\Groups()\items()\SubItems())
        SelectElement(ribbons()\Categories()\Groups()\items()\SubItems(),position)
        *ziel=InsertElement(ribbons()\Categories()\Groups()\items()\SubItems())
        SwapElements(ribbons()\Categories()\Groups()\items()\SubItems(),*quell,*ziel)
        ChangeCurrentElement(ribbons()\Categories()\Groups()\items()\SubItems(),*ziel)
        DeleteElement(ribbons()\Categories()\Groups()\items()\SubItems())
      Case 5
        oldpos=ListIndex(ribbons()\headitems())
        *quell=@ribbons()\headitems()
        ResetList(ribbons()\headitems())
        SelectElement(ribbons()\headitems(),position)
        *ziel=InsertElement(ribbons()\headitems())
        SwapElements(ribbons()\headitems(),*quell,*ziel)
        ChangeCurrentElement(ribbons()\headitems(),*ziel)
        DeleteElement(ribbons()\headitems())
      Case 6
        oldpos=ListIndex(ribbons()\rightheaditems())
        *quell=@ribbons()\rightheaditems()
        ResetList(ribbons()\rightheaditems())
        SelectElement(ribbons()\rightheaditems(),position)
        *ziel=InsertElement(ribbons()\rightheaditems())
        SwapElements(ribbons()\rightheaditems(),*quell,*ziel)
        ChangeCurrentElement(ribbons()\rightheaditems(),*ziel)
        DeleteElement(ribbons()\rightheaditems())
      Default;Case 0
        ProcedureReturn -1
    EndSelect
    Render(ribbons()\handle)
    ProcedureReturn oldpos
  EndProcedure
  Procedure GetItemPosition(id)
    Select SetPointerToItem(id)
      Case 1
        ProcedureReturn ListIndex(ribbons()\Categories())
      Case 2
        ProcedureReturn ListIndex(ribbons()\Categories()\Groups())
      Case 3
        ProcedureReturn ListIndex(ribbons()\Categories()\Groups()\items())
      Case 4
        ProcedureReturn ListIndex(ribbons()\Categories()\Groups()\items()\SubItems())
      Case 5
        ProcedureReturn ListIndex(ribbons()\headitems())
      Case 6
        ProcedureReturn ListIndex(ribbons()\rightheaditems())
      Default
        ProcedureReturn -1
    EndSelect
  EndProcedure
  Procedure SetSystemImage(handle,type,ihandle)
    Protected old,temp,dimensions.bitmap
    ForEach ribbons()
      If ribbons()\handle=handle
        If Not ribbons()\Flags&#Ribbon_Flag_UseOriginalImagesForCheckboxes
          CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL
            GetObject_(ihandle,SizeOf(dimensions),dimensions)
            temp=CreateImage(#PB_Any,dimensions\bmWidth,dimensions\bmHeight)
            StartDrawing(ImageOutput(temp))
            DrawImage(ihandle,0,0)
            StopDrawing()
          CompilerElse
            If IsImage(ihandle)
              temp=CopyImage(ihandle,#PB_Any)
            Else
              ProcedureReturn -2
            EndIf
          CompilerEndIf
          ihandle=temp
        EndIf
        Select type
          Case #Ribbon_SystemIcon_Checked
            old=1
            ribbons()\Icons("Checked48")=ihandle
            ribbons()\Icons("Checked16")=ihandle
          Case #Ribbon_SystemIcon_Unchecked
            old=1
            ribbons()\Icons("Unchecked48")=ihandle
            ribbons()\Icons("Unchecked16")=ihandle
          Case #Ribbon_SystemIcon_Inbetween
            old=1
            ribbons()\Icons("Inbetween48")=ihandle
            ribbons()\Icons("Inbetween16")=ihandle
          Case #Ribbon_SystemIcon_Checked48
            old=ribbons()\Icons("Checked48")
            ribbons()\Icons("Checked48")=ihandle
          Case #Ribbon_SystemIcon_Unchecked48
            old=ribbons()\Icons("Unchecked48")
            ribbons()\Icons("Unchecked48")=ihandle
          Case #Ribbon_SystemIcon_Inbetween48
            old=ribbons()\Icons("Inbetween48")
            ribbons()\Icons("Inbetween48")=ihandle
          Case #Ribbon_SystemIcon_Checked16
            old=ribbons()\Icons("Checked16")
            ribbons()\Icons("Checked16")=ihandle
          Case #Ribbon_SystemIcon_Unchecked16
            old=ribbons()\Icons("Unchecked16")
            ribbons()\Icons("Unchecked16")=ihandle
          Case #Ribbon_SystemIcon_Inbetween16
            old=ribbons()\Icons("Inbetween16")
            ribbons()\Icons("Inbetween16")=ihandle
          Case #Ribbon_SystemIcon_RadioButtonChecked16
            old=ribbons()\Icons("RadioChecked16")
            ribbons()\Icons("RadioChecked16")=ihandle
          Case #Ribbon_SystemIcon_RadioButtonUnchecked16
            old=ribbons()\Icons("RadioUnchecked16")
            ribbons()\Icons("RadioUnchecked16")=ihandle
          Default
            ProcedureReturn -1
        EndSelect
        Render(ribbons()\handle,#Ribbon_Render_Force)
        Break
      EndIf
    Next
    ProcedureReturn old
  EndProcedure
  Procedure ResizeHandler()
    ForEach ribbons()
      If ribbons()\window=EventWindow()
        Render(ribbons()\handle,#Ribbon_Render_Force)
        Break  
      EndIf
    Next
  EndProcedure
  Macro AddIcon_Color()
    AddIcon("Checked16",       ?checked)
    AddIcon("Unchecked16",     ?unchecked)
    AddIcon("Inbetween16",     ?inbetween)
    AddIcon("Checked48",       ?checked)
    AddIcon("Unchecked48",     ?unchecked)
    AddIcon("Inbetween48",     ?inbetween)
    AddIcon("RadioChecked16",  ?radiochecked)
    AddIcon("RadioUnchecked16",?radiounchecked)
  EndMacro
  Macro AddIcon_Color_W()
    AddIcon("Checked16",       ?checked_W)
    AddIcon("Unchecked16",     ?unchecked_W)
    AddIcon("Inbetween16",     ?inbetween_W)
    AddIcon("Checked48",       ?checked_W)
    AddIcon("Unchecked48",     ?unchecked_W)
    AddIcon("Inbetween48",     ?inbetween_W)
    AddIcon("RadioChecked16",  ?radiochecked_W)
    AddIcon("RadioUnchecked16",?radiounchecked_W)
  EndMacro
  Procedure SetMetric(handle,metric,value)
    Protected retval=-2
    ForEach ribbons()
      If ribbons()\handle=handle
        Select metric
          Case #Ribbon_Metric_Disabled
            retval=ribbons()\Disabled
            ribbons()\disabled=value
          Case #Ribbon_Metric_BackColor
            retval=ribbons()\backcolor
            If value=#Ribbon_Color_Auto
              CompilerSelect #PB_Compiler_OS
                CompilerCase #PB_OS_Windows
                  ribbons()\backcolor=GetSysColor_(#COLOR_BTNFACE)
                CompilerCase #PB_OS_MacOS
                  ribbons()\backcolor=GetCocoaColor("controlBackgroundColor")
                CompilerDefault    
                  ribbons()\backcolor=16767679
              CompilerEndSelect
            Else
              ribbons()\backcolor=value
            EndIf
            ForEach ribbons()\OriginalIcons()
              FreeImage(ribbons()\OriginalIcons());If IsImage(ribbons()\OriginalIcons()):FreeImage(ribbons()\OriginalIcons()):EndIf
            Next
            ClearList(ribbons()\OriginalIcons())
            ForEach ribbons()\Icons()
              FreeImage(ribbons()\Icons());If IsImage(ribbons()\Icons()):FreeImage(ribbons()\Icons()):EndIf
            Next
            ClearMap(ribbons()\Icons())
            Select ribbons()\Style
              Case #Ribbon_Style_Black
                ribbons()\accentcolor=0
                AddIcon_Color()
              Case #Ribbon_Style_White
                ribbons()\accentcolor=#White
                AddIcon_Color_W()
              Case #Ribbon_Style_Auto
                If Red(ribbons()\color)+Blue(ribbons()\color)+Green(ribbons()\color)>=384
                  ribbons()\accentcolor=0
                  AddIcon_Color()
                Else
                  ribbons()\accentcolor=#White
                  AddIcon_Color_W()
                EndIf
            EndSelect
            FreeImage(ribbons()\RibbonImage)
            ;FreeImage(ribbons()\InternalRenderer)
            FreeImage(ribbons()\MoveLeftImage)
            FreeImage(ribbons()\MoveRightImage)
            Render(ribbons()\handle,#Ribbon_Render_Force)
          Case #Ribbon_Metric_Color
            retval=ribbons()\color
            If value=#Ribbon_Color_Auto
              CompilerSelect #PB_Compiler_OS
                CompilerCase #PB_OS_Windows
                  ribbons()\color=GetSysColor_(#COLOR_BTNFACE)
                CompilerCase #PB_OS_MacOS
                  ribbons()\color=GetCocoaColor("controlBackgroundColor")
                CompilerDefault    
                  ribbons()\color=16767679
              CompilerEndSelect
            Else
              ribbons()\color=value
            EndIf
            ForEach ribbons()\OriginalIcons()
              FreeImage(ribbons()\OriginalIcons());If IsImage(ribbons()\OriginalIcons()):FreeImage(ribbons()\OriginalIcons()):EndIf
            Next
            ForEach ribbons()\Icons()
              FreeImage(ribbons()\Icons());If IsImage(ribbons()\Icons()):FreeImage(ribbons()\Icons()):EndIf
            Next
            Select ribbons()\Style
              Case #Ribbon_Style_Black
                ribbons()\accentcolor=0
                AddIcon_Color()
              Case #Ribbon_Style_White
                ribbons()\accentcolor=#White
                AddIcon_Color_W()
              Case #Ribbon_Style_Auto
                If Red(ribbons()\color)+Blue(ribbons()\color)+Green(ribbons()\color)>=384
                  ribbons()\accentcolor=0
                  AddIcon_Color()
                Else
                  ribbons()\accentcolor=#White
                  AddIcon_Color_W()
                EndIf
            EndSelect
            FreeImage(ribbons()\RibbonImage)
            ;FreeImage(ribbons()\InternalRenderer)
            FreeImage(ribbons()\MoveLeftImage)
            FreeImage(ribbons()\MoveRightImage)
            Render(ribbons()\handle,#Ribbon_Render_Force)
          Case #Ribbon_Metric_FullColor
            retval=ribbons()\color
            If value=#Ribbon_Color_Auto
              CompilerSelect #PB_Compiler_OS
                CompilerCase #PB_OS_Windows
                  ribbons()\color=GetSysColor_(#COLOR_BTNFACE)
                  ribbons()\backcolor=ribbons()\color
                CompilerCase #PB_OS_MacOS
                  ribbons()\color=GetCocoaColor("controlBackgroundColor")
                  ribbons()\backcolor=ribbons()\color
                CompilerDefault    
                  ribbons()\color=16767679
                  ribbons()\backcolor=16767679
              CompilerEndSelect
            Else
              ribbons()\color=value
              ribbons()\backcolor=value
            EndIf
            ForEach ribbons()\OriginalIcons()
              FreeImage(ribbons()\OriginalIcons());If IsImage(ribbons()\OriginalIcons()):FreeImage(ribbons()\OriginalIcons()):EndIf
            Next
            ClearList(Ribbons()\OriginalIcons())
            ForEach ribbons()\Icons()
              FreeImage(ribbons()\Icons());If IsImage(ribbons()\Icons()):FreeImage(ribbons()\Icons()):EndIf
            Next
            Select ribbons()\Style
              Case #Ribbon_Style_Black
                ribbons()\accentcolor=0
                AddIcon_Color()
              Case #Ribbon_Style_White
                ribbons()\accentcolor=#White
                AddIcon_Color_W()
              Case #Ribbon_Style_Auto
                If Red(ribbons()\color)+Blue(ribbons()\color)+Green(ribbons()\color)>=384
                  ribbons()\accentcolor=0
                  AddIcon_Color()
                Else
                  ribbons()\accentcolor=#White
                  AddIcon_Color_W()
                EndIf
            EndSelect
            FreeImage(ribbons()\RibbonImage)
            ;FreeImage(ribbons()\InternalRenderer)
            FreeImage(ribbons()\MoveLeftImage)
            FreeImage(ribbons()\MoveRightImage)
            Render(ribbons()\handle,#Ribbon_Render_Force)
          Case #Ribbon_Metric_Style
            retval=ribbons()\style
            ribbons()\style=value
            ForEach ribbons()\OriginalIcons()
              FreeImage(ribbons()\OriginalIcons());If IsImage(ribbons()\OriginalIcons()):FreeImage(ribbons()\OriginalIcons()):EndIf
            Next
            ForEach ribbons()\Icons()
              FreeImage(ribbons()\Icons());If IsImage(ribbons()\Icons()):FreeImage(ribbons()\Icons()):EndIf
            Next
            Select value
              Case #Ribbon_Style_Black
                ribbons()\accentcolor=0
                AddIcon_Color()
              Case #Ribbon_Style_White
                ribbons()\accentcolor=#White
                AddIcon_Color_W()
              Case #Ribbon_Style_Auto
                If Red(ribbons()\color)+Blue(ribbons()\color)+Green(ribbons()\color)>=384
                  ribbons()\accentcolor=0
                  AddIcon_Color()
                Else
                  ribbons()\accentcolor=#White
                  AddIcon_Color_W()
                EndIf
            EndSelect
            FreeImage(ribbons()\RibbonImage)
            ;FreeImage(ribbons()\InternalRenderer)
            FreeImage(ribbons()\MoveLeftImage)
            FreeImage(ribbons()\MoveRightImage)
            Render(ribbons()\handle,#Ribbon_Render_Force)
          Case #Ribbon_Metric_Collapsed
            retval=ribbons()\collapsed
            ribbons()\collapsed=value
            Render(ribbons()\handle,#Ribbon_Render_Force)
          Case #Ribbon_Metric_Roundness
            If value>=0 And value<=12
              retval=ribbons()\roundness
              ribbons()\roundness=value
              Render(ribbons()\handle,#Ribbon_Render_Force)
            Else
              retval=-1
            EndIf
          Case #Ribbon_Metric_ScrollPitch
            retval=ribbons()\ScrollPitch
            ribbons()\ScrollPitch=value
          Case #Ribbon_Metric_UpdateMode
            retval=ribbons()\noupdate
            ribbons()\noupdate=value
            CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL 
              If value=1
                PauseThread(ribbons()\thread)
              Else
                ResumeThread(ribbons()\thread)
              EndIf
            CompilerEndIf
            ;Render(ribbons()\handle,#Ribbon_Render_Force)
          Case #Ribbon_Metric_AccentStrength
            retval=ribbons()\AccentStrength
            ribbons()\AccentStrength=value
            Render(ribbons()\handle,#Ribbon_Render_Force)
          Case #Ribbon_Metric_ToolTipDelay
            retval=ribbons()\ToolTipDelay*100
            ribbons()\ToolTipDelay=value/100
          Case #Ribbon_Metric_ToolTipStyle
            retval=ribbons()\ToolTipStyle
            ribbons()\ToolTipStyle=value
          Case #Ribbon_Metric_ScrollWheel
            retval=ribbons()\WheelMode
            ribbons()\WheelMode=value
          Default
            retval=-1
        EndSelect
        ProcedureReturn retval
      EndIf
    Next
    ProcedureReturn -2
  EndProcedure
  Procedure GetMetric(handle,metric)
    ForEach ribbons()
      If ribbons()\handle=handle
        Select metric
          Case #Ribbon_Metric_Disabled
            ProcedureReturn ribbons()\disabled
          Case #Ribbon_Metric_Collapsed
            ProcedureReturn ribbons()\collapsed
          Case #Ribbon_Metric_Roundness
            ProcedureReturn ribbons()\roundness
          Case #Ribbon_Metric_UpdateMode
            ProcedureReturn ribbons()\noupdate
          Case #Ribbon_Metric_Color
            ProcedureReturn ribbons()\color
          Case #Ribbon_Metric_Style
            ProcedureReturn ribbons()\Style
          Case #Ribbon_Metric_ScrollPitch
            ProcedureReturn ribbons()\ScrollPitch
          Case #Ribbon_Metric_AccentStrength
            ProcedureReturn ribbons()\AccentStrength
          Case #Ribbon_Metric_ToolTipDelay
            ProcedureReturn ribbons()\ToolTipDelay*100
          Case #Ribbon_Metric_ToolTipStyle
            ProcedureReturn ribbons()\ToolTipStyle
          Case #Ribbon_Metric_ScrollWheel
            ProcedureReturn ribbons()\WheelMode
          Default
            ProcedureReturn -2
        EndSelect
      EndIf
    Next
    ProcedureReturn -2
  EndProcedure
  CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL 
    Procedure SetCallbackMessage(message)
      Protected oldm
      oldm=CallBackMessage
      If CallBackMessage>0
        callbackmessage=message
      EndIf
      ProcedureReturn oldm
    EndProcedure
    Procedure RenderRibbonAsync(handle)
      Render(handle,0)
    EndProcedure
    Procedure RibbonThread(*infos)
      Protected rect.Rect,*oldelement,thread
      Repeat
        Delay(10)
        *oldelement=@ribbons()
        ChangeCurrentElement(ribbons(),*infos)
        If 0;ribbons()\thread=0
          ribbons()\thread=1
          Break
        EndIf
        GetClientRect_(ribbons()\window,rect)
        If ribbons()\x<>rect\right And Not IsThread(thread)
          thread=CreateThread(@RenderRibbonAsync(),ribbons()\handle)
        EndIf
        ChangeCurrentElement(ribbons(),*oldelement)
      ForEver
    EndProcedure
    Procedure RibbonResponder(*resp)
      Protected ls
      If *resp<0
        ProcedureReturn -1  
      Else
        ls=ListSize(RibbonResponse())
        If *resp>0 And ls>0
          SelectElement(ribbonresponse(),0)
          PokeL(*resp,ribbonresponse()\event)
          PokeL(*resp+4,RibbonResponse()\id)
          DeleteElement(ribbonresponse())
        EndIf
      EndIf
      ProcedureReturn ls
    EndProcedure
    Procedure CheckRibbonActivityDLL()
      Protected mw,ai
      ribbonid=0
      ribbonevent=#Ribbon_Event_None
      If Event()=#PB_Event_Gadget
        ForEach ribbons()
          If EventGadget()=ribbons()\handle And ribbons()\disabled=0
            Select EventType()
              Case #PB_EventType_LeftClick
                LockMutex(ttmutex)
                ttreset=1
                UnlockMutex(ttmutex)
                ribbonevent=#Ribbon_Event_LeftClick
                RenderElements()
              Case #PB_EventType_RightClick
                LockMutex(ttmutex)
                ttreset=1
                UnlockMutex(ttmutex)
                ribbonevent=#Ribbon_Event_RightClick
                RenderElements()
              Case #PB_EventType_LeftDoubleClick
                LockMutex(ttmutex)
                ttreset=1
                UnlockMutex(ttmutex)
                ribbonevent=#Ribbon_Event_LeftDoubleClick
                RenderElements()
              Case #PB_EventType_RightDoubleClick
                LockMutex(ttmutex)
                ttreset=1
                UnlockMutex(ttmutex)
                ribbonevent=#Ribbon_Event_RightDoubleClick
                RenderElements()
              Case #PB_EventType_MouseMove,#PB_EventType_MouseEnter
                LockMutex(ttmutex)
                ttreset=1
                UnlockMutex(ttmutex)
                RenderElements()
                If ribbons()\flags&#Ribbon_Flag_HoverEvents:ribbonevent=#Ribbon_Event_Hover:EndIf
                If ribbonid=ribbons()\hover\oldid
                  ribbonid=0
                EndIf
              Case #PB_EventType_MouseLeave,#PB_EventType_LostFocus
                LockMutex(ttmutex)
                ttreset=1
                UnlockMutex(ttmutex)
                RenderElements(#True)
              Case #PB_EventType_MouseWheel
                mw=-(EventwParam()>>16)/#WHEEL_DELTA
                If mw<>0
                  ai=ribbons()\Category
                  ForEach ribbons()\Categories()
                    If ribbons()\Categories()\id=ribbons()\Category
                      Select ribbons()\WheelMode
                        Case #Ribbon_ScrollWheel_Category
                          If mw>0;scroll down
                            While NextElement(ribbons()\Categories())
                              If Not (ribbons()\Categories()\status&#Ribbon_Status_Deactivated Or ribbons()\Categories()\status&#Ribbon_Status_Hidden)
                                SetActiveCategory(ribbons()\Categories()\id)
                                PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbonid,#PB_EventType_MouseWheel,ribbons()\Category)
                                Break
                              EndIf
                            Wend
                          Else;scroll up
                            While PreviousElement(ribbons()\Categories())
                              If Not (ribbons()\Categories()\status&#Ribbon_Status_Deactivated Or ribbons()\Categories()\status&#Ribbon_Status_Hidden)
                                SetActiveCategory(ribbons()\Categories()\id)
                                PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbonid,#PB_EventType_MouseWheel,ribbons()\Category)
                                Break
                              EndIf
                            Wend
                          EndIf
                        Case #Ribbon_ScrollWheel_LeftRight
                          If mw<0 And ribbons()\Categories()\LeftButtonActive;scroll left
                            Render(ribbons()\handle,#False)
                          ElseIf mw>0 And ribbons()\Categories()\RightButtonActive;scroll right
                            Render(ribbons()\handle,#False)
                          EndIf
                        Case #Ribbon_ScrollWheel_Auto
                          If mw<0;scroll left
                            If ribbons()\Categories()\LeftButtonActive
                              Render(ribbons()\handle,#False)
                            Else
                              While PreviousElement(ribbons()\Categories())
                                If Not (ribbons()\Categories()\status&#Ribbon_Status_Deactivated Or ribbons()\Categories()\status&#Ribbon_Status_Hidden)
                                  SetActiveCategory(ribbons()\Categories()\id)
                                  PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbonid,#PB_EventType_MouseWheel,ribbons()\Category)
                                  Break
                                EndIf
                              Wend
                            EndIf
                          Else;scroll right
                            If ribbons()\Categories()\RightButtonActive
                              Render(ribbons()\handle,#False)
                            Else
                              While NextElement(ribbons()\Categories())
                                If Not (ribbons()\Categories()\status&#Ribbon_Status_Deactivated Or ribbons()\Categories()\status&#Ribbon_Status_Hidden)
                                  SetActiveCategory(ribbons()\Categories()\id)
                                  PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbonid,#PB_EventType_MouseWheel,ribbons()\Category)
                                  Break
                                EndIf
                              Wend
                            EndIf
                          EndIf
                      EndSelect
                    EndIf
                  Next
                EndIf
            EndSelect
            Break  
          EndIf  
        Next
        If ribbonid<>0
          If GetItemStatus(ribbonid)&#Ribbon_Status_Deactivated = #Ribbon_Status_Deactivated
            ribbonid=0
            ribbonevent=#Ribbon_Event_None
          EndIf
        Else
          ribbonevent=#Ribbon_Event_None
        EndIf
        If ribbonevent<>#Ribbon_Event_None And ribbonid<>0 And ribbons()\disabled=0
          AddElement(RibbonResponse())
          RibbonResponse()\Ribbon=ribbons()\handle
          ribbonresponse()\event=ribbonevent
          ribbonresponse()\id=ribbonid
          RibbonResponse()\ControlX=ribbons()\hover\x
          RibbonResponse()\ControlY=ribbons()\hover\y
          RibbonResponse()\ControlDX=ribbons()\hover\dx
          RibbonResponse()\ControlDY=ribbons()\hover\dy
          SendMessage_(ribbons()\window,CallBackMessage,0,0)
          ProcedureReturn ListSize(RibbonResponse())
        EndIf
      EndIf
      ProcedureReturn 0
    EndProcedure
    Procedure GetRibbonHandle(id)
      Protected handle
      ForEach ribbons()
        If ribbons()\handle=handle
          handle=GadgetID(ribbons()\handle)
          Break  
        EndIf
      Next
      ProcedureReturn handle
    EndProcedure
    Procedure FlushRibbonActivity()
      ClearList(RibbonResponse())
    EndProcedure
  CompilerElse
    Procedure EventHandler()
      Protected mw,ai
      ribbonid=0
      ribbonevent=#Ribbon_Event_None
      LockMutex(rMutex)
      ForEach ribbons()
        If EventGadget()=ribbons()\handle And ribbons()\disabled=0
          Select EventType()
            Case #PB_EventType_LeftClick;,#PB_EventType_LeftDoubleClick,#PB_EventType_RightDoubleClick
              LockMutex(ttmutex)
              ttreset=1
              UnlockMutex(ttmutex)
              ribbonevent=#Ribbon_Event_LeftClick
              RenderElements()
              If ribbonid<>0 And GetItemStatus(ribbonid)&#Ribbon_Status_Deactivated=0
                PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbonid,EventType(),ribbonid)
              EndIf
            Case #PB_EventType_RightClick
              LockMutex(ttmutex)
              ttreset=1
              UnlockMutex(ttmutex)
              ribbonevent=#Ribbon_Event_RightClick
              RenderElements()
              If ribbonid<>0 And GetItemStatus(ribbonid)&#Ribbon_Status_Deactivated=0
                PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbonid,EventType(),ribbonid)
              EndIf
            Case #PB_EventType_MouseMove,#PB_EventType_MouseEnter
              LockMutex(ttmutex)
              ttreset=1
              UnlockMutex(ttmutex)
              RenderElements()
              If ribbons()\flags&#Ribbon_Flag_HoverEvents
                If ribbonid=0 And ribbons()\hover\oldid<>0
                  PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbons()\hover\oldid,#PB_EventType_MouseLeave,ribbonid)
                ElseIf ribbonid=ribbons()\hover\oldid
                  ribbonid=0
                Else
                  If ribbons()\hover\oldid<>0
                    PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbons()\hover\oldid,#PB_EventType_MouseLeave,ribbonid)
                  EndIf
                  PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbonid,#PB_EventType_MouseEnter,ribbonid)
                EndIf
              EndIf
            Case #PB_EventType_MouseLeave,#PB_EventType_LostFocus
              LockMutex(ttmutex)
              ttreset=1
              UnlockMutex(ttmutex)
              RenderElements(1)
              If ribbons()\flags&#Ribbon_Flag_HoverEvents And ribbonid<>0
                PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbonid,#PB_EventType_MouseLeave,ribbonid)
              EndIf
            Case #PB_EventType_MouseWheel
              mw=-(EventwParam()>>16)/#WHEEL_DELTA
              If mw<>0
                If mw>0
                  ribbonevent=#Ribbon_Event_ScrollDown
                Else
                  ribbonevent=#Ribbon_Event_ScrollUp
                EndIf
                ai=ribbons()\Category
                ForEach ribbons()\Categories()
                  If ribbons()\Categories()\id=ribbons()\Category
                    Select ribbons()\WheelMode
                      Case #Ribbon_ScrollWheel_Category
                        If mw>0;scroll down
                          While NextElement(ribbons()\Categories())
                            If Not (ribbons()\Categories()\status&#Ribbon_Status_Deactivated Or ribbons()\Categories()\status&#Ribbon_Status_Hidden)
                              SetActiveCategory(ribbons()\Categories()\id)
                              PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbonid,#PB_EventType_MouseWheel,ribbons()\Category)
                              Break
                            EndIf
                          Wend
                        Else;scroll up
                          While PreviousElement(ribbons()\Categories())
                            If Not (ribbons()\Categories()\status&#Ribbon_Status_Deactivated Or ribbons()\Categories()\status&#Ribbon_Status_Hidden)
                              SetActiveCategory(ribbons()\Categories()\id)
                              PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbonid,#PB_EventType_MouseWheel,ribbons()\Category)
                              Break
                            EndIf
                          Wend
                        EndIf
                      Case #Ribbon_ScrollWheel_LeftRight
                        If mw<0 And ribbons()\Categories()\LeftButtonActive;scroll left
                          Render(ribbons()\handle,#False)
                        ElseIf mw>0 And ribbons()\Categories()\RightButtonActive;scroll right
                          Render(ribbons()\handle,#False)
                        EndIf
                      Case #Ribbon_ScrollWheel_Auto
                        If mw<0;scroll left
                          If ribbons()\Categories()\LeftButtonActive
                            Render(ribbons()\handle,#False)
                          Else
                            While PreviousElement(ribbons()\Categories())
                              If Not (ribbons()\Categories()\status&#Ribbon_Status_Deactivated Or ribbons()\Categories()\status&#Ribbon_Status_Hidden)
                                SetActiveCategory(ribbons()\Categories()\id)
                                PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbonid,#PB_EventType_MouseWheel,ribbons()\Category)
                                Break
                              EndIf
                            Wend
                          EndIf
                        Else;scroll right
                          If ribbons()\Categories()\RightButtonActive
                            Render(ribbons()\handle,#False)
                          Else
                            While NextElement(ribbons()\Categories())
                              If Not (ribbons()\Categories()\status&#Ribbon_Status_Deactivated Or ribbons()\Categories()\status&#Ribbon_Status_Hidden)
                                SetActiveCategory(ribbons()\Categories()\id)
                                PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbonid,#PB_EventType_MouseWheel,ribbons()\Category)
                                Break
                              EndIf
                            Wend
                          EndIf
                        EndIf
                    EndSelect
                  EndIf
                Next
              EndIf
              If ribbonid<>0
                PostEvent(#PB_Event_Ribbon,ribbons()\window,ribbonid,#PB_EventType_MouseWheel,ribbonid)
              EndIf
          EndSelect
          Break  
        EndIf  
      Next
      UnlockMutex(rMutex)
      If ribbonid<>0 And GetItemStatus(ribbonid)&#Ribbon_Status_Deactivated
        ribbonid=0
        ribbonevent=#Ribbon_Event_None
      EndIf
    EndProcedure
  CompilerEndIf
  Procedure Create(parentwindow,id,color=#Ribbon_Color_Auto,backcolor=#Ribbon_Color_Auto,style=#Ribbon_Style_Auto,flags=0)
    Protected rx,ry,ogl
    ForEach ribbons()
      If ribbons()\window=parentwindow
        ProcedureReturn -1  
      EndIf
    Next
    
    CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL 
      Protected rect.Rect
      GetClientRect_(parentwindow,rect)
      rx=rect\right
      ogl=UseGadgetList(parentwindow)
    CompilerElse
      rx=WindowWidth(parentwindow,#PB_Window_InnerCoordinate)
      ogl=UseGadgetList(WindowID(parentwindow))
    CompilerEndIf
    
    If flags&#Ribbon_Flag_NoHeader
      ry=106
    Else
      ry=128
    EndIf
    If id=#PB_Any
      id=CanvasGadget(#PB_Any,0,0,rx,ry)
    Else
      CanvasGadget(id,0,0,rx,ry)
    EndIf
    AddElement(Ribbons())
    ribbons()\handle=id
    ribbons()\flags=flags
    ribbons()\window=parentwindow
    ribbons()\font=LoadFont(#PB_Any,"Verdana",10,#PB_Font_HighQuality)
    ribbons()\smallfont=LoadFont(#PB_Any,"Verdana",8,#PB_Font_HighQuality)
    ribbons()\extrafont=LoadFont(#PB_Any,"Webdings",14,#PB_Font_HighQuality)
    ribbons()\ScrollPitch=#Ribbon_Metric_Standard_ScrollPitch
    ribbons()\AccentStrength=#Ribbon_Metric_Standard_AccentStrength
    ribbons()\ToolTipDelay=10
    ribbons()\ToolTipStyle=#Ribbon_ToolTipStyle_Box
    AddMouseWheelHook(@Ribbons())
    If color=#Ribbon_Color_Auto
      CompilerSelect #PB_Compiler_OS
        CompilerCase #PB_OS_Windows
          ribbons()\color=GetSysColor_(#COLOR_BTNFACE)
        CompilerCase #PB_OS_MacOS
          ribbons()\color=GetCocoaColor("controlBackgroundColor")
        CompilerDefault    
          ribbons()\color=16767679
      CompilerEndSelect
    Else
      ribbons()\color=color
    EndIf
    If backcolor=#Ribbon_Color_Auto
      CompilerSelect #PB_Compiler_OS
        CompilerCase #PB_OS_Windows
          ribbons()\backcolor=GetSysColor_(#COLOR_BTNFACE)
        CompilerCase #PB_OS_MacOS
          ribbons()\backcolor=GetCocoaColor("controlBackgroundColor")
        CompilerDefault    
          ribbons()\backcolor=16767679
      CompilerEndSelect
    Else
      ribbons()\backcolor=backcolor
    EndIf
    ribbons()\offset=12
    ribbons()\x=rx
    ribbons()\y=128;ry
    ribbons()\roundness=#Ribbon_Metric_Standard_Roudnness
    ribbons()\padding=3
    ribbons()\noupdate=1
    Select style
      Case #Ribbon_Style_Black
        ribbons()\accentcolor=0
        AddIcon_Color()
      Case #Ribbon_Style_White
        ribbons()\accentcolor=#White
        AddIcon_Color_W()
      Case #Ribbon_Style_Auto
        If Red(color)+Blue(color)+Green(color)>=384
          ribbons()\accentcolor=0
          AddIcon_Color()
        Else
          ribbons()\accentcolor=#White
          AddIcon_Color_W()
        EndIf
    EndSelect
    ribbons()\style=style
    ribbons()\hover\id=-1
    UseGadgetList(ogl)
    CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL 
      If CallBackMessage<1
        CallBackMessage=10000  
      EndIf
      BindGadgetEvent(id,@CheckRibbonActivityDLL())
      If flags&#Ribbon_Flag_AutoSize<>0
        ribbons()\Thread=CreateThread(@RibbonThread(),@ribbons())
      EndIf
    CompilerElse
      BindEvent(#PB_Event_SizeWindow,@ResizeHandler(),ribbons()\window)
      BindGadgetEvent(ribbons()\handle,@EventHandler(),#PB_All)
    CompilerEndIf
    ExtendedLogging(ribbons()\handle,#True)
    CompilerIf #PB_Compiler_Debugger
      ;StatisticWindow(ribbons()\handle)
    CompilerEndIf
    ProcedureReturn id
  EndProcedure
  Procedure Remove(handle)
    Protected old=-1
    ForEach ribbons()
      If ribbons()\handle=handle
        old=ribbons()\handle
        CompilerIf #PB_Compiler_ExecutableFormat=#PB_Compiler_DLL 
          UnbindGadgetEvent(ribbons()\handle,@CheckRibbonActivityDLL())
          ForEach ribbons()\Popup()
            UnbindEvent(#PB_Event_DeactivateWindow,@FreeWindow(),ribbons()\Popup()\window)
          Next
          If IsThread(ribbons()\thread)
            KillThread(ribbons()\thread)
            ;           ribbons()\thread=0
            ;           Repeat
            ;             Delay(10)
            ;           Until ribbons()\thread=1
          EndIf
        CompilerElse
          ;         UnbindGadgetEvent(ribbons()\handle,@ResizeHandler(),#PB_EventType_Resize)
          UnbindEvent(#PB_Event_SizeWindow,@ResizeHandler(),ribbons()\window)
          UnbindGadgetEvent(ribbons()\handle,@EventHandler(),#PB_All)
        CompilerEndIf
        ;Nötig?
        InternalRemover(0)
        CompilerIf #PB_Compiler_ExecutableFormat<>#PB_Compiler_DLL 
          While ListSize(ribbons()\headitems())>0
            FirstElement(ribbons()\headitems())
            FreeImage(ribbons()\headitems()\image);If IsImage(ribbons()\headitems()\image):FreeImage(ribbons()\headitems()\image):EndIf
            DeleteElement(ribbons()\headitems())
          Wend
          While ListSize(ribbons()\rightheaditems())>0
            FirstElement(ribbons()\rightheaditems())
            FreeImage(ribbons()\rightheaditems()\image);If IsImage(ribbons()\rightheaditems()\image):FreeImage(ribbons()\rightheaditems()\image):EndIf
            DeleteElement(ribbons()\rightheaditems())
          Wend
        CompilerEndIf
        ;Nötig? Ende
        ForEach ribbons()\Icons()
          FreeImage(ribbons()\Icons());If IsImage(ribbons()\Icons()):FreeImage(ribbons()\Icons()):EndIf
        Next
        ForEach ribbons()\OriginalIcons()
          FreeImage(ribbons()\OriginalIcons());If IsImage(ribbons()\OriginalIcons()):FreeImage(ribbons()\OriginalIcons()):EndIf
        Next
        FreeImage(ribbons()\InternalRenderer);If IsImage(ribbons()\InternalRenderer):FreeImage(ribbons()\InternalRenderer):EndIf
        FreeImage(ribbons()\RibbonImage)     ;If IsImage(ribbons()\RibbonImage):FreeImage(ribbons()\RibbonImage):EndIf
        FreeImage(ribbons()\MoveLeftImage)   ;If IsImage(ribbons()\MoveLeftImage):FreeImage(ribbons()\MoveLeftImage):EndIf
        FreeImage(ribbons()\MoveRightImage)  ;If IsImage(ribbons()\MoveRightImage):FreeImage(ribbons()\MoveRightImage):EndIf
                                             ;       FreeFont(ribbons()\font)
                                             ;       FreeFont(ribbons()\smallfont)
                                             ;       FreeFont(ribbons()\extrafont)
        RemoveMouseWheelHook(@Ribbons())
        FreeGadget(ribbons()\handle)
        ;DeleteElement(ribbons())
        Break
      EndIf
    Next
    ProcedureReturn old
  EndProcedure
  Procedure GetActiveCategory(handle)
    ForEach ribbons()
      If ribbons()\handle=handle
        ProcedureReturn ribbons()\Category
      EndIf
    Next
  EndProcedure
  Procedure DeinitializeModule()
    ForEach ribbons()
      Remove(ribbons()\handle)
    Next
    FreeImage(#PB_All)
    FreeFont(#PB_All)
    FreeGadget(#PB_All)
  EndProcedure
  Procedure GetStatistic(ribbon,ribbon_stattype)
    Protected retval.q
    ForEach ribbons()
      If ribbons()\handle=ribbon
        Select ribbon_stattype
          Case #Ribbon_Statistic_RenderCount
            retval=ribbons()\RenderCount
          Case #Ribbon_Statistic_DrawCount
            retval=ribbons()\DrawCount
          Case #Ribbon_Statistic_RenderTime
            retval=ElapsedMilliseconds()
            Render(ribbons()\handle,1)
            retval=ElapsedMilliseconds()-retval
          Default
            retval=-1
        EndSelect
        Break
      EndIf
    Next
    ProcedureReturn retval
  EndProcedure
  CompilerIf #PB_Compiler_Debugger
    Global sfont=LoadFont(#PB_Any,"Verdana",10,#PB_Font_HighQuality),statfont=LoadFont(#PB_Any,"Courier New",8,#PB_Font_HighQuality)
    SetGadgetFont(#PB_Default,FontID(sfont))
    Global swindow,stab,sstatus,Dim merkmal.i(2),Dim soption.i(2),slastcount,soptionsel,*sribbonitem.RibbonList
    Procedure DrawDiagram(panel)
      Protected x=GadgetWidth(merkmal(panel)),y=GadgetHeight(merkmal(panel))
      
      StartDrawing(CanvasOutput(merkmal(panel)))
      Box(0,0,x,y,GetSysColor_(#COLOR_WINDOW))
      Line(0,y-12,x,1,0)
      
      Protected min.u=65535,max.u,count,cumval,midval,median.f,NewList times.u(),temp.f,temp2.f
      ForEach *sribbonitem\LogList()
        If soptionsel=0 Or (soptionsel=1 And *sribbonitem\LogList()\Type=1) Or (soptionsel=2 And *sribbonitem\LogList()\Type=0)
          If *sribbonitem\LogList()\RenderTime>max
            max=*sribbonitem\LogList()\RenderTime
          ElseIf *sribbonitem\LogList()\RenderTime<min
            min=*sribbonitem\LogList()\RenderTime
          EndIf
          cumval+*sribbonitem\LogList()\RenderTime
          count+1
          AddElement(times())
          times()=*sribbonitem\LogList()\RenderTime
        EndIf
      Next
      
      Select panel
        Case 1;Zeitleiste
          
          temp2=(y-max-22)/max
          ForEach times()
            temp=(ListIndex(times()))/(ListSize(times())-1)
            Circle(10+temp*(x-20),y-22-times()*temp2,1,0)
          Next
          
          SortList(times(),#PB_Sort_Ascending)
          If ListSize(times())>0
            If Mod(ListSize(times()),2)=0
              SelectElement(times(),ListSize(times())/2-1)
              median=times()
              NextElement(times())
              median=(median+times())/2
            Else
              SelectElement(times(),(ListSize(times())-1)/2)
              median=times()
            EndIf
          EndIf
          
        Case 2;Verteilung
          
          Protected NewMap valmap.l(),tval.s
          SortList(times(),#PB_Sort_Ascending)
          ForEach times()
            tval=Str(times())
            valmap(tval)=valmap(tval)+1
            If valmap(tval)>temp2
              temp2=valmap(tval)
            EndIf
          Next
          temp2=(y-temp2-22)/temp2
          ForEach valmap()
            temp=(Val(MapKey(valmap())))/max
            Circle(10+temp*(x-20),y-22-Valmap()*temp2,1,0)
          Next
          
      EndSelect
      
      DrawingFont(FontID(statfont))
      DrawingMode(#PB_2DDrawing_Transparent)
      DrawText(0,y-12,"Minimum: "+RSet(Str(min),3)+"ms, Maximum: "+RSet(Str(max),3)+"ms, Mittel: "+RSet(StrF(cumval/count,1),5)+"ms, Median: "+RSet(StrF(median,1),5)+"ms",0)
      StopDrawing()
      
    EndProcedure
    Procedure StatisticTimer()
      If IsWindow(swindow) And slastcount<>ListSize(*sribbonitem\LogList())
        If slastcount>0
          SelectElement(*sribbonitem\LogList(),slastcount-1)
        Else
          ResetList(*sribbonitem\LogList())
        EndIf
        SendMessage_(GadgetID(merkmal(0)),#WM_SETREDRAW,0,0)
        While NextElement(*sribbonitem\LogList())
          Select *sribbonitem\LogList()\Type
            Case 0
              If soptionsel=0 Or soptionsel=2
                AddGadgetItem(merkmal(0),-1,Str(ListIndex(*sribbonitem\LogList()))+#LF$+FormatDate("%dd.%mm.%yyyy, %hh:%ii:%ss",*sribbonitem\LogList()\Timestamp)+#LF$+"Draw"+#LF$+Str(*sribbonitem\LogList()\RenderTime)+"ms")
              EndIf  
            Case 1
              If soptionsel=0 Or soptionsel=1
                AddGadgetItem(merkmal(0),-1,Str(ListIndex(*sribbonitem\LogList()))+#LF$+FormatDate("%dd.%mm.%yyyy, %hh:%ii:%ss",*sribbonitem\LogList()\Timestamp)+#LF$+"Render"+#LF$+Str(*sribbonitem\LogList()\RenderTime)+"ms")
              EndIf
          EndSelect
        Wend
        SendMessage_(GadgetID(merkmal(0)),#WM_SETREDRAW,1,0)
        slastcount=ListSize(*sribbonitem\LogList())
        If *sribbonitem\LogList()=1
          StatusBarText(sstatus,1,"1 Eintrag")
        Else
          StatusBarText(sstatus,1,Str(ListSize(*sribbonitem\LogList()))+" Einträge")
        EndIf
        Select GetGadgetState(stab)
          Case 1
            DrawDiagram(1)
          Case 2
            DrawDiagram(2)
        EndSelect
      EndIf
    EndProcedure
    Procedure StatisticResizeEvent()
      Protected counter,px,py
      ResizeGadget(stab,#PB_Ignore,#PB_Ignore,WindowWidth(swindow,#PB_Window_InnerCoordinate)-20,WindowHeight(swindow,#PB_Window_InnerCoordinate)-StatusBarHeight(sstatus)-40)
      px=GetGadgetAttribute(stab,#PB_Panel_ItemWidth)
      py=GetGadgetAttribute(stab,#PB_Panel_ItemHeight)
      For counter=0 To 2
        ResizeGadget(merkmal(counter),#PB_Ignore,#PB_Ignore,px,py)
      Next
      Select GetGadgetState(stab)
        Case 1
          DrawDiagram(1)
        Case 2
          DrawDiagram(2)
      EndSelect
    EndProcedure
    Procedure StatisticGadgetEvent()
      Protected optionseltemp=soptionsel
      Select EventType()
        Case #PB_EventType_Change
          Select EventGadget()
            Case stab
              Select GetGadgetState(stab)
                Case 1
                  DrawDiagram(1)
                Case 2
                  DrawDiagram(2)
              EndSelect
          EndSelect
        Case #PB_EventType_LeftClick
          Select EventGadget()
            Case soption(0)
              If GetGadgetState(soption(0))
                optionseltemp=0
              EndIf
            Case soption(1)
              If GetGadgetState(soption(1))
                optionseltemp=1
              EndIf
            Case soption(2)
              If GetGadgetState(soption(2))
                optionseltemp=2
              EndIf
          EndSelect
      EndSelect
      If optionseltemp<>soptionsel
        soptionsel=optionseltemp
        SendMessage_(GadgetID(merkmal(0)),#WM_SETREDRAW,0,0)
        ClearGadgetItems(merkmal(0))
        ForEach *sribbonitem\LogList()
          Select *sribbonitem\LogList()\Type
            Case 0
              If soptionsel=0 Or soptionsel=2
                AddGadgetItem(merkmal(0),-1,Str(ListIndex(*sribbonitem\LogList()))+#LF$+FormatDate("%dd.%mm.%yyyy, %hh:%ii:%ss",*sribbonitem\LogList()\Timestamp)+#LF$+"Draw"+#LF$+Str(*sribbonitem\LogList()\RenderTime)+"ms")
              EndIf  
            Case 1
              If soptionsel=0 Or soptionsel=1
                AddGadgetItem(merkmal(0),-1,Str(ListIndex(*sribbonitem\LogList()))+#LF$+FormatDate("%dd.%mm.%yyyy, %hh:%ii:%ss",*sribbonitem\LogList()\Timestamp)+#LF$+"Render"+#LF$+Str(*sribbonitem\LogList()\RenderTime)+"ms")
              EndIf
          EndSelect
        Next
        SendMessage_(GadgetID(merkmal(0)),#WM_SETREDRAW,1,0)
      EndIf
    EndProcedure
    Procedure StatisticCloseEvent()
      RemoveWindowTimer(swindow,943)
      UnbindEvent(#PB_Event_Timer,@StatisticTimer(),swindow)
      UnbindEvent(#PB_Event_SizeWindow,@StatisticResizeEvent(),swindow)
      UnbindEvent(#PB_Event_CloseWindow,@StatisticCloseEvent(),swindow)
      UnbindEvent(#PB_Event_Gadget,@StatisticGadgetEvent(),swindow)
      slastcount=0
      CloseWindow(swindow)
    EndProcedure
    Procedure StatisticWindow(handle)
      Protected px,py,gali
      ForEach ribbons()
        If ribbons()\handle=handle
          *sribbonitem=@ribbons()
          If IsWindow(swindow)
            slastcount=0
          Else
            swindow=OpenWindow(#PB_Any,0,0,500,400,"Ribbon-Analyse",#PB_Window_ScreenCentered|#PB_Window_Tool|#PB_Window_TitleBar|#PB_Window_SystemMenu|#PB_Window_SizeGadget|#PB_Window_NoGadgets)
            StickyWindow(swindow,#True)
            SmartWindowRefresh(swindow,#True)
            WindowBounds(swindow,500,400,#PB_Ignore,#PB_Ignore)
            gali=UseGadgetList(WindowID(swindow))
            
            sstatus=CreateStatusBar(#PB_Any,WindowID(swindow))
            AddStatusBarField(#PB_Ignore)
            AddStatusBarField(100)
            soption(0)=OptionGadget(#PB_Any,10,5,100,20,"Alle Einträge")
            SetGadgetState(soption(0),1)
            soption(1)=OptionGadget(#PB_Any,120,5,100,20,"Render")
            soption(2)=OptionGadget(#PB_Any,230,5,100,20,"Draw")
            stab=PanelGadget(#PB_Any,10,30,WindowWidth(swindow,#PB_Window_InnerCoordinate)-20,WindowHeight(swindow,#PB_Window_InnerCoordinate)-StatusBarHeight(sstatus)-40)
            
            AddGadgetItem(stab,-1,"Rohdaten")
            px=GetGadgetAttribute(stab,#PB_Panel_ItemWidth)
            py=GetGadgetAttribute(stab,#PB_Panel_ItemHeight)
            merkmal(0)=ListIconGadget(#PB_Any,0,0,px,py,"ID",48,#PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_FullRowSelect|#PB_ListIcon_GridLines)
            AddGadgetColumn(merkmal(0),1,"Zeitstempel",128)
            AddGadgetColumn(merkmal(0),2,"Typ",56)
            AddGadgetColumn(merkmal(0),3,"Dauer",64)
            
            AddGadgetItem(stab,-1,"Zeitleiste")
            merkmal(1)=CanvasGadget(#PB_Any,0,0,px,py)
            
            AddGadgetItem(stab,-1,"Verteilung")
            merkmal(2)=CanvasGadget(#PB_Any,0,0,px,py)
            CloseGadgetList()
            UseGadgetList(gali)
            
            AddWindowTimer(swindow,943,1000)
            BindEvent(#PB_Event_Timer,@StatisticTimer(),swindow,943)
            BindEvent(#PB_Event_SizeWindow,@StatisticResizeEvent(),swindow)
            BindEvent(#PB_Event_CloseWindow,@StatisticCloseEvent(),swindow)
            BindEvent(#PB_Event_Gadget,@StatisticGadgetEvent(),swindow)
            
          EndIf
          Break
        EndIf
      Next
    EndProcedure
  CompilerElse
    Procedure ErrorHandler()
      Protected error.s
      error="Ein Fehler ist aufgetreten:"+#CRLF$
      error+"Meldung: "+ErrorMessage()+#CRLF$
      error+"Code: "+Str(ErrorCode())+#CRLF$+#CRLF$
      error+"Datei: "+ErrorFile()+#CRLF$
      error+"Zeile: "+Str(ErrorLine())
      MessageRequester("Ribbon-Gadget Fehler",error,#PB_MessageRequester_Error)
    EndProcedure
    OnErrorCall(@ErrorHandler())
  CompilerEndIf
  DataSection
    checked:          : Data.l 9662,1621:Data.q $00000000626C7A31,$00000000000025BE,$0000000000100000,$0001000100010000,$0025A80020073030,$2800000016000000,$6000000030000000,$4000800017A17D00,$D90000009D000000,$0000F70055000000,$887DFF000000FE00,$0F80030BC2170307,$0000020000F90B0F,$000000A6000000DF,$9C1D60020000004E,$BC00001638002100,$0E1003074343873B,$2E1F0BFB8403070F,$0000CD0BC0100F03,$003500AB00A83100,$70042BB15FEB0000,$2B0B4C000000F503,$23E3BB10841E00B0,$0000BB1303072100,$B8076203B07DD800,$0B008593E4000000,$8588B834000000F6,$EC1F0340011BB600,$050000005E000000,$6FF30011241C0FFB,$00B1D3079FAC41E0,$C01013370000001C,$EC182A000000EE03,$000000190002C7AB,$0891BB03082CA3DE,$2C57766603D30B42,$074162AB44001588,$00F21300870BCBBB,$0600761628090000,$00EC2C0C121FC42E,$43E7BBB3AB420BDA,$00BB0020CA030B10,$47B008E60000004A,$145D5858000000F4,$22420363A9588400,$20C1D308750BEFBB,$476B384052006165,$2D000010AF00F803,$08425FA000B0B11C,$08130B10EB03BB6B,$03473F7084BBBF87,$17C3FCCA6F0B2295,$044703BB0870BFEE,$08282BAC800B0387,$3BBF035DC3BF005F,$00FA03802137BB84,$8400576230330000,$03BB21080357BF10,$BB8438BFD357C30B,$0B0215033B42F833,$56213807000000D4,$85BB5F530842BF00,$EEBF5C38030B0310,$3C890308552FBB42:Data.q $034F2108BF005884,$C2E1D30B03421FBB,$C010032F0857BBBF,$C4443A000000FB0B,$87BB53BF384200FE,$BBBF70E1130B0310,$0BBB84032F270E10,$00AC5F4C0A4FF10F,$BBBF0E1003BF085F,$4FB8573F03EE1023,$00B108509203043E,$21036B03474210BF,$BB00F0E17FD30B84,$030721C2271F0E1C,$88425D5BF779250B,$FD0B031700170313,$84584143BB000000,$BB53210847BF0010,$D022BF130B43E003,$872703870E1B47B2,$00BB0E0B0B030710,$C22A031F171087AE,$8BE1280E1321D50B,$7043BF030F82BF00,$00BBBD76200317C7,$1FEA0000000B1717,$00AC42289A03C10E,$210FBB033F1084BF,$0004BF802CD30B03,$27031B4387BE0000,$5400C15877070F95,$0B108F0307E10E27,$BF1C2100F35FC207,$00130B030843BB3F,$E10000000B00BFE1,$BB070EE1271FC058,$072F37708400C22E,$111B510B0B032E11,$03BF085700AC5F28,$1B42150C00BF082C,$0000B133C4AE0323,$7C1033E500000013,$210800BAC428A303,$0B03BB42100337BF,$AF800200A385F0D3,$0000007100000073,$BB8A9C001015D808,$0384260B035F2170,$BF1C2100E357C20F,$7D130B030843BB37,$0B421C00C23BBFB8,$E80F036B3840035F,$F02815000010AA00,$09CB0385DFBF00C5,$AC036317C1E12BBF,$2FBF004210280AAC,$0BBE0B03BB842103,$7BD14E00BF108AD3,$0F087D036B1C2EBB,$842BBF008842285A,$130B217D03BB3710,$6BC70B9500BFC20A,$1A43AC770F847403,$035FF0BF005F0828:Data.q $7C106BDB8B9CB1BF,$21BF00EB1028B403,$0B030842BB032784,$3C000162BFFF84D3,$031C216FFC000000,$0828630BC10B037B,$BB2B234210BF00B1,$BFB841130B843A03,$21C0036F621C8C00,$0010AB00F00B037B,$08A2001557281F00,$267B73C708D53FBF,$2C0137A21D0B035C,$9A030EBEBF008BE1,$C1DBAFD15A00BF10,$00280EC46B037717,$BB4210031BBF2108,$0562BFEEE1D30B03,$F30B031F007B8300,$00282342B1000000,$038421BB1FBF0E10,$2F3F2CBFDFC2130B,$382187037B4384CF,$EF0058BE287E0B03,$2F00BFE10503BF10,$2103708F7F23BE85,$03170842BF003F5C,$D708D30B031087BB,$F2877F7A002C70BF,$21004379F0FF0384,$03BB08422B1FBF84,$27BF27CA131F7C0B,$C39F573B87C4F4C6,$0B83D484BF000F84,$00103FB7FC033EE6,$00006A0000000F00,$35A600EB1F0C4B00,$FF37D30B03E4213F,$D0BF007CDCBF3AB8,$7A0313842E0B839B,$0B7089033F4F68FE,$00BFDA1777735303,$0E1E003FA0B2F73F,$13031F108417ABA9,$AA03D70A0F877267,$08578F00BF4239F8,$3F8AE703DC2B1FAF,$DFCEBF8AF2000AFF,$3FBB7D00C2B89FDF,$572B3791FA03709A,$78E4523F9768073B,$688EC5E11C34DE39,$00000174BD800300,$01FFFF0201FFFF80,$070000C007030000,$FFFFE307E0070400,$C1FF0F16160000F0,$077F00070C2C8007,$073F00FC070C0CFE,$07F0072C0C1F00F8,$00C0070C2C0F00E0,$F06A074005800707,$05820118000E0000,$070082007C073807:Data.q $4081077F00FE000F,$FF073F00FFC307C0,$0FC0071F803A05FF,$2CF00707E00703A0,$074F8201F8070350,$07C0BCFCFFFF0F2D,$07FF0738287000FE,$C70781FF1F160980,$E007F7FF073184F0,$47E5CB3727BC2972:Data.b $57,$20,$97,$67,$77
    unchecked:        : Data.l 9662, 778:Data.q $00000000626C7A31,$00000000000025BE,$0000000000100000,$0001000100010000,$0025A80020073030,$2800000016000000,$6000000030000000,$4000800017A17D00,$D90000009D000000,$0000F70055000000,$887DFF000000FE00,$0F80030BC2170307,$0000020000F90B0F,$000000A6000000DF,$9C1D60020000004E,$BC00001638002100,$0E1003074343873B,$2E1F0BFB8403070F,$0000CD0BC0100F03,$003500AB00A83100,$70042BB15FEB0000,$2B0B4C000000F503,$23E3BB10841E00B0,$0000BB1303072100,$B8076203B07DD800,$0B008593E4000000,$8588B834000000F6,$EC1F0340011BB600,$050000005E000000,$6FF30011241C0FFB,$00B1D3079FAC41E0,$C01013370000001C,$EC182A000000EE03,$000000190002C7AB,$0891BB03082CA3DE,$2C57766603D30B42,$074162AB44001588,$00F21300850BCBBB,$DA007D6128090000,$E75882BBB3AB6210,$85882015FDCA030B,$EFBB034224ABA900,$7F6120C1D30B2085,$21BBB3AB6210A000,$21757FDC130B0384,$2108ABBFF08403BF,$08D30B42EB03BB03,$03BBB34210ABBFE1,$ABBFC2100385D70B,$0BAF0B03BB842103,$0842B3ABBF8421D3,$085D1317F70B03BB,$0842ABBF7C2103BF,$42D30B10BA03BB03,$03BBB31084ABBFF8,$03BF7085130B217F,$BB03AB1084BFD7C2,$BFAF84D30B03210B,$034217BBB3AB2108,$035D7CBFF708130B,$BB421003ABBF2108,$BF4210BAF8D30B03,$130B038421BBB3AB,$C2100385D7BF7F70:Data.q $0B03BB842103ABBF,$B3ABBF8421D30BAF,$1317F70B03BB0842,$ABBF7C2103BF085D,$0B10BA03BB030842,$B31084ABBFF842D3,$DC21130B217F03BB,$AB8421BF75F003BF,$E1D30B030842BB03,$85BBB3AB0842BFEB,$5FBFFDC2130B0310,$8403ABBF08420317,$84D32EBE0B03BB10,$03BB2108B3ABBF10,$83BF26A4135F5C0B,$423F735A030B217D,$3726D317D70B036E,$0BBF130B83F421BF,$0B03DA1C3F9E9303,$FDBFDCF65303225D,$005FFC3FCFE80085,$5CE17F7100BF5521,$CEBF5E755FF1003F,$76FA008571BF95EB,$F83F5D9003E1FE3F,$0007001C0F518104,$000003070080C000,$8000400000010780,$03000001FFFFFFFF,$07070020B000C007,$0F00001FFDF007E0,$E054B90707078E58,$CB9057473772E527:Data.b $67,$77
    inbetween:        : Data.l 9662,1180:Data.q $00000000626C7A31,$00000000000025BE,$0000000000100000,$0001000100010000,$0025A80020073030,$2800000016000000,$6000000030000000,$4000800017A17D00,$D90000009D000000,$0000F70055000000,$887DFF000000FE00,$0F80030BC2170307,$0000020000F90B0F,$000000A6000000DF,$9C1D60020000004E,$BC00001638002100,$0E1003074343873B,$2E1F0BFB8403070F,$0000CD0BC0100F03,$003500AB00A83100,$70042BB15FEB0000,$2B0B4C000000F503,$23E3BB10841E00B0,$0000BB1303072100,$B8076203B07DD800,$0B008593E4000000,$8588B834000000F6,$EC1F0340011BB600,$050000005E000000,$6FF30011241C0FFB,$00B1D3079FAC41E0,$C01013370000001C,$EC182A000000EE03,$000000190002C7AB,$0891BB03082CA3DE,$2C57766603D30B42,$074162AB44001588,$00F21300850BCBBB,$DA007D6128090000,$E75882BBB3AB6210,$0000201562CA030B,$0074000000270730,$002C430000C00000,$E1074B8708032FF0,$0F13F0E1030B0342,$210000C63B077090,$002C0000007B0000,$A900561678060000,$EF9082BB032F2108,$2C00201D88C1470B,$2B7084F43738BB2C,$2B070B0338423303,$000307E1700B031C,$0041000000B25B98,$A000808761070000,$0B03210ABB375884,$00000026BFE00B13,$03E0B2275710BFA8,$000000B3F3C087FD,$BF00B10062FE802B,$C2FB1FF30000006F,$000000FA03802C27,$10008073C321D8FC,$4842BFAE1103BFBE:Data.q $20B13717FC031B43,$007B0F8407FB6703,$BB4210031BBF2108,$87E6BFAE0B3B0B03,$8703570923031F10,$BF00C2107B478344,$085703BB8F842123,$3A1B3BBF0890030B,$3E3F03B844370384,$1BBF0010847B6F84,$0B43B803BB032108,$0387F01FBF43AF37,$0843BB1F238421BF,$5C03BFB842130B03,$0B3FBF032112231D,$8403BFE10B007B1F,$1DBB038B2108BFAF,$1FBFC21D370B0342,$9323BF8421037C3F,$1317F70B03BB0842,$73BFDC2103BF0855,$1BBF2108007B0F84,$F8370B03BB421003,$21BB1F23BF4210BA,$70BF7F70130B0384,$433703843ABF0387,$218BFFB890BF03B8,$370B087703BB0384,$BF03F0841FBF0875,$BF8421007B7321F0,$C20B03BB08421F23,$0E230310EABF131D,$10237FE508BF03E1,$0387700B03BB8F42,$BF030FE133875FBF,$031087BB038F0842,$3AB803BF7084370B,$234210BF037F0823,$3A130B843B03BB8F,$F8BF03F8421FBF84,$7CBF005F087B7310,$10031BBF2108035D,$F1ABB8370B03BB42,$1023033F210EBF57,$5F7B6F843EBF03AE,$7F42AEBF0BF90017,$7B7C216FBFE10803,$85BB031B0842BF00,$84BF708A370B0310,$C5233AB8031F43D0,$08B913BF68570375,$8423031F0842C3BF,$3FDC21673F8B03FF,$71030B030842BB27,$F7031FBFD210BFB8,$883F7B0309443B85,$BF0080762172BF8E,$031085BB03870842,$3FF8F9BF70BF3B0B,$0B032B8421BF5C7E,$030B70E10F03C2E1,$270307709513C2F8,$DC0B839A90BFDC7E,$2AB8273FD6940385:Data.q $3F6B4D4B0343BE33,$43177FD30B03C842,$130B83F421BF3726,$DA1C3F9E93030BBF,$DCF65303225D0B03,$FC3FCFE80085FDBF,$7F7100BF5521005F,$5E755FF1003F5CE1,$008571BF95EBCEBF,$5D9003E1FE3F76FA,$401C0F51A204F83F,$00000003009CED91,$FF80000001078040,$0020100001FFFFFF,$0007070000C00703,$800F0000F007E058,$162F07843E010000,$E00707F7396107EE,$5747CB97372752E5:Data.b $40,$2E,$67,$77
    radiochecked:     : Data.l 1150, 403:Data.q $00000000626C7A31,$000000000000047E,$0000000000100000,$0001000100010000,$0004680020071010,$2800000016000000,$2000000010000000,$2D00600017A1DF00,$A30000007D000000,$130BA40000162100,$A90000001200FC00,$0000FE0000001600,$2108B2000000E200,$61231B42B8130B03,$8A844D2BD3170041,$E11B130B210800F6,$1F5B0820002B2343,$0C00000162000C1C,$0B10840348000000,$21002B2321701B00,$3E000005639FDB84,$FF000000E9000000,$001084130B038842,$841F0033384A2B23,$372F21706BA75710,$21C2230B1382C403,$002767528400332B,$1B0321082FAF215C,$A10800332B438400,$102B2342B80013A3,$3FB8422B001B0342,$BF84A59B9310EB8B,$842B001B284A130B,$130B210803372F10,$0942332B23421700,$8700A35084579300,$0042100B03AF2108,$081300F8442B231B,$00A76343841F1B89,$0AE1231B4C0B1621,$849F5B170842002B,$130B210803272B12,$DB4A5200237F081B,$00130B842B9B631F,$1FF80000FFFF00FC,$000007E000000000,$000023C4000083C1,$0180000142001188,$0B10840309900000,$FF332B2321001B13:Data.b $FF,$00,$00
    radiounchecked:   : Data.l 1150, 336:Data.q $00000000626C7A31,$000000000000047E,$0000000000100000,$0001000100010000,$0004680020071010,$2800000016000000,$2000000010000000,$2D00600017A1DF00,$A30000007D000000,$130BA40000162100,$A90000001200FC00,$0000FE0000001600,$2108B2000000E200,$61231B42B8130B03,$8A844D2BD3170041,$E11B130B210800F6,$1F5B0821002B2343,$085C1B0076210C1C,$089FDB0021082B23,$332B23421C00637F,$A77F08571F002508,$252A332B23421C00,$252B00F842276700,$E1130AF8A300331C,$938B08433F2B0042,$2B10E12300F8429B,$421B130B294B0033,$12332B10B82300F8,$00BE10A35793004A,$0011222B23843E1B,$05A7631F1B421013,$231B88424C0B00E1,$5B10841700B8422B,$1F0B0327A1082B9F,$DB00C212231B1342,$0AFF0B9B6394A11F,$0000FFFF00000013,$000007E000001FF8,$E3C70000830050C1,$9F284203F18F0000,$231B0310840B03F9,$0000FFFF332B2000
    checked_W:        : Data.l 9662,1710:Data.q $00000000626C7A31,$00000000000025BE,$0000000000100000,$0001000100010000,$0025A80020073030,$2800000016000000,$6000000030000000,$FF00000017A17700,$FF9DFFFFFF40FFFF,$FFFFFF0050D9FFFF,$4300FFFEFFFFFFF7,$7C000BEE100007F8,$FFFFF90B00000FB8,$FFFFA6FFFFFFDFFF,$02FFFF10BEFF4EFF,$21FFFFFF0000169F,$003B21C3BCFFFFFF,$0710FB0F00870E07,$0F1FC0000B842E00,$31FFFF10F8FFCD0B,$35FFFFFF000058AB,$1CAFB82BEBFFFFFF,$B34CFFFFFFF50302,$BB1EFFFFFF0002C4,$1300FB00230021C2,$03B00EB0FFFFFFBB,$93C401E4FFFFFFB8,$080434FFFFFFF60B,$2C40B6FFFFFF00BB,$FF010FFFEC1F0018,$111F05FFFFFF5EFF,$FFFF6FF3241000EE,$D3009FB1059CE0FF,$03008513371F858E,$5DC01B2AFFFFFFEE,$FF19FF02C7FFFF00,$BB03082CA3DEFFFF,$E02F66000B704291,$44FFFF1588FF00BA,$870BCBBB074162AB,$2B09FFFFFFF20000,$4206FFFFFF005C02,$800F12FFFFFF1F60,$DA42C4FFFFFF00EB,$030BE7BB1620B3A8,$FF00002C23875CCA,$15E6FFFFFF4AFFFF,$1758FFFFFFF44702,$21A9FFFFFF00FC02,$0BEF1210BB0363C4,$00016523C142FE00,$476B384052FFFFFF,$2DFFFF10AEFFF800,$A0FFFFFF00E0101F,$034217BB6BB1085C,$BB4384BFF8AC000B,$F66F0B0021144700,$BBEC43BFC35770AE,$0B21570047843800,$BF42BF00C3AC2B80,$377700BBBF158803,$3342ABFFFFFFFA03,$574210BF00858833,$58000B842A03BB03:Data.q $003B008708BBBFF1,$FEFFFFFFD40B005F,$00BF0016213B0743,$0B10FF03BB5F0842,$2F5DC1BBBF158803,$0058843F0FF88903,$BC03BB0321084FBF,$C0BBBF7638000B43,$FF10FBFFFB0B0057,$10BF008588473AFF,$0B842F03BB530042,$001C21BBBFC56200,$4FE21D0B7709002F,$BF10AF00F0EB4F0A,$237707BBBF158803,$0321DF4F62B8C103,$2147BF000B105392,$000B087E036B0384,$27E1C200BBBF2B10,$F780B10B001C2707,$0E17135DFFFFFF0A,$FFFFFD0B00430003,$210800AE165B41FF,$0B03BB42105300BF,$22FFFFFFBFBC0500,$0727C384004796E1,$33402CBB0B002188,$1770F8AEFFFFFF00,$2FE10E130B454400,$F05803BFD621002B,$00BD03EE0B1743BF,$FF17FFFFFF00BB84,$042F1FEAFF2C5FFF,$84BF00E1622B9A03,$0B03210FBB033F10,$FFFFFF04BF802100,$0BD52700638718BE,$FFFFFF00C02B7707,$C2080007271C2154,$21002B5DC24A070B,$03BB08423F00BFC4,$000042BF0017880B,$C0FFFFFF0BFFFFFF,$BBF1C20727B10B1C,$2F870B0037CB9000,$1142BE1B0B845400,$031F88BF001D622B,$0CFFFFFF00042CBF,$335700032343F21B,$FF0B1713FFFFFF00,$A303C10A33E5FFFF,$378421BF00F8582B,$42000B030842BB03,$FFFFAF000100BFBC,$FFFF71FFFFFF73FF,$005953130AB808FF,$0B1082005F842EBB,$08002B1570520F00,$03BB37421000BFB1,$00FB85BF0085F80B,$006B0070E10B9DB8,$15FFFFFFE80F0043,$03BF885D00F8752B,$E1FFFFFF0EBFF005:Data.q $2B87F0AC03638BE0,$0342102FBFB10800,$88590085D70B03BB,$C385BB7B5A2900BF,$622B5A0FC10E006B,$BB37001084BF00E1,$BFBF10000B03210B,$6B95FFFFFF0AC700,$1A7774420F000B84,$03BF885F00F8752B,$6BB17CDB8BBFF09C,$0016212BB40310BE,$BE03BB03084227BF,$FF00BFF100000B10,$FFFFFF08583CFFFF,$57007BE10E006CFC,$BF000B102B630B08,$085F03BB2B842100,$FFFF00BFF880000B,$0870006C8C42C7FF,$FFFFF0043E0B007B,$804200155D2B1FFF,$0B70D5FFFFFF08BF,$E1370B84D4007BB1,$03BFD621002F0142,$D0AF0016D6BFD5E2,$2C6B03BE0877DB8A,$031BBF4210002B5C,$D7E2000B038421BB,$83FFFFFF000158BF,$E1FFF30B0087C07B,$6210002B23FFFF10,$0B03BB84211F00BF,$CF2FBF11F9000EFE,$008721C100780B1C,$621D002B0E1D7E0B,$FAFF00BFDE2003BF,$7F15C3232FFFFF16,$17BF21086BE6F403,$F1000B03BB421003,$FFFFFF000085BFEF,$C42E008762137C7A,$00BF0016211F54FF,$0B10FB03BB2B0842,$C6562727BFE13E00,$0AB11B173BA21F87,$0EFD0B833521BF00,$FF0000003FADFF03,$FF6AFFFFFF0FFFFF,$6B000F85F04BFFFF,$0B43EF033F4DC8AB,$4D0070ABBF6E7500,$F9000B83E870BF6E,$0B03A1C23FE93DBB,$DFBFEF6B5325D703,$7FF1003FBFA11B17,$AF8F9C8400BF5485,$CE17031F951F2BEE,$CEBFE4FE5595003F,$5CBB2E00AB87709F,$7E8E370326A43FDF,$F83FD90007D5E52B,$078040E000000F04,$60000307C0000007:Data.q $408000000174006F,$C00703000001F580,$07E0070700208000,$0000F008E9FFFFE3,$000780078583D60F,$00FC07FE070B037F,$071F00F807030B3F,$070F00E0070303F0,$0780070B100700C0,$000E0000F001416A,$7C07608038070118,$0020B0FE000F0700,$FF100EC30781077F,$401F80FFFF073F00,$1407E0070FC00781,$F8070B0A03F007E8,$07FC070B02000701,$07FF07F0E07000FE,$3E0781FF1FA05880,$07B0856D07F0C725,$B97237272E5CBCE0:Data.b $47,$57,$67,$00,$E4,$77
    unchecked_W:      : Data.l 9662, 807:Data.q $00000000626C7A31,$00000000000025BE,$0000000000100000,$0001000100010000,$0025A80020073030,$2800000016000000,$6000000030000000,$FF00000017A17700,$FF9DFFFFFF40FFFF,$FFFFFF0050D9FFFF,$4300FFFEFFFFFFF7,$7C000BEE100007F8,$FFFFF90B00000FB8,$FFFFA6FFFFFFDFFF,$02FFFF10BEFF4EFF,$21FFFFFF0000169F,$003B21C3BCFFFFFF,$0710FB0F00870E07,$0F1FC0000B842E00,$31FFFF10F8FFCD0B,$35FFFFFF000058AB,$1CAFB82BEBFFFFFF,$B34CFFFFFFF50302,$BB1EFFFFFF0002C4,$1300FB00230021C2,$03B00EB0FFFFFFBB,$93C401E4FFFFFFB8,$080434FFFFFFF60B,$2C40B6FFFFFF00BB,$FF010FFFEC1F0018,$111F05FFFFFF5EFF,$FFFF6FF3241000EE,$D3009FB1059CE0FF,$03008513371F858E,$5DC01B2AFFFFFFEE,$FF19FF02C7FFFF00,$BB03082CA3DEFFFF,$E02F66000B704291,$44FFFF1588FF00BA,$850BCBBB074162AB,$2B09FFFFFFF20000,$FF2162FFFF0077C0,$0BE7BB0B10B3A8DA,$00E01623CA42BE03,$03AB2108A9FFFFFF,$F7C1000BEF9082BB,$FFFFFF0000852315,$BF03BBB38842A8A0,$F803BFEE10000B10,$21BB03ABBF4210BA,$21BF75F0000B0384,$0B030842BBB30084,$03AB0842BFEBE103,$D7C2000B031085BB,$210BBBB3001084BF,$2EBEBFFB84000B03,$210803ABBF108403,$2108005D7C0B03BB,$0B03BB4210B300BF,$0803BF42EBBFB800,$03BB034210ABBFE1,$00BFC2100085D70B,$0BFB0B03BB8421B3,$BFBE1003BF842E00:Data.q $085D03BB038421AB,$084200BF7C21000B,$42000B10BF03BBB3,$0842BFEBE103BFB8,$000B031085BB03AB,$BBB3001084BFD7C2,$BFFB84000B03210B,$03ABBF1084032EBE,$005D7C0B03BB2108,$BB4210B300BF2108,$BF10BABFEE000B03,$031084ABBFF84203,$F084000B217503BB,$FE03BBB3210800BF,$8403BFE10B000B42,$17BB03AB2108BFAF,$10BF5F08000B0342,$0B842F03BBB30042,$0B835210BFAE1300,$210B3FAD37BEB903,$BF937AEB9B000B03,$68FE7A000B1C2E83,$53030B7089033F4F,$F7EF1BBFDAC575FB,$217FFC55003FE85F,$00E1753F715C00BF,$EB85CE5F15BF595E,$03FAE13FD97600BF,$0F04F83F9008FE5D,$0007070402E00000,$008000000307C000,$01F5800000010701,$00C0078041030000,$F007603FE0070700,$B0A907FB1C0F0000,$47372772E5E00707:Data.b $97,$CB,$57,$67,$00,$20,$77
    inbetween_W:      : Data.l 9662,1157:Data.q $00000000626C7A31,$00000000000025BE,$0000000000100000,$0001000100010000,$0025A80020073030,$2800000016000000,$6000000030000000,$FF00000017A17700,$FF9DFFFFFF40FFFF,$FFFFFF0050D9FFFF,$4300FFFEFFFFFFF7,$7C000BEE100007F8,$FFFFF90B00000FB8,$FFFFA6FFFFFFDFFF,$02FFFF10BEFF4EFF,$21FFFFFF0000169F,$003B21C3BCFFFFFF,$0710FB0F00870E07,$0F1FC0000B842E00,$31FFFF10F8FFCD0B,$35FFFFFF000058AB,$1CAFB82BEBFFFFFF,$B34CFFFFFFF50302,$BB1EFFFFFF0002C4,$1300FB00230021C2,$03B00EB0FFFFFFBB,$93C401E4FFFFFFB8,$080434FFFFFFF60B,$2C40B6FFFFFF00BB,$FF010FFFEC1F0018,$111F05FFFFFF5EFF,$FFFF6FF3241000EE,$D3009FB1059CE0FF,$03008513371F858E,$5DC01B2AFFFFFFEE,$FF19FF02C7FFFF00,$BB03082CA3DEFFFF,$E02F66000B704291,$44FFFF1588FF00BA,$850BCBBB074162AB,$2B09FFFFFFF20000,$FF2162FFFF0077C0,$0BE7BB0B10B3A8DA,$18000023CA43E103,$FFFFFF27FFFFFF07,$FFC0FF02C4FFFF74,$000321702FF0FFFF,$13E1C2000387C307,$FFFFC63B07E1200F,$2CFFFFFF7B0043FF,$00E0167B06FFFFFF,$032F2108A9FFFFFF,$0BC1000BEF9082BB,$3738BB0B0B002317,$007084032B1C38F4,$0B8400032177070B,$FFFFB25BC0040307,$2E0107FFFFFF41FF,$0B10A0FFFFFF0083,$000B038421BB2B34,$A8FFFFFF26BF5C01,$FD03FC1627576217,$2BFFFFFFB3F35810,$6FBF601000B87583:Data.q $27AC5F1CF3FFFFFF,$FCFFFFFFFA007005,$001D628373C3842E,$432908BF0315C2BF,$6782C2000375701B,$840083170BB807FB,$03BB2108031BBF10,$8875E6BF0057050B,$442E8300F094031F,$00BF00162183E647,$0B10AE03BB8F0842,$0EBE1B3BBF112103,$C2F36F3F00112003,$031BBFC421008385,$001DC30B03BB0842,$00BFF08400BB87BF,$0B43B803BB1F2108,$00842203BF43AF00,$03175FBF3F5DC2BF,$BB1084038BBF0842,$770FBF003B870B03,$93421000BFE10800,$C2150085FD0B03BB,$735F08BF770803BF,$2E03BB031B4210BF,$2100BFBE10000B84,$000B085F03BB1F84,$03BFDC2103BFDC21,$21FFBF1DC400D7C2,$0B030843BB038B84,$BF007084BFB87700,$1F002108BF732F84,$C21D000B03421DBB,$DCA1BF007C2103BF,$EE03BB8F0842007F,$3F84BF1DDC030B10,$1DBB038F2108BF00,$03BFC21D000B0342,$8F00BF8421007C3F,$001DC30B03BB0842,$73BF217700BB84BF,$1BBF7C2103BF085D,$0B10AB03BB030842,$033FF121BFB85700,$5F6FBF10BF00D7C2,$7708037FCA15BFB8,$1B4210BF6F5F08BF,$D7000B842B03BB03,$00570ABFC568BF85,$1F003FD084EB8BBF,$03570E0B03BB2108,$0317FC1FBF3A42BF,$BF3A213F7B002512,$0842BF0070B18372,$000B031085BB0387,$5C7E3FF8F9BF70BF,$0310840B00E10EBF,$3B070003210B0700,$C703078709000384,$085D83BFE9A9275D,$2742AB3FCD69030B,$3FE6B44B03843B33,$430021770B03DC84,$DF0B836F43BFF372:Data.q $03ED0E3FCF490085,$BEBF7B5303112E0B,$0BFF3FFDFD1BBF58,$9C002FEEBF8AA400,$BF2BCB002EAB3F2B,$DF0070BBBFE2BDCE,$3FCBB2035C3F3F2E,$E000000F040100F8,$078040C000000707,$1000010780000003,$03000001F5800020,$07070000C0082C07,$0F0000F0070042E0,$2F1F770701000080,$0707B0A9F7070B1C,$CB9747372772E5E0:Data.b $57,$67,$00,$20,$77
    radiochecked_W:   : Data.l 1150, 356:Data.q $00000000626C7A31,$000000000000047E,$0000000000100000,$0001000100010000,$0004680020071010,$2800000016000000,$2000000010000000,$FF00C00017A1DD00,$FF7DFFFFFF2DFFFF,$FFFFFFA3FF02C2FF,$FF001B1DC02D0BA4,$FFFFFF12FF0000FF,$FFFFFFFEFFFFFFA9,$03B2FF2C42FFFFE2,$002B121B1310430B,$08D3FFFFFF1700E1,$1601FFFFFF4D2BB0,$1B13210F0B001742,$1F2C025B43C58823,$C248FFFFFF0C0F1C,$23C21C1C130C03C2,$4D9FDB0021610FA9,$E9FFFFFF3E0F600A,$210F3E0B008416FF,$571F0F56A12B871B,$00E1052F77A70843,$3B7D2B2388210B13,$0B10BEB267000B4B,$16532348000B12AF,$3FA3BEE1000BA342,$2F003FBD42BFFF0F,$4800BFF508579356,$43631F43E21B1396,$3FF242231B4C3F2C,$09429F5B1710B100,$1B130B108503272B,$1FDB0042523B78B8,$EFC55F0B9BB50B63,$F80000FFFF000000,$00000007E000001F,$0023C4000083C100,$0001800000118800,$840B030990284200,$332B2000231B1310:Data.b $FF,$FF,$00,$00
    radiounchecked_W: : Data.l 1150, 342:Data.q $00000000626C7A31,$000000000000047E,$0000000000100000,$0001000100010000,$0004680020071010,$2800000016000000,$2000000010000000,$FF00C00017A1DD00,$FF7DFFFFFF2DFFFF,$FFFFFFA3FF02C2FF,$FF001B1DC02D0BA4,$FFFFFF12FF0000FF,$FFFFFFFEFFFFFFA9,$03B2FF2C42FFFFE2,$002B121B1310430B,$08D3FFFFFF1700E1,$1601FFFFFF4D2BB0,$1B13210F0B001742,$1F215C5B43C58823,$A9231B0021610F1C,$9FB087DB000F0E10,$8F56230070850F4D,$0CA7571FA1040F2B,$82FFFFFF00132B80,$1310B47D2B230B58,$21080B855CB26700,$A3000B42D7332B00,$B800BFF10B3FDC2A,$B13FBF7DEA2B2310,$B2BF7FA857930012,$631F1B421F130044,$231F921B4C3F1162,$884A5B170010853F,$130B031084272B9F,$DB00C2123B1B2BC5,$0B5E2A9B6395A81F,$0000FFFF00F800EF,$07E0000000001FF8,$E3C7000083C10000,$00014000F18F0000,$8703F99F0000E187,$2342001B13A108F1:Data.b $2B,$33,$FF,$FF,$00,$00
  EndDataSection
EndModule
CompilerIf #PB_Compiler_IsMainFile;Hässliche Demo und zusätzlicher Code für die DLL
  EnableExplicit
  CompilerSelect #PB_Compiler_ExecutableFormat
    CompilerCase #PB_Compiler_Console
      CompilerError "Das Modul RibbonGadget unterstützt keine Konsolenanwendungen!"
    CompilerCase #PB_Compiler_Executable
      Global Window_0, Text_0, String_0, Button_0, Text_1, String_1, Button_1, Checkbox_0, Checkbox_1, Text_2, String_2, Button_2, Checkbox_2
      Enumeration FormFont
        #Font_Window_0_0
      EndEnumeration
      LoadFont(#Font_Window_0_0,"Verdana", 10)
      Procedure OpenWindow_0(x = 0, y = 0, width = 1010, height = 200)
        Window_0 = OpenWindow(#PB_Any, x, y, width, height, "Ribbon-Test", #PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget|#PB_Window_ScreenCentered)
        Text_0 = TextGadget(#PB_Any, 20, 133, 30, 25, "ID:")
        SetGadgetFont(Text_0, FontID(#Font_Window_0_0))
        String_0 = StringGadget(#PB_Any, 50, 130, 50, 25, "", #PB_String_Numeric)
        SetGadgetFont(String_0, FontID(#Font_Window_0_0))
        Button_0 = ButtonGadget(#PB_Any, 10, 160, 100, 25, "Daten lesen")
        SetGadgetFont(Button_0, FontID(#Font_Window_0_0))
        Text_1 = TextGadget(#PB_Any, 210, 133, 43, 25, "Text:", #PB_Text_Right)
        SetGadgetFont(Text_1, FontID(#Font_Window_0_0))
        String_1 = StringGadget(#PB_Any, 260, 130, 140, 25, "")
        SetGadgetFont(String_1, FontID(#Font_Window_0_0))
        Button_1 = ButtonGadget(#PB_Any, 240, 160, 130, 25, "Daten schreiben")
        SetGadgetFont(Button_1, FontID(#Font_Window_0_0))
        Checkbox_0 = CheckBoxGadget(#PB_Any, 120, 130, 90, 17, "Gecheckt")
        SetGadgetFont(Checkbox_0, FontID(#Font_Window_0_0))
        Checkbox_1 = CheckBoxGadget(#PB_Any, 120, 153, 90, 13, "Inaktiv")
        SetGadgetFont(Checkbox_1, FontID(#Font_Window_0_0))
        Text_2 = TextGadget(#PB_Any, 810, 133, 50, 25, "Farbe:")
        SetGadgetFont(Text_2, FontID(#Font_Window_0_0))
        String_2 = StringGadget(#PB_Any, 860, 130, 140, 25, "")
        SetGadgetFont(String_2, FontID(#Font_Window_0_0))
        Button_2 = ButtonGadget(#PB_Any, 870, 160, 130, 25, "Farbe setzen")
        SetGadgetFont(Button_2, FontID(#Font_Window_0_0))
        Checkbox_2 = CheckBoxGadget(#PB_Any, 120, 173, 90, 13, "Versteckt")
        SetGadgetFont(Checkbox_2, FontID(#Font_Window_0_0))
      EndProcedure
      
      UsePNGImageDecoder()
      UseJPEGImageDecoder()
      UseGIFImageDecoder()
      UseBriefLZPacker()
      
      Global event,ribbon,ribbonevent,ribbonid
      Define color,text.s,id,linkwindow
      
      Procedure CatchImageEx(*cmem,csize,packer=#PB_PackerPlugin_BriefLZ);ID oder #PB_Any, Addresse, gepackte Größe, Packer-Plugin (optional)
        Protected *dmem,dsize,retval,ID=#PB_Any
        If *cmem>0 And csize>0
          dsize=PeekL(*cmem)
          If dsize>0
            *dmem=AllocateMemory(dsize,#PB_Memory_NoClear)
            If *dmem
              If UncompressMemory(*cmem+4,csize-4,*dmem,dsize,packer)<>-1
                If ID=#PB_Any:retval=CatchImage(#PB_Any,*dmem,dsize):Else:retval=CatchImage(ID,*dmem,dsize):EndIf
              EndIf
              FreeMemory(*dmem)
            EndIf
          EndIf
        EndIf
        ProcedureReturn retval
      EndProcedure
      
      OpenWindow_0()
      ribbon=Ribbon::Create(window_0,#PB_Any,Ribbon::#Ribbon_Color_Auto,Ribbon::#Ribbon_Color_Auto,Ribbon::#Ribbon_Style_Black,Ribbon::#Ribbon_Flag_FullHover);|Ribbon::#Ribbon_Flag_HoverEvents);,RGB(208,208,208))
      Ribbon::AddItem(ribbon,1,Ribbon::#Ribbon_Type_Category,"Category 1",CatchImageEx(?icon1,?icon2-?icon1))
      Ribbon::SetItemToolTip(1,"Test","Überschrift",#TTI_INFO_LARGE)
      Ribbon::AddItem(ribbon,2,Ribbon::#Ribbon_Type_Category,"Category 2",CatchImageEx(?icon2,?icon3-?icon2))
      Ribbon::AddItem(ribbon,3,Ribbon::#Ribbon_Type_Category,"Category 3")
      Ribbon::AddItem(ribbon,4,Ribbon::#Ribbon_Type_Category,"Category 4")
      Ribbon::AddItem(ribbon,5,Ribbon::#Ribbon_Type_Category,"Category 5",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(ribbon,6,Ribbon::#Ribbon_Type_Category,"Category 6")
      Ribbon::AddItem(1,10,Ribbon::#Ribbon_Type_Group,"Group 1",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(1,20,Ribbon::#Ribbon_Type_Group,"Group 2")
      Ribbon::AddItem(1,30,Ribbon::#Ribbon_Type_Group,"Group 3")
      Ribbon::AddItem(1,40,Ribbon::#Ribbon_Type_Group,"Group 4")
      Ribbon::AddItem(1,70,Ribbon::#Ribbon_Type_Group,"Group 5")
      Ribbon::AddItem(2,50,Ribbon::#Ribbon_Type_Group,"Group 6")
      Ribbon::AddItem(3,60,Ribbon::#Ribbon_Type_Group,"Group 7")
      Ribbon::AddItem(10,100,Ribbon::#Ribbon_Type_PushButton,"Button 1",CatchImageEx(?icon1,?icon2-?icon1))
      Ribbon::AddItem(10,101,Ribbon::#Ribbon_Type_Separator)
      Ribbon::AddItem(10,102,Ribbon::#Ribbon_Type_Checkbox,"Checkbox mit langem Text",CatchImageEx(?icon3,?spock-?icon3),Ribbon::#Ribbon_Status_Checked)
      Ribbon::AddItem(10,103,Ribbon::#Ribbon_Type_Button,"Button 2",CatchImageEx(?icon2,?icon3-?icon2))
      linkwindow=Ribbon::LinkPopup(103,"Neues Testfenster",200,200)
      UseGadgetList(WindowID(Ribbon::GetPopupHandle(linkwindow)))
      ListViewGadget(#PB_Any,10,10,100,100)
      UseGadgetList(WindowID(window_0))
      Ribbon::AddItem(20,200,Ribbon::#Ribbon_Type_Button,"Button 3",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(30,300,Ribbon::#Ribbon_Type_Button,"Button 4",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(30,303,Ribbon::#Ribbon_Type_ImageButton,"Button 4",CatchImage(#PB_Any,?spock),Ribbon::#Ribbon_Status_UseOriginalImage)
      Ribbon::AddItem(30,301,Ribbon::#Ribbon_Type_Button,"Button 5",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(30,302,Ribbon::#Ribbon_Type_Button,"Button 6",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(40,400,Ribbon::#Ribbon_Type_Container)
      ;Ribbon::AddItem(400,401,Ribbon::#Ribbon_Type_Button,"Button 7",CatchImageEx(?icon1,?icon2-?icon1))
      Ribbon::AddItem(400,403,Ribbon::#Ribbon_Type_Checkbox,"Checkbox 2",Ribbon::#Ribbon_Image_None,Ribbon::#Ribbon_Status_Checked)
      Ribbon::AddItem(400,401,Ribbon::#Ribbon_Type_Combobox,"Button 7",CatchImageEx(?icon1,?icon2-?icon1))
      Ribbon::AddItem(400,402,Ribbon::#Ribbon_Type_PushButton,"Button 8",CatchImageEx(?icon2,?icon3-?icon2))
      ResizeGadget(Ribbon::GetItemGadget(401),0,0,104,80)
      AddGadgetColumn(Ribbon::GetItemGadget(401),0,"",100)
      AddGadgetItem(Ribbon::GetItemGadget(401),-1,"Test 1")
      AddGadgetItem(Ribbon::GetItemGadget(401),-1,"Test 2")
      AddGadgetItem(Ribbon::GetItemGadget(401),-1,"Test 3")
      AddGadgetItem(Ribbon::GetItemGadget(401),-1,"Test 4")
      SetGadgetState(Ribbon::GetItemGadget(401),2)
      Ribbon::AddItem(40,404,Ribbon::#Ribbon_Type_Button,"Button 9",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(40,405,Ribbon::#Ribbon_Type_Separator)
      Ribbon::AddItem(40,410,Ribbon::#Ribbon_Type_Container)
      Ribbon::AddItem(410,411,Ribbon::#Ribbon_Type_RadioButton,"Radio 1",Ribbon::#Ribbon_Image_None)
      Ribbon::AddItem(410,412,Ribbon::#Ribbon_Type_RadioButton,"Radio 2",Ribbon::#Ribbon_Image_None)
      Ribbon::AddItem(410,413,Ribbon::#Ribbon_Type_RadioButton,"Radio 3",Ribbon::#Ribbon_Image_None,Ribbon::#Ribbon_Status_Checked)
      Ribbon::AddItem(50,500,Ribbon::#Ribbon_Type_Button,"Button 10",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(60,600,Ribbon::#Ribbon_Type_Button,"Button 11",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(60,601,Ribbon::#Ribbon_Type_Button,"Button 12",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(50,501,Ribbon::#Ribbon_Type_Button,"Button 13",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(50,502,Ribbon::#Ribbon_Type_Button,"Button 14",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(ribbon,1000,Ribbon::#Ribbon_Type_HeadButton,"",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(ribbon,1001,Ribbon::#Ribbon_Type_HeadButton,"",CatchImageEx(?icon2,?icon3-?icon2))
      Ribbon::LinkPopup(1000,"ColorPicker 1",400,300)
      Ribbon::LinkPopup(1001,"ColorPicker 2",400,300)
      Ribbon::AddItem(ribbon,1003,Ribbon::#Ribbon_Type_HeadSeparator)
      Ribbon::AddItem(ribbon,1002,Ribbon::#Ribbon_Type_HeadPushButton,"",CatchImageEx(?icon1,?icon2-?icon1))
      Ribbon::AddItem(ribbon,2005,Ribbon::#Ribbon_Type_RightHeadImage,"",CatchImage(#PB_Any,?spock));,Ribbon::#Ribbon_Status_UseOriginalImage)
      Ribbon::AddItem(ribbon,2004,Ribbon::#Ribbon_Type_RightHeadTextButton,"Test",0)
      Ribbon::AddItem(ribbon,2000,Ribbon::#Ribbon_Type_RightHeadButton,"",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(ribbon,2003,Ribbon::#Ribbon_Type_RightHeadSeparator)
      Ribbon::AddItem(ribbon,2001,Ribbon::#Ribbon_Type_RightHeadButton,"",CatchImageEx(?icon2,?icon3-?icon2))
      Ribbon::AddItem(ribbon,2002,Ribbon::#Ribbon_Type_RightHeadPushButton,"",CatchImageEx(?icon1,?icon2-?icon1))
      Ribbon::AddItem(70,700,Ribbon::#Ribbon_Type_ButtonContainer,"")
      Ribbon::AddItem(700,701,Ribbon::#Ribbon_Type_Button,"",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(700,702,Ribbon::#Ribbon_Type_Button,"",CatchImageEx(?icon2,?icon3-?icon2))
      Ribbon::AddItem(700,703,Ribbon::#Ribbon_Type_Button,"",CatchImageEx(?icon2,?icon3-?icon2))
      Ribbon::AddItem(700,704,Ribbon::#Ribbon_Type_Separator)
      Ribbon::AddItem(700,705,Ribbon::#Ribbon_Type_PushButton,"",CatchImageEx(?icon1,?icon2-?icon1))
      Ribbon::AddItem(700,706,Ribbon::#Ribbon_Type_Button,"",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(700,707,Ribbon::#Ribbon_Type_PushButton,"",CatchImageEx(?icon1,?icon2-?icon1))
      Ribbon::AddItem(700,708,Ribbon::#Ribbon_Type_Button,"",CatchImageEx(?icon3,?spock-?icon3))
      ;Ribbon::AddItem(70,709,Ribbon::#Ribbon_Type_Button,"",CatchImageEx(?icon3,?spock-?icon3))
      Ribbon::AddItem(2,80,Ribbon::#Ribbon_Type_Group,"Testgruppe")
      Ribbon::AddItem(80,800,Ribbon::#Ribbon_Type_Button,"Testbutton",CatchImageEx(?icon1,?icon2-?icon1))
      ;ActivateRibbonCategory(2)
      Ribbon::SetMetric(ribbon,Ribbon::#Ribbon_Metric_UpdateMode,0)
      Ribbon::Render(ribbon,Ribbon::#Ribbon_Render_Force)
      AddKeyboardShortcut(window_0,#PB_Shortcut_Control|#PB_Shortcut_I,1000)
      ;ExportRibbons()
      CompilerIf #PB_Compiler_Debugger
        ;Ribbon::StatisticWindow(ribbon)
      CompilerEndIf
      
      Repeat
        Select WaitWindowEvent()
          Case #PB_Event_CloseWindow
            Select EventWindow()
              Case window_0
                Break
            EndSelect
          Case Ribbon::#PB_Event_Ribbon
            ;      Debug "EventGadget (=RibbonItem): "+Str(EventGadget())
            Select EventType()
              Case #PB_EventType_LeftClick
                SetGadgetText(string_0,Str(EventData()))  
                ;           Debug "LeftClick"
                ;         Case #PB_EventType_RightClick
                ;           Debug "RightClick"
                ;         Case #PB_EventType_MouseEnter
                ;           Debug "Hover"
                ;         Case #PB_EventType_MouseLeave
                ;           Debug "Unhover"
                ;         Case #PB_EventType_RibbonPopupClosed
                ;           Debug "Popup close"
                ;         Case #PB_EventType_RibbonPopupOpened
                ;           Debug "Popup open"
            EndSelect
          Case #PB_Event_Menu
            Select EventMenu()
              Case 1000
                MessageRequester("Ribbon-Info","Info:"+#CRLF$+"RenderCount: "+Str(Ribbon::GetStatistic(ribbon,Ribbon::#Ribbon_Statistic_RenderCount))+#CRLF$+"DrawCount: "+Str(Ribbon::GetStatistic(ribbon,Ribbon::#Ribbon_Statistic_DrawCount))+#CRLF$+"RenderTime: "+Str(Ribbon::GetStatistic(ribbon,Ribbon::#Ribbon_Statistic_RenderTime))+"ms",#PB_MessageRequester_Info)
            EndSelect
          Case #PB_Event_Gadget
            Select EventGadget()
              Case button_0
                id=Val(GetGadgetText(string_0))
                If id>0
                  SetGadgetText(string_1,Ribbon::GetItemText(id))
                  SetGadgetState(CheckBox_0,Ribbon::GetItemStatus(id)&Ribbon::#Ribbon_Status_Checked)
                  SetGadgetState(CheckBox_1,Ribbon::GetItemStatus(id)&Ribbon::#Ribbon_Status_Deactivated)
                  SetGadgetState(CheckBox_2,Ribbon::GetItemStatus(id)&Ribbon::#Ribbon_Status_Hidden)
                EndIf
              Case button_1
                id=Val(GetGadgetText(string_0))
                If id>0
                  Ribbon::SetItemStatus(id,Ribbon::#Ribbon_Status_Checked*GetGadgetState(CheckBox_0)+Ribbon::#Ribbon_Status_Deactivated*GetGadgetState(CheckBox_1)+Ribbon::#Ribbon_Status_Hidden*GetGadgetState(CheckBox_2))
                  Ribbon::SetItemText(id,GetGadgetText(string_1))
                EndIf
              Case button_2
                text=GetGadgetText(string_2)
                If FindString(text,",")
                  color=RGB(Val(StringField(text,1,",")),Val(StringField(text,2,",")),Val(StringField(text,3,",")))
                Else  
                  color=Val(text)
                EndIf
                Ribbon::SetMetric(ribbon,Ribbon::#Ribbon_Metric_Color,color)
            EndSelect
        EndSelect
      ForEver
      
      DataSection
        icon1:
        Data.l 9662
        Data.q $00000000626C7A31,$00000000000025BE,$0000000000100000,$0001000100010000,$0025A80020073030,$2800000016000000,$6000000030000000,$0600F60017A15D00,$0016210017000000,$00130AEB0B031F00,$005D0000001C0080,$0000020000960000,$000000E8000000C4,$03C2C4FE000000FD,$1F231B13210807FF,$C4005C223B332B42,$9BCD00000074A202,$433B084203A33AE1,$230000165317FC4B,$F80000009D000000,$0004FF03837B3840,$FE39100AFE170600,$FE631D12FF52190F,$12FF036A1F200114,$0C7052180FFE631E,$AF5307EC422F231B,$000E00E000635B10,$80F9000000900000,$00FF0E0402036BB1,$8F2A1BFE51180F00,$D73F28FFC33925FE,$24FED94327000BFE
        Data.q $00FEDA4228FFDB48,$28FEDC4B240B0318,$D74028100CFFD841,$3B42168F2A1AFE2B,$AB630B0321084B43,$004300802C736B42,$08035B6000E20000,$26FF8C291AFF2D0D,$429327FFD2100041,$0027FFDC4427FFDA,$FFE66421FFDE4700,$FFE55926FFE96C26,$6D0B03E24A284026,$23E56222FF0C43EA,$26FFD9433300622B,$1F5B5310AC4BD240,$7B0070057B730342,$FE4F8000FC000000,$FE992C1DFF240A06,$4725FE0000D63F28,$4827FFDC4726FEDB,$FE0000E96A26FEDF,$FEF8A722FFF28D24,$86C68A1BFEE39E1E,$5225FED86121FF00,$C68A1B0B043003EA,$33F28D218024231B,$261801FFDE4A253B,$06FF992C1D53DA45,$BF7303872842240A,$8B030082C9837B10,$FF040100FE470000
        Data.q $00D23D28FE6E2015,$4726FED84028FF00,$7125FEE15122FEDD,$FEF39921FF0000EB,$FF7F5514FEBD7D19,$2B0EFE08004E360F,$24FEBB4C1DFF033E,$20210B03F0431C5A,$8000337F55142317,$E35521FFEC71253B,$280084FEDB4427FE,$6BFED23D28FFD840,$8B10AB037B733142,$0000000100802C93,$150604FFFF0044A1,$FF0000DBA6301FFF,$FFDE4627FFD94228,$0FEF8A21FFE86720,$2F0DFFA06416FF00,$03C00C31220BFF47,$1FF69920FFC97E1B,$3B030840130B0342,$21FFF006228C2143,$1F6B5740625BE663,$93038316217BA631,$F3B00087009B0FE0,$BD3724FE200906FF,$28FFD740280000FE,$25FFDF4827FEDB43,$C6701A0001FEEA64,$261B09FE462C0CFE,$03070876261B09FF
        Data.q $031C09FE280B0314,$031C1007170B3C62,$C56F1B000C4BFF0B,$E04827FFEA6425FE,$7BFFD8426B0842FE,$DC169B938B162183,$0805FF2700025000,$4327FFC13824FF1C,$E04927FFBB0000D8,$944516FFEA5E25FF,$06FF2016070000FF,$1AFF893B15FF1D14,$BF501C018AFFAF49,$03B842139F4618FF,$2108433B3310842B,$4927630CC35B5313,$831085D94426E3E1,$0040A39B8857938B,$0223EA0000001500,$B53522FE0C000203,$DB4527FED84227FF,$FEE958254F0001FE,$FE150F05FF7F3614,$22FFBE4F1C03C000,$F200006622FEF164,$8B4112FFCC591CFE,$43571BFEAB4D18FE,$1EFED05D1DFFC100,$571B0B020003D761,$C4FE8C4411FF1BC1,$21603B33CB571D10,$36108014FF034B43
        Data.q $21DD4826736BFE7F,$A39B0B10938B8796,$E304409B00F838AB,$DC482583FE8C291A,$FFE75126CF9000FE,$000E0A03FE923C16,$0A03FE0E0A03FF00,$581EFE48210BFE0F,$FEF26822FF0000D0,$FFF4701FFEF26A22,$6E21FE0005EE6B1E,$7021FFF36F21FEF3,$F36F0B038A04FEF3,$FEF2731CFF1B0003,$84F36A22FEF06821,$5F53380C4B433B10,$49277300C4933C16,$21628BDD4A24FEE0,$2500AB1700A39B93,$0C1BFB4009000000,$1FC0003E28FE4113,$4D26FEDF4727FFDA,$FF0000C44A1EFEE5,$FF0B0702FE0F0803,$00CC551DFE5D280E,$21FFF26922FE3F90,$F200006D21FEF26B,$EE6A1FFFF4771DFE,$C58821FEF37221FE,$03FEF89521FFF602,$1CFF1BF6880B0200,$EE69200188FEF479
        Data.q $4342003BF36D22FE,$8002FF5D280E534B,$4E26736BFE0B0710,$ABE04A26FE09C8E5,$21C2A39B934216FF,$00FF4F3C0000B3AB,$00FFB63522FF0300,$4C26FFDE4925278B,$FFEA5325FF0000E3,$FF2C1704FF3E1809,$6423FF0000BC4B1A,$6A22FFF26722FFF2,$FF6800F36C22FFF2,$FFF3781BFFF3716B,$7521FF0000F06F20,$4514FFEB7420FFF4,$03C4215D3F13FF6B,$F57A1D1B0018130B,$3B843433EE6D1EFF,$185BF26006678B43,$21012A1105FFC155,$16C4DF4D24837B73,$90B3ABA328629BB7,$9BF0000000080000,$37FEBB988848150D,$1BFEE750AF8C0026,$4B00431D0BFEB342,$F16322FEE4631AFF,$20007F732F24A167,$F0751BFEF374206F,$204800FEF37720FF,$FEB25E19FFF47A5F
        Data.q $200B03860439280D,$7820FF1B0003F47A,$7421FEEF751BFEF4,$006A4B5F3B1920F4,$FEF26422C3FEF220,$1E01000BFEE3621B,$2683FEB4421BFF4B,$DC49251131FFE14B,$0CBBB3AB0B10A347,$109D2E1EFE0F4A58,$04FFE4374B249FA1,$993C17FEEB542500,$A32C1CFFEC5D22FE,$72D3BB44006973F3,$0020FEF37520FFF3,$FFF0771AFEF47700,$FEF47C1FFEF47B20,$7E1FFFF57D002120,$80180360370FFEF4,$F57C20FEF47D1F0B,$3B33F0771A10C423,$4B98006D4B4330A8,$FE993C16FFEC5D6B,$24FFC3EB54220424,$04ABA3DF5310E04E,$478FA3C08CBB03B1,$47148026FFD43E28,$EE5724FFE87BFFDB,$1EFFEB5A220011FF,$B56BED6220FFF36A,$7A870F260077EF6F,$FF0000F0791AFFF4
        Data.q $FFF57F20FFF57E20,$42F5811FFFF58020,$280B03D9731CFF0C,$2B358CF57E1B1318,$684B4B7100438B7A,$FF0000F26E1DFFF2,$FFEB5B22FFED5E21,$E0E85125FFEF5824,$28FF67E24E25FF08,$108DB3ABD362163E,$25E718001BCBBFBB,$25FEE34C26FEDD4A,$5F23FFFFEB22C053,$FFEF6903661CFEF1,$735FC00033F16622,$8D22FEF68422FEF4,$FEF890000021FFF7,$FFF48A1FFEF89320,$8200081FFEF58420,$831FFFF5831FFEF5,$F6840F18C11EFEF5,$1E238018F582030B,$213BF68E21FEF68F,$D39F3330534B4384,$EE681C0840FEF268,$EB00625425837BFF,$DF4C24FEE44C26FF,$90E3BBB3AB10B0A3,$24FF9F681E140B80,$E64F26FEE000004D,$F15C23FFED5624FE,$1CFEF106406123FE
        Data.q $00FFF4762237EE6B,$F49620FEF78E2200,$B86F1AFED27F1CFE,$19FEAE6A190000FF,$1FFFC7781BFEB36D,$F998200000FEEB91,$F5861FFFF89120FE,$1F1810FEF5861EFE,$861BF891200BF686,$210833C7781B23C0,$8E225300894B433B,$880047F47622FFF7,$5624FEF15D237B73,$FEE64F25FF00C4EE,$B3AB2162A3E14F23,$822618FF377800BB,$241A10FFD94128FF,$90FFEF5924AFE24F,$6D1CFFF26323FF00,$DF0005851EFF23EF,$543912FF8D5616FF,$360350004B3511FF,$311BFF764B14FF4D,$FFF79320FFC47500,$1B0B018803F6891F,$032B2363B11BC474,$6B1084635B530842,$51258B8320017B73,$1E11FFE35123FFE9,$033B21888126181F,$2784401FCB4523BB,$005C24FEEA3B5123
        Data.q $23FEF16023FFF000,$17FFF5881FFEF165,$432E0EFEA3002B5D,$03170CFE3D2B0EFF,$FE6E44120B00010F,$FEF68A1EFFD2781B,$781B0B038C088B1E,$0E1003231B62C7D2,$2E0EFF040203070B,$84FFF384206BFE43,$2293005C8B837B12,$5213DB4428FEE553,$281AFEEFC04703CB,$552423732000FE8A,$2623FFF05E24FEEB,$FEF47823FEF16200,$33FE2F89A5864A14,$0D0F000503078E1E,$1EFEB26618FF422B,$FEF68CB30003F58A,$30F78C1EFEF68C1D,$C30D23F58ACB0B18,$07843C3B33422B21,$01837B730B421803,$FEEC5524FFF05E00,$FFDD4527FEE65522,$E54820BBB3AB0858,$40221BFF7B241783,$B7ED5724FFE55503,$5403BC18FFF26823,$030018261B08FFA3,$FFDF771CFF643D0D
        Data.q $8D1EFF0A0BB78A1F,$030B0310818E03F7,$E48119238018F68C,$03EE103B61350FFF,$93F160238380C17B,$0B11AB634DA15721,$1C11FECF7010BBB3,$E6562101201BFE5F,$6721FFB7ED5824FE,$FE2B1A08FE04D0E6,$00071D5C2814061F,$8E4F13FF1E150300,$F0801AFEF5871EFE,$6BFEF58B1E0D00FF,$60FEF68F1DFFF78E,$00F68E0B8F1E0381,$831923F68D1EFE0C,$3BC431F3841EFEF2,$08400B0342F14B43,$EE12105B238B837B,$84ABFFDE467F21FE,$0A0B060095BBB385,$21FEE753241B3510,$45173BFEEC23005C,$0383B0150E04FE98,$1C12050018FE07FF,$F5851FFFAC5D17FE,$1E9BF18119182BBF,$1EFEF690BF00B18D,$FEF181BF70030B90,$4B433B1084F6871F,$830B21005F532E1C
        Data.q $2508ACFEEF631F8B,$102108093FFEE54E,$8B59BB240203BB35,$19D64426FF070201,$C134EC601FFF333C,$03FC000F5B2A0E8B,$08B86118FF170E04,$91FFF585E720FF27,$4410F63B1FBF8B41,$03C420BBFFF78F33,$2B23F663148D130B,$5343E14B43BF3108,$611E8B830800035B,$A3C421E64E26FFEC,$813413BB6167B3AB,$016FFF98301AFECF,$EF6422FEEC5E2000,$090602FE431F0AFF,$FE0C0807FF030780,$8020FEAF5B010117,$3000F585207BFEF5,$891FFFF2831AFE9F,$FEF68D08441FFEF5,$FEF6900C493BAB1F,$BF1B0800F693BF1F,$48881FFEF0801BFE,$43181C1720FFF611,$21880C080253F581,$6B2183004D0B0367,$210BFEEA5821FFF2,$00BBB31082ABA38F,$0145160C13028AB7
        Data.q $EE681EFEEB54E700,$050301FE642D0EFF,$89461307FF030700,$21FEF57E21002CFE,$8304688321FEF581,$9700449B1BFEF588,$1FFFF68E1FFEF58D,$8F1FFEF68F00852F,$1BBF8005071FFFF7,$20FEF07D1EFEF78F,$10BFF68421BF8188,$060367894613530E,$C188EE691E830BC4,$AB58E0A3E44D267F,$FF028FA4095200B3,$1FFF6BC001C44121,$00FFAA4B18FFF065,$44210803E0000201,$017F22FFF47C21FF,$7BFFF58221FFF502,$1D8B0000FFF68621,$20FFF07F1DFFF78D,$F68D2003B1FFF68C,$8C130003038E20FF,$821FFFF58A1BFFF6,$F582433B3310C1F2,$2407FFF47C53400C,$AC5116036B700146,$2193818AED6020FF,$00B3AB18E1A3C542,$0E008A17DA9B1710,$80FEE85125FE561C
        Data.q $1506FEED6D1DF300,$0700000401FFEB2E,$F17721FFD36E19FE,$898222FEF48022FE,$43000021FF03F547,$1CFFF78B1FFEF688,$40FEF68C20FEF181,$2103FEB3F78D2110,$21FEF68D0BB0008E,$F3358A861BFFF78C,$804B431800BF77FE,$801BFFF5811EFEF4,$1606736BFECF6410,$FEED6E1DFE01962E,$1D0EFE0C587F5A24,$5B00B385C1AB1756,$B9401EFF021B4008,$FFF16820FFE000FF,$00080401FFC15A1B,$7D23FF63320EFF00,$8123FFF07A1CFFF5,$FFF58323FF0000F5,$FFF68722FFF58522,$8A22FF0042F68822,$58A3FFF1821CFFF6,$0B8420038E03BF18,$22FFF2005083BF03,$803BF68922FFF589,$F07B1C53F5834381,$736BF47C231880FF,$6321FF0DB0C46119,$9BC50CBA401E07EE
        Data.q $5BF22000AB7C22A3,$FE00002D0F075BC6,$FEF05B24FFE65224,$00AF571AFEEF701E,$7E24FEC9661EFF00,$8224FEF07B1DFFF5,$FEF58424FE0000F5,$FEF68823FFF58624,$8B23FE0000F68923,$8C23FEF1831CFFF6,$FF050BF78D23FEF6,$0B0C5003FEF68E23,$3B338B631023038D,$24FEF58524000043,$24FFF07B1DFEF583,$70736B8604FEF47E,$85938B832108FEEF,$2C007004ABA39B58,$11270400F7000000,$FEF16321FEF76C26,$7E26FFF075000022,$8521FFF58125FEF4,$FEF07B000022FEF5,$FFF68825FEF58625,$8A000024FEF68925,$831DFFF78C24FEF6,$2124FEF68D24FEF1,$03078E24FFF78E04,$8C230631230B588D,$F485A74389A03B33,$25FFF17B230000FE,$20FEF57F26FEF581
        Data.q $EF5D230188FFF27B,$9358878BEF5824FE,$E0A36F00705AA39B,$1FFF039B3818FF09,$8327FFF3BF800069,$001EFFF68527FFF5,$FFF68827FFF07E00,$FFF68B26FFF68A26,$F726FFF68C09C026,$F754168F26FFF184,$10030B0321639003,$8A31803B338D230B,$A127FFF685534BF6,$EE655725FFF58408,$AB8B9C38187B818B,$2FA40082009B0310,$4000001AFE070201,$6E20FFF15C23FEAF,$0029FFF58629FEEF,$FEF48722FEF68900,$FFF68D28FEF28426,$8F28FEF68E040028,$C2FEF1851FFFF703,$F79128FEF6912800,$030B0316319207FF,$8D3B00002F2362C6,$8024FEF58B24FFF6,$FF2400F68929FEF0,$F05C23FEEF6F8B29,$83FEB0210B411AFF,$070480009315F08B,$090301B3BE000000
        Data.q $22FFAC00014019FE,$2AFFEF6A21FEF160,$825730002BFEF688,$912BFFF7902BFEF0,$FF03922AFE1800F7,$84F58F29FEF38A21,$942AFFF7942AFE00,$94280B033C0007F7,$FE1421F18522FFF7,$214301843B2F932A,$6F13500C2A53F183,$734216EF5C23FEF1,$0062938B2177837B,$00FBC10000000C00,$F06021FF8E357F6A,$2AFFEF64210000FF,$26FFF79229FFF582,$F8952D0000FFF187,$F8972DFFF8962DFF,$24015EFFF8982BFF,$0063F8982DFFF188,$F5922CFFF48D2303,$25FFF8953300062B,$260CF48C2BFFF48D,$6B4314EF5D22EF53,$00588B8321D77B73,$0047AF0000000900,$5920FF55200CFE00,$7126FEEF6020FEE1,$FFF48927FE0000F3,$FEF89B30FEF38F2B,$9C30FF00A0F89C30
        Data.q $789D0BF28C24FEF8,$2418C00B03FEF82C,$45FFF89B0323F18B,$F28428FEF5932A00,$FEF06383E00226FF,$8455200CFFE05720,$837B21F773036F50,$810000000200005B,$FE180903FF4B7000,$5F000021FE9C3D16,$6E22FFF06122FEEE,$0033FEF18529FEF1,$FEF7942FFFF89F00,$FFEF7922FEF68627,$7D28FEF37B021827,$F27F2101800B03ED,$F9A03223F38029FE,$23FFF388280130FE,$60002120FFDFF06A,$0903FE9B3C16FEEE,$7C736BBB0842B318,$00003F0001087B15,$1206030000C3DC00,$5E21FFA03F16FF2E,$5FCBC0EF6221FFEB,$95000236FFE06F26,$AE40FF7CA63BFFA2,$03800066AF40FF69,$36FF7BA63CFF69AE,$E071250000FFA395,$EF6121FFED641FFF,$171885FFEC5F21FF
        Data.q $63038842534B9F3E,$7ECB816B00EB846B,$8F400027F2000000,$FFB44819FE6B2A0F,$9320003AFE7F8232,$3BFE40933AFF0341,$4C9B3B18E1FE4898,$B3461923010C170B,$210B4B433B42C433,$001400FE00635B53,$0000000B10800000,$1007FF0000037BE7,$6830FE134A21FE05,$FE00081A7737FF17,$FF4F9D3BFE45963A,$231B13431C1B7837,$4B10EF43072F2C42,$0000000500E00053,$8BB2F49E0000004C,$FF082A1403933001,$14BF018AFF45963A,$332B03C421130A2C,$38007C01433B0855,$17A30000B2000000,$35FE368135FE1034,$1135171284FF3983,$705B231B215F0367,$1003AF3F21093200,$2CBAB81B13076F42,$00A5000000440000,$130B034215C00000,$07814200FF00FE18
        Data.q $00F803C040071FF8,$00456000E0071F00,$014314000080FF2D,$DA7F00508A3B3407,$0F008C6B1521C045,$279C0707E0070414,$3875A807234D69BC,$F0E16F00F0E107FD,$0E1CB707C3879707,$C8DD4407224EDFC7,$59A6F7C0FF0FFFE1,$7F0000FE3F2FAE41,$FF5707E0FF0701A1
        Data.b $F0,$0F,$90,$42,$07,$6F
        icon2:
        Data.l 9662
        Data.q $00000000626C7A31,$00000000000025BE,$0000000000100000,$0001000100010000,$0025A80020073030,$2800000016000000,$6000000030000000,$3800C00017A1D700,$4333AD4F400C9845,$B155464EB0020052,$0A404EB05244035D,$0C9A463933AE4F01,$00A74E3F00BF8023,$524375AF55461100,$4838FAAC4D3ECAAE,$FFA94534FF0000AA,$FFA94333FEA94333,$4838FF0040AA4534,$4623FAAD4D3EFEAB,$AB4F4075B0021F55,$AF544500FC003B11,$37EBAE0000544645,$21FEA43A2AFEA846,$A000A12F1CFEA133,$032B18FEA02C1AFE,$21A23321130B080C,$3B33FEA946372304,$4E3E000000430FBE,$402FECAE534415A9,$FF9F2F00001EFEA5,$FE9B210DFF9C2613,$1D003008FF9B1F0A
        Data.q $1D08FE9D1D08FF9C,$FE9C1F03000A0B9D,$FE9F2F1E239B210D,$413BFFA54010082F,$00004B7D7015AD50,$A6423299AE524300,$951E0DFE9D2D1BFF,$03FF8D16060003FF,$01FF890F02FE8911,$02FF07FE030B000D,$8A11030000FE8A0F,$961F0DFF8E1606FF,$3B8421FF9E2D1BFE,$004B3C00DFC04B43,$22FBA3483C25A900,$05FE801710FE8D2C,$851401FE7F000011,$8F1B00FE8B1700FE,$0DFE9100000A00FE,$00FE9C1C0EFE9B1B,$9000001F00FE9109,$871101FE8D1600FE,$021710FE801005FE,$3CFE8E2C22FE8200,$DC25AB4E3FFBA449,$974842000000531D,$8E2D20FF8C362E9C,$05FE9500002E1DFF,$00FF903E00FF8C23,$9800004800FE9546,$BB4D23FF9D1B07FF,$001F03FFB94827FE
        Data.q $00FE994400FF9B00,$07FF923F00FF9747,$972E1DFE9000001F,$8D362EFF8F2B1EFF,$539C9921D74842FF,$3C158F433900C000,$8F00005121F69654,$A94519FF993725FF,$004000FF97240EFE,$00FE9A4100FF9500,$25FFA71D0DFF9D3F,$B83B23FEBB000041,$9E3E00FFA51D09FF,$00FF9C00004100FE,$17FE9B2311FF9840,$9B00073725FFAA43,$97523CFF925221FF,$43075F9895463BF6,$956031729900004F,$942718FE8C3F18FE,$01FE9D00002B19FE,$00FE991D00FE9315,$A200001100FE9E17,$AA1005FEA50800FE,$000800FEA90E03FE,$00FEA41500FEA600,$02FE9C1E00FEA017,$A12D1BFE97000010,$8F4318FE952416FE,$42FE97021D5E31FE,$44005C005B729B4E,$8F00004226CD9C58
        Data.q $8C0F04FF891F11FE,$000A00FE950B00FF,$00FFAC0B00FFA100,$00FFBC0900FEB50A,$C30900FFC0000009,$C20900FFC40900FE,$00FEBE00000900FF,$00FFAF0A00FFB709,$9900000A00FEA50A,$8D1F11FF8F0E04FF,$7F5443FE934326FF,$3D00C0005BCD9D21,$1EFD96453B229547,$9A170BFE93000029,$AD0B00FFA40E02FF,$17FFB600000B00FE,$1FFECE2716FFC92A,$CF00000900FFD733,$D20900FED10900FF,$003D27FFD10A00FF,$10FFD12616FEDC00,$00FEBB0B00FFC920,$A90E02FFB200000B,$96281EFF9E160BFF,$40FD990217453BFE,$4200DC0063229B4A,$9F00003B316C9E4B,$A4180AFEA0281BFF,$000B00FFA90D01FF,$27FFBD0C00FEB300,$28FEDF5319FFD53E,$D80F04FFE100003F
        Data.q $DA0A00FED90900FF,$2AFFDC00001609FF,$1FFFE1531BFEE444,$C100000B00FFD533,$AF0C01FFB80B00FE,$212519FFA71307FF,$41FFA23B31FEA400,$40007DC0636C9F4A,$A94435AFA600004A,$AC2010FEB0422EFE,$00FEAF00000C00FE,$38FEC71B0CFEB90B,$E400004F1CFEE255,$E2180BFEE9482EFE,$000900FEE10900FE,$29FEE72615FEE200,$3CFEE6511EFEEA41,$C80C01FEE6002059,$0106F7FEBE0B00FE,$FEB4422EFEAB1200,$AFA84A40FEAF4B3B,$473E000000630BEE,$3E18FFAA4132E9A6,$FFB73001401DFEB4,$00FFC98BFFB30C00,$E9472DFFD40F0300,$E70A00FFE30D02FE,$00FEEA09000000FF,$0BFFE90A00FFEA0A,$EB40280000FEE818,$CE0A00FFD70B00FF,$000000FFC40B00FE
        Data.q $1DFFB62212FFB90B,$5DFFB04534FEB940,$F00063E9A9473E08,$A5443A1D9C423900,$28FEA736280011FE,$200AAC0E01FEB43C,$80FECF0A00FE8B07,$EF0900FEEA772F24,$18FEF52A190000FE,$00FEF10900FEF52A,$E609000001FEED09,$D40A00FEDD0900FE,$0283A000CA0B00FE,$2FFEB63623FEB20E,$A8433A0085FEAF3F,$D7006B1DA8473DFE,$34000048A84B4100,$09FFA1251AFEA43F,$00FFB00D01FEA615,$D12C19FFBD100300,$DF0A00FFD50F03FE,$00FEE80A000000FF,$26FFF61105FFF00A,$FB48280000FEFB51,$F40900FFF90C01FF,$000000FFED0A00FE,$18FEDA0A00FFE40A,$00FFC51608FFD62B,$AD160AFFB60C0100,$A83E34FFA6251AFE,$6B48AA4B42085DFF,$366BA84D43007000
        Data.q $9A34220000FE9F43,$B20C00FEA01E0EFF,$160160FFC51B0CFF,$EE9BDD1A0CFED93A,$03FFF60A000000FE,$12FEEC2A17FFF20F,$F110040008FFEB24,$F30900FEF70A00FF,$FEE114084F8000FF,$FFCD2212FFDE3916,$1D0DFFBA0C000000,$4336FF9D3422FEA6,$6BAA4E10BA43FFA2,$86B7784C00E0006B,$88000016FECA8733,$3A10FECB790DFED5,$0009FEC30C00FEA9,$FEDD0A00FED41700,$FEC44512FECF1809,$830DFECF6F000010,$8B0AFEE18A0BFED9,$FEDC8600000DFEE2,$FECA5112FED27610,$0A000000FECC210D,$0C00FEDA1609FEE3,$010EFEAB330FFECA,$FECB883253C97730,$006B0BAE86BA7B4C,$952E99D99F460000,$0009FFD98F17FED8,$FFD3820AFEDE8D00,$FEBF1E11FFA82919
        Data.q $8B66FFB85900003F,$8841FEA87D51FFAF,$FFF5A6000008FFBC,$FFFCAF08FEFCAF08,$8C00003BFFFAAB08,$8965FFAD8251FEC3,$3011FEB96246FFAD,$FFAF2717FFC31E00,$8F002E174BCD7D0D,$9F46FFD8952EFFDA,$00DCA5498FFDA0DA,$961AFEDA9B319F00,$8618FEE1960DFFDC,$FFD3C099FF0000CA,$FFF2E5A0FEB49671,$BB83FF0000E3D194,$C012FFCD962FFED2,$FE0000FCC312FFFB,$FFFBC112FFFCC312,$00CFB77FFED1992A,$E6A1FFE3D094FF00,$C9A1FFB4956FFEF3,$4BC3811BFF0C00DA,$2EDA9C31FFDD971A,$006B9FDCA548FF04,$A3359FDEAC4C00B8,$FEDF9F1FFE0000DC,$FEC98B1DFEE49F12,$AA7FFE0000E1D3A9,$B581FEF4E7A5FEC4,$FE0014C3A571FECF,$FEF9D731FEDEAF36
        Data.q $BA340B032000D832,$007DFEC3A36FFEE6,$FEC4AA7D2BCAAF30,$86030021FEE8DDB1,$A33553E4A012FEC1,$9EDFAC10BA4BFEDD,$96E1B44F00E0006B,$AD000027FEDFAB3A,$B03BFEE9B92DFFE2,$0040FFC5995FFFDC,$FFBE722EFEBF8200,$FEAF4C1DFFB26628,$481DFFC34A000013,$8022FEBC481DFFBB,$FFB46D000021FFCC,$FFB6491AFEBF8724,$7600002FFFB16829,$9D61FFC1843FFEC0,$012EFFDBAE3EFFC9,$FFE3AD27FEEABA00,$94E2B44FFFE0AC3B,$BC540000006B0BAE,$A84DFEE6C0507EE4,$FEA96C000032FFD4,$FF7A330FFF8C4616,$0A000000FE7C1102,$1E09FF8F0A02FF87,$0012FFC82F01FE9F,$FECB4B10FFCD5A00,$FFBC731BFFD63A14,$1A03FEBD8000001C,$0A01FF8E0D04FFAA
        Data.q $FF7E0F000002FE88,$FF8C4617FF7A320F,$A900104DFEAB6F34,$BD54FFE7C251FFD5,$005A00BAE06B79E5,$FECC9B4B4EE7C300,$FEAA6E35FEB77D3C,$4516FE8F4B00001C,$0E00FE7A0A03FE86,$FEBC15000000FE98,$FEBB1D09FEC71500,$5C000016FECD6818,$B727FEDF561FFED5,$0000FEBF4213FEDB,$FEBF1500FEC81500,$FE7C0902FE9A0E01,$7136438442300015,$0B4CFEB67C3CFEAC,$46E5C45AFECD9D01,$01D0A95000AE006B,$97497DE1B4000057,$5B26FEBE8742F1CA,$FF915300001EFF9B,$FFA91301FE840D06,$1A000000FFC11600,$631AFFE11B00FED6,$0026FED09C28FFD3,$FFD2701DFFC98D00,$FFD81A00FEE11D01,$1201FFC718000000,$4F1DFF870C06FEA7,$FF9B5C000127FF8F
        Data.q $EFC89649FEBD8742,$00670BFE77DAAF55,$B6590DDDB3570000,$0026B5B9853D54DF,$FE8E120AFF945100,$FFB91301FFB31702,$2C0CFEDA1B000000,$1B04FFF33D1AFFE9,$FFDD1A000005FEE0,$FEEA2B0CFFF43D1A,$14000001FFDC1B00,$110AFEB31601FFBD,$103AFF924C24FF92,$52DAB157B7B58100,$00EEE05B0BDBB156,$392922A56D000032,$1204FE941911FE8B,$FEB511000001FEA5,$FEF34E26FED61900,$2900000EFEF85C1F,$591BFEF73714FEEA,$0000FEF24923FEF8,$FEB61001FEDA1A00,$FE98170FFEA61104,$6831FE8C35010F27,$342B00BE004B31A2,$FEAF29000015E793,$FFD51C00FFC21E04,$2700000DFED91901,$1901FFF53E1AFFE5,$001AFFE81A01FEE6,$FEE7270CFFF43F00
        Data.q $FFD71C00FFD91801,$2814FEC41D000104,$3928F595342BFFB0,$000000470FBE0586,$FEB82E18D2AB4030,$4F000023FFDFA661,$1F00FEF02100FFE3,$000DFFC63007FFE2,$FFD65B0EFED65900,$FEDF1F00FFC73408,$491EFFF021000000,$2D17FEE0AB64FFE3,$DFAB3E10FE2FFFB9,$D3B2443400E00043,$8900004FFEBE3019,$3005FEE7330DFEDE,$0032FEE59521FED1,$3203CF36FEFECC05,$E99D230000FEFECD,$E72F0BFED33707FE,$338043FEDF8C51FE,$00FB8043D8B24433,$311AE10000B64635,$2D05FFD52306FEC2,$FE0000F3A62CFFCF,$FFFFD045FFFFBD37,$00F7C749FEF6C348,$AC2EFEFEBD380BC0,$FF0004D23507FFF7,$FFC3311AFED62305,$00433FB8E0B74635,$3219EEBA4A380000
        Data.q $8522FFD42305FEC6,$FEFEB837FF0000E0,$FFFDD051FFFFBC3D,$B553FE0000EDB052,$BC3EFFFED252FFEE,$FF0000FFB837FEFE,$FED32205FFE89428,$FBBA4A38FFC6321A,$614800800043EB43,$2C09FEC8331AEFC3,$FFFCCB3FFF0000C8,$FFFFCD50FEFEC745,$E671FF00C0FFE569,$CD500BF9E872FEF7,$FFFFC646FE0000FE,$FECD390DFFFECE41,$6148FF0FFFC8331A,$D9D6A577BF0000C3,$FECE4814FECA3920,$E361FEFEDC00004F,$C37CFEA1A775FEFE,$FEFEF308007CFEC0,$A4A975FEBEC1037D,$51FEFBDF610000FE,$1EFED4591AFEFEDC,$D8AA7A087FFEC937,$C8634B00700043D5,$170000FECA3C25A6,$5EFFFFDF56FFCE47,$00FF535A70FED9C5,$FEF480FF646F6A00,$858E82FFFFF480FE
        Data.q $60FE363C550000FF,$1DFFFFE058FFDCC9,$CA3D260087FED559,$F70043A2C8634AFF,$32000054C6523F00,$54FFCB3114FECA47,$00FEFEEA6BFFF6D3,$C9BF6AFFE6D97000,$FDF380FEFDF380FF,$74FFD2C86E0000FF,$58FFFEEB6DFEEFE3,$CD3B180008FFFADB,$C7523FFFCA4832FE,$33000000437F7050,$23D8CB523F04B746,$01FEB25626FED33B,$CEB157FEB38D4400,$FEF47FFEF5E777FE,$59FEF6E978038000,$00FEB48E45FECFB3,$D33C23FEB15F2C00,$C04A36D5CB523EFE,$410000004387FF03,$2CFBD98B683FCD56,$B470370000FFD44A,$B8914AFFB38A46FE,$720000FEEEDB70FF,$46FFB9924BFFF0DE,$08FFB4773BFEB38A,$DA8E6BFFD3533200,$3B557C3CCE5540FA,$5D61D98767000000
        Data.q $30FED83D23FBDC7D,$BB8848FFC100005F,$C69E53FEC49C53FF,$33FFBB00008A49FF,$5CFFD74024FEC164,$D821577F60FADC7B,$D7574100F000335E,$330000DBDB553F42,$35FEDB4026FEE04B,$00FED35F3BFED358,$564013FEDA412608,$4042BBD75741D9DB,$05D24E3800E0002B,$5900004252DE5842,$8568BCE27A5F9AE0,$FB4299E05A43BBE2,$5DD4513B51DE5803,$FF0205005D70ABCF,$018007FFFF0FF0FF,$7F0000FE03070B01,$573F0000FC07700B,$00EE1F0000F80780,$07015F0F0000F007,$5707631C070000E0,$071574FFAF7F382A,$0A1C03C01F033914,$003FA1D50707E007
        Data.b $00,$00,$07
        icon3:
        Data.l 9662
        Data.q $00000000626C7A31,$00000000000025BE,$0000000000100000,$0001000100010000,$0025A80020073030,$2800000016000000,$6000000030000000,$D100FC0017A1DF00,$DD0203DDDD01D1D1,$DDDD031BDCDCDC1A,$0F15C303071C2EDD,$0B10080307843E0B,$6757F010D8D8D803,$2F2E020202000000,$3FFF424242B92F2F,$40404018B8FF3F3F,$5C380F030B42E103,$0B0802030742B80B,$1D1D1DE60B414141,$2E00000777155C75,$49FF515151672E2E,$216BFD5F042C4949,$200F70AE030B035C,$B7E002FD03070B1C,$00444444FD434343,$4FFF464646FF0700,$77D44A4A4AFF4F4F,$C000830701010108,$525252440F0F0F00,$6CFE4200024242FF,$FFFFDADADAFF6C6C,$B80004162EFDFFFF
        Data.q $C00B0F570E000B10,$00F3F3F30B000710,$C1C1FDC9C9C9FF00,$8787FFB8B8B8FFC1,$FF454545FD008287,$871DF0C7CB4D4D4D,$0FE1424242090500,$FD6F8284FE787878,$84000307210800FE,$0307210800030770,$0843000307421700,$FFFF530000000307,$BDBDFDCACACAFEFF,$FEC5C50249C5FDBD,$87042FFD8FA8A8A8,$00E0128B4F0D0D0D,$338821CF30A1A1A1,$FD00815E63F9F9F9,$1C0F000B2170FDFD,$040B000721700BAE,$BABAFFF8F8F80E80,$C7C7C7C30000FFBA,$484848FF757575FF,$8FB62A217F2A2AFF,$9B61AEAEAE000088,$6FFE676262208462,$0BE10B0034003562,$07E10F0B0F857000,$C1C1C1C30B840400,$9C9C9C07FE839019,$8FE3323232470217,$5067ADADAD00F008
        Data.q $21041F7171715FC3,$0B000B84076F0084,$070BC3840F002E15,$00C4C4C40B002B80,$A1A1FFC2C2C27FD0,$FE042F444444FFA1,$00E1C08FF03D3D3D,$5F5A7043107070BF,$0B842E006BE10B00,$07842B0B0F15C300,$3E085FBF0B857000,$BF00C2B18FEF3E3E,$00072170EB5B0BD4,$0BB8700F0085C20B,$C603200B0087C207,$C1C0C0C03FC4C4C4,$3CFEC3A1A1A1FD08,$1A4310BFFF093C3C,$B80007842E6F00C3,$AE0B0F570E000B10,$A1880B1776000710,$006B0070855F5A7F,$870FC2B8000BC2C5,$470B8E1700070B70,$07EB7AB15BBF7621,$DAFDEDEDED17801C,$0307FE031621DADA,$D9FD0700420B5C38,$7E43E2E2E2FED9D9,$E9E90B3F4B804B1D,$B1C23BFF6F822CE9,$0B030BC607FD03A0
        Data.q $C4C6FDC2C2230000,$BBBBFFBFBFBFFFC4,$CACACAEFFD4E10BB,$5A7FA86253C5DD4A,$FDC6C6C20000005F,$FF3C3C2BFF545444,$3F2EFD3E3E01E02C,$0FA85D404003FF3F,$FF555547FD0B0000,$06C2C2C3FFA6A6A3,$F6FFB9B9B9C7FD40,$80EBBF5F3842F6F6,$FF0000C5C5C0BFEB,$FF413E2CFD30301E,$84413A26FF423B28,$310F00000307FD43,$33FF3F4033FF4342,$3721C03B35FD3639,$3600063A330B03FF,$383825FF3E3F30FD,$83A72431ACACAAFF,$32BFC2BE5FF3F3F3,$58489F00005B7FD4,$5F58FE3F3D2AFD58,$FD008650A8BBFD46,$074FA7B8FE4FA7B8,$40FE50AEC1030000,$0FFD776725FD3F4A,$DBAF11FEE30300B5,$00B010FEDBB003FD,$2CFEDAAE11FDDB00,$59FD3C3D2EFD5A54
        Data.q $C4C4C5FE65000665,$F4F4F4FDB9B9B9FD,$3D2CFF83405F2FF8,$1CDFFF50A8B9633D,$FD52C0DAFF53C400,$E5030000FF53C1DB,$21FF3F4B44FD53C8,$FF0205D105FF8571,$CA0803FFFFCB09FD,$19FDFFCF060B0000,$A1FF393B32FFB897,$C7C7C8FD51514401,$C05F8BBBF4F4F47F,$C03C3C2A5F5A7F50,$BDD6AF4FA7B8BFC0,$FF53BFD8FD070051,$430000FD52C6E203,$06FF837021FF3F4A,$C0FFFFC90AFDFFCE,$CC070BFDC7080380,$FFB79519FD000EFF,$10535344FF383B33,$3D2ADFD00C5BBFBE,$339208413A26FD3D,$C37000FE52BED77B,$3F4A43FE53C6E203,$06FD8370210084FD,$09030600B7FEFFCE,$19FEFFCC070BFEC8,$373A31FDB7000795,$C6C6C7FE535344FD,$433F64BB2A3F7791
        Data.q $886B5F17DD5A7FED,$ACBE3F8800DF5BBF,$30DEFD52C6E1FD50,$0307C3DEFE52C306,$4B45FE53CC0001EA,$D504FD867321FD3F,$CE0703C30814FEFF,$18FEFFD2050B007F,$413E2C3F7900BC99,$78FF46000C6D6BFD,$77FD487677FF4877,$487A7C0307600076,$2C562BFF404739FD,$21FD957D20FF5E00,$7C0B035000FF917A,$0E32FF736528FD94,$40BBBBBB7F3E3F3D,$0C2DFE4142317FEF,$FD48402BFD474000,$0B70002BFE47402B,$33FD424232FE4903,$3E4232FD40002042,$003303FD3E4132FE,$FD404332FE0B4178,$00347FFBF440402F,$FFE65805FD364000,$FDFF5C00FFFF5E00,$5E03FFFF5D1E0000,$FF000455412EFDFF,$FD85D317FF57732A,$19030600FF83CD1A,$23FD84D0180B82CC
        Data.q $3F3B32FF6A07AE97,$5F5A31C0FFAB247F,$FFBBDB40185708BF,$03A80007FDFD5A00,$20702BFF53412EFD,$1CFD81C919FF5500,$C230031A03FF7FC4,$9224FD7FC71A0B7D,$DF5B3510BFBF8468,$08FE36000340343F,$00FDFF5B00FDDB57,$5C03C31C00FEFE5B,$FD004253412EFEFF,$FE81C919FD55702B,$0B7EC31B030280B7,$6892240179FE7FC7,$F33F063A3D3A30FD,$DCAB3FF8955FF3F3,$5A7FDA867F9A577F,$DCBF10FB3F5F2394,$FD525243BFC000AB,$2ECCCCCCFFC2C2C3,$205BBFEC435F5A86,$45D7570A3F2CDF4B,$034712C2FE43B784,$712AFD543F20015D,$0B18FE83CD18FD56,$82CC1901900B03AF,$3A56473F669025FE,$F05BEFEFF0FE5604,$FF00006262557FFD,$FF58452CFD3C3E2D
        Data.q $60B75213FFB75212,$065311030713FD28,$2DFF4D4230FDBF00,$AC60699624FF4F5E,$6600068F250B036B,$3C3B2BFF454831FD,$00532115848479FF,$5A7F6A18078F2177,$23FFDFDFDC00005F,$32FF3B3D2DFD3535,$363E3100E1FF3840,$000003FF374032FD,$403E30FF3F41300F,$310861FD3C392FFF,$42113B0B03FF3E3A,$F5F5F5478621BB07,$5B195ABF7F620053,$FEE7E7E56A0002B3,$1C5C5C4DFD7A7A6E,$0F032E1707FE030B,$7B075B5B4C0B8180,$F153BBB188FD8686,$085C003F2C5F0075,$0F500B0F2B87000B,$6A180BE177007307,$216B0087085F5A7F,$210F70AE000B005C,$420B5C2E00070B1C,$2107EBF5085BBFEC,$210F70AE000B005C,$C60BF08500070B1C,$EE3D3D3DFF3F5901
        Data.q $613F0073588F0BF8,$2100C31A614A1861,$000B708500076F84,$00070B70850FC2B8,$9B7F8F9C820B708B,$C0E23FDAC8FF9B9B,$9D210B9D9D008F5F,$E1006F3638C3FF2C,$0F000B850B006B42,$0B000B84070B70E1,$360BF7F7F70E067A,$7373FFC6C6C6BF00,$B22B2B2BBFE04373,$DB3F3F3F00AE008F,$7272FF4747035647,$2E150B032F84DF72,$2F00070BC3840F03,$A0BEFDC8C8C80B03,$69A3A3A33FBEBE37,$09093FE810D3FD4F,$0D0D00EB808B4A09,$4343437B3C4FC00D,$D2FF6464640000FE,$FBFDFAFAFAFFD2D2,$C20B03B170FFFBFB,$00070BB8700F0385,$C3FFEAEAEA0B0386,$B2B2C7FDC32780C3,$F78282325B82FFB2,$00B80487C0BFD90F,$4A83FC1B5C2A2A2A,$F7962E0BDB9F4A4A
        Data.q $0F570E030B10B803,$32420B030710F00B,$B31BF86F6F424225,$01CB48021548483F,$2400560083030101,$4110BB41AE303030,$3D6B03E1186FFB41,$151515DB3D02173D,$DEDEDE005C007469,$7703DD5D78DDDD0E,$7F096306D6D6D608,$C007FFFF80C56000,$0000071F00200100,$17C0FE0000FF0700,$07AC41FC0000FF3F,$1707394255F6F81C,$4716B137275CB907
        Data.b $FF,$E0,$57,$00,$00,$50,$07
        spock:
        Data.q $464A1000E0FFD8FF,$4800010101004649,$1112E1FF00004800,$4949000066697845,$000200000008002A,$0000001400020132,$0004876900000026,$0000003A00000001,$3931303200000040,$322030313A30313A,$0034353A33323A32,$0003000000000000,$0000000100040103,$0004020100000006,$0000006A00000001,$0000000100040202,$000000000000119F,$464A1000E0FFD8FF,$0100000101004649,$4300DBFF00000100,$0604050605040600,$0A08060707060506,$0E140A09090A0A10,$1718181417100C0F,$1A1F251D1A161614,$202C2016161C231B,$1F19292A29272623,$29282530282D302D,$0707014300DBFF28,$130A0A130A080A07,$282828281A161A28,$2828282828282828
        Data.q $2828282828282828,$2828282828282828,$2828282828282828,$2828282828282828,$C0FF282828282828,$0378007800081100,$1103011102002201,$0100001F00C4FF01,$0001010101010105,$0100000000000000,$0908070605040302,$0010B500C4FF0B0A,$0503040203030102,$017D010000040405,$2112051104000302,$2207615113064131,$2308A19181321471,$24F0D15215C1B142,$17160A0982726233,$29282726251A1918,$3A3938373635342A,$4A49484746454443,$5A59585756555453,$6A69686766656463,$7A79787776757473,$8A89888786858483,$9998979695949392,$A8A7A6A5A4A3A29A,$B7B6B5B4B3B2AAA9,$C6C5C4C3C2BAB9B8,$D5D4D3D2CAC9C8C7,$E3E2E1DAD9D8D7D6
        Data.q $F1EAE9E8E7E6E5E4,$F9F8F7F6F5F4F3F2,$0300011F00C4FFFA,$0101010101010101,$0100000000000001,$0908070605040302,$0011B500C4FF0B0A,$0704030404020102,$0077020100040405,$3121050411030201,$1371610751411206,$A191421408813222,$15F052332309C1B1,$E13424160AD17262,$27261A191817F125,$39383736352A2928,$494847464544433A,$595857565554534A,$696867666564635A,$797877767574736A,$888786858483827A,$9796959493928A89,$A6A5A4A3A29A9998,$B5B4B3B2AAA9A8A7,$C4C3C2BAB9B8B7B6,$D3D2CAC9C8C7C6C5,$E2DAD9D8D7D6D5D4,$EAE9E8E7E6E5E4E3,$F9F8F7F6F5F4F3F2,$0001030C00DAFFFA,$4A003F0011031102,$2A0B29648FB9A228
        Data.q $96D693F124801990,$A5A5064F73885FB8,$83D5C7F239EDBBBD,$46E5F21CC255FA73,$ABEE6673302AEB35,$32646178256D18E2,$FD3A5078CCEEAC46,$AA6AA85FFCD19C6B,$AC71F9324058B564,$301EE4710339B4A9,$0F41E6E23AAE983F,$A82700A9726E2589,$CDF412F850F1FCE9,$4AF2465480A7677B,$03F91114DC094E1D,$FE770F5A4DA3D15D,$AA9444DCB80A3C76,$03FCBF569EB6A2A7,$2AAB5A5B21BED4B7,$3B7164E338C9DB5C,$8EE2939F2B4EFD0C,$367D95B521E51BA1,$8718AF1E5CE79FB2,$ADD743A29243BA57,$27D3760C3F7CC26B,$9FEEA31C2FE72B9D,$23D760D4A7BC8F43,$27E2183DF5ECA0A6,$D114DF69DC99A434,$D18273D535DD1BD4,$9FF8A365D7D0EF3E,$FC73EC137954D54B
        Data.q $1C3F0AAEF5878212,$C3D396B651DF72F8,$EEA4500710405196,$F1553A227F18C43F,$A63F7C40E7C594F1,$8ECD27E6A9725BDC,$30FBD4C973AD23D9,$C02FC5B757884EFC,$D991D7A078DD9EF4,$00FF340C65584EFC,$072821293CDF322A,$BAE915C71FE439FB,$9FD6ADD8AD67AF26,$843E657850CF7828,$9EB10AD1A9A5D955,$0A355214A4A588C6,$14936242269AA228,$C42C558811438A66,$589B2DAFF6243900,$5A9895ADB978154F,$614359EAEDE4935B,$4A07EB277EE93ABF,$F9E49E6D1389D4F0,$A779953F77A08E4B,$3F80D4D388C706C3,$D5290E5ED7FA0336,$3CAC5571469EFB8D,$2DE6D65796C41EE3,$C1A8F5AD02891B52,$4BEBC7F5EB89A427,$6E699BED0FD6D6F0,$FC8CF351C4799614
        Data.q $D14197CE5FF24FAC,$0066DBA84DB7EB42,$B4E278B6D0DDCB5F,$DB83D5F1B5E42CAD,$305458C81D9BA6AA,$CB3875D79CED0D18,$5E85A7FED992329A,$FEDE780F4EA9E470,$16F8E21DC79EA78B,$31AB304894DAC4DB,$C5243EEA7AACF6C0,$43C41F00FFC278E5,$1374DF5295B9827E,$9B97A496EB4AAEF4,$D25D42E8B9243C3D,$6AAF56F7D4D286FC,$CA33DB0D23814D50,$1CBEC2AFAEF4D98E,$FCADA53D6D51BCD3,$20B746E649A45A76,$417F4700F3019CED,$E9D8BB8A9A1246FE,$F0935E1947767251,$6FE02CD42469EE86,$383C293037A1A8F4,$2B428F64D40F5D5E,$18A478276822AECE,$5F350D7F744D2574,$45C04C77691B6FEC,$0FC38D42CFE588E6,$AADCE583BBD5D4C8,$6AB19769BE47D26E
        Data.q $C820C79C5B5D3116,$681A78C755ABF6F6,$E649DBA643FCD5E2,$8F157D42B3DDDB5A,$A3B984D5236BEC4A,$45191284A2A52871,$99DE343EC7335014,$DE62587E304BAB75,$037CE76AFD3FB947,$81184872F49A9672,$57E99F3A3C1985B7,$73AC17C693EF293E,$F847C000FFA00884,$764D75D9F4834FD6,$699A0612C1986308,$C86FE60689B2FC87,$9F76F6739AAE787E,$EFD0FCF6D3C5C763,$8EF1BC677678D6A1,$462B516148D21CA9,$B6F8521CCF01708C,$448C7099D6F1B066,$0707B9706697222C,$D95D631AECD556F9,$D79A2496B3173E6A,$1CE4E6D13613B8CB,$786205524762B9E5,$0571697175D44EE7,$CD5052B92D0403A2,$42E8B51E184776B7,$F1DF3BCD9A1F9E72,$2EB928C610C2093C
        Data.q $44FAF76157BD725B,$C488B80D87F82EBE,$F27DDB9D0A496D93,$C6F0131E14F1AA2B,$69EDCAF67669A8A5,$27E6A3BC87B4E569,$65F8A2067EB093DC,$F757B7C247F8A67F,$720C61D0DD9AA452,$6B8E5832701CA210,$BFA57BB96EF0BC87,$B71217EC8F65EF88,$2C0707162A2F50FA,$78AE8ABCD6E7DC8A,$A0CFE697AE94F28A,$69759C46A86108A1,$F11D5EC377F0B11E,$BD2726ADF55D82C7,$3CDF5552B9477686,$6AFBECF71A8D3FE7,$3C0049AB85264BF2,$A10AB73DE0AE53A4,$3F3C8417BA896FE0,$CDAFA0FD5AA79306,$F238F5DC65D28A24,$2479B34BC7EFE5EA,$AEAC642C4F317A76,$93234012C3384015,$3A5915E3A96C5EED,$12F9E12977362F5A,$75F114FCAC05E79E,$DE9F7C47DB5BA084
        Data.q $3C099F9C35F2C785,$778E14793400E66B,$F1402BFA3A7F5C17,$7C4835211D758B37,$BD34BC9FD8AA613F,$C973F9755C253942,$7EE81ACFE1B715F6,$22E68AD89D055920,$1D11CBE5815B6B56,$7B45192BA6A22943,$DD8F7A180AA15EF0,$A1713F3C0DDFE291,$4AD2B702687F5ED9,$D935F67625275456,$53BCAC2CD4297ED4,$49AAB23684F6CBA8,$D2476E181F6041B9,$B296825A566AD8AB,$FA4860EC3A7086BA,$E6D6A6E2DC84EE8A,$14E5624FE58AE5D0,$A4288A36A4A25594,$6EF62FD828FECB33,$BB31E68E6FB477A1,$86BFB926F17F94D9,$B38FB372F7248DF6,$F3800C368CA408B2,$E75D017CC719A78F,$240ED4AFD049F8C4,$728DC1BF51FCE448,$069D465BD90D00FF,$C2B861445936CBE2
        Data.q $8A81D9D58A8EA79E,$95CA89F3E723ED9C,$739774EADFE83839,$494E2F9CEF870CED,$B2CC144BEDF5381D,$78EAD0C655285734,$A72A7F924C1FC8E9,$912C65E6AD2E6830,$3A7030E841AA2C30,$7CD5D0FEB8BCA575,$5470B930A6CD7CF8,$C35E717B8EF304B1,$6E4BA2A7B27C5697,$B78D2B9B348C6FE6,$8653F1FD219441F7,$6FF877AFF6F81E90,$7C7A76C03F9DCBE1,$1E6E2AF7E9DAD317,$5E6341025C8E61D8,$7626C793BD127345,$1DB06C488D38554C,$B3628DB395BED647,$303D50202A003482,$3E4AA8BC82F8E62B,$2A76B8EA73CBD9CD,$0D8CECA2EA2939B5,$8A15DD89051AC13B,$18DF27C1CD929333,$5FF1219833BE9BAF,$D63A2F8E23D1D289,$3862591E03A8B110,$1C3FCCD75B5F51F7
        Data.q $C8AB51C27FA8377C,$491037347B9537B0,$6E7A2EAB8C85238C,$B34E69653979B507,$1A356DAC3DF495E7,$7EB7C0E33C75956B,$BD648447ADD7B725,$9327DFD2980FD1FE,$F8A2855EE7A723C7,$E2B75EF1221EC473,$7EE5C6922278569D,$06DEB8CC240CE5D9,$16FCDFB57E32E838,$BB34981BE0293C8D,$19734142F58B3743,$709D3E96000FD502,$AD87AFF047AFF53B,$E4B280A5C50E2FF4,$13EFDBB1FE113B13,$6131760CBD627AFE,$0E1B2E47FEDD51D2,$8E077ACDC7DEB6EA,$850FDA376BA8673C,$C72318EEEF49DE52,$1838F6FEB940866A,$5EE43DDAC3676BEE,$B0D1FEE34D4D9E38,$5F96054034DEDB84,$E3AE40F7713CD731,$E3677C0ABF6971C1,$93556BE69200831B,$F4203FB15C0E884A
        Data.q $ED865756D027E300,$CDB518AEAFEE381E,$871F987E8C74BEF4,$4729384595BAC67F,$D9D067ABDA342A66,$6A6FC877342B8AA2,$3FCDE28F19286929,$53B80C88B84547FB,$794B02AFF19ACB8F,$967BB7B74F178907,$4E50B1E01468949C,$4335D7F7BD06A37E,$7F99F8E2EC82A7E1,$302411DEE33F99AC,$83ED73526ED2E8ED,$7455170D0FF1D0F9,$B325B48955583139,$6F1436DC2ACB9CD1,$0AEE86E0F233E22A,$8A2586A2621C18F5,$03CF21C1A676E51D,$E875FD7F80E50F1D,$17CC0D0D7C1500FF,$308CDA364CD2217E,$E43A5065213898B1,$C357799D3F761872,$D578BA8C9DA1B95B,$1DDFE4C99B0BC71C,$8CDCFB088EE13392,$17B5C29CA3EE6A0F,$7275F3B9BA554755,$8EFCE873A9AA5219
        Data.q $617E6D0DBEC100FF,$F11DB1E99124A873,$E8B1550EEE34CAB8,$6780DAA0B2D77B3D,$0080C22800A51838,$531B377E7C2D05E8,$5D1FBBE44FDA5319,$FDE95452C153C181,$49194D12CBA6C4FD,$FA34C865550F5D51,$CC2D619D265FABA7,$78CCEAA8F2C1B680,$8EEC36895C937B00,$686BC15B925AD2C6,$8DDD8F3B04455B36,$26F1524315FEE442,$67A9861AAC5CA68B,$F21B50922370336F,$6BB18E7E7E69D8A6,$EE8FB2792B4FB308,$733CE44AB70FECB1,$C3EE96D34E132DE1,$2649236E798AB64B,$0EF2188E93369909,$39950AA75274CD71,$146F949452A6DE24,$D7E83B6B6F9BF859,$EF077834F2CCAB00,$D6F98100F59354C4,$2DEF1BC9360C1510,$6C6764F96E639224,$0F7BAFA7E289657A
        Data.q $6DB7CCDDA0A6D149,$864C742B5A8A12F7,$DCE17B2B0C144551,$0C89FB30ADEEFA6C,$CF15A13F66397E31,$C9A8C2B9331AEBC8,$5D6BB03F7CDDD53E,$76E678CD4A99CF0B,$15C8F71F8507A807,$82CA5D8B464D98C3,$07783025139F90BC,$E2F3C36C111C905D,$3FBC2F929EE0BBBC,$62AD99E5531E1DE2,$D01FA0741B72C042,$C3679B17DFE8557E,$2B3CFE07C4FA68AD,$827811BFFB2FF895,$E3BF2CE9A711632C,$BFBC461D6C67985C,$D76B9AB8467C8E06,$72BC145FE14F67F2,$17B1960D9D78A247,$6474AC3B62DCD5EE,$1754DAB54E9F846E,$8AE0AE18B1D77696,$54EB87A1C8F0CF78,$2C4F381DB4F85BF5,$3197C9485C9CBD32,$D5CAE715481DA9AF,$7BC11BDBD9ACB81F,$F22CDB5CAB5243CF
        Data.q $D517DE16C27CF2C0,$59A997660A7F80B1,$71C55CA77569B6EA,$AC5B45B6F12AE36E,$FB426D8C462F8BF5,$BFB2946EF6CF5856,$FBBC06F483703E6F,$9BFD777157FCD458,$DC8ADDDA3E2D4BE2,$FC38AC905CEED646,$673D260DE2915EF1,$4ED9DD9EE7D5964C,$41706CE39191A0C9,$B6AC257AE4557E04,$D1FC3D7D73C1B276,$85338B9DB9114D5C,$EA958E0327759491,$7F3D2D7BE584F065,$8A69AE74CDABE7CC,$450991BD96D2415A,$1812598EC8445314,$8E996514519D499A,$690AE2BBF8C11500,$DC20CD2369614320,$9A3A508F54BB4A92,$D56695BB66D3A3E9,$48C4E996F24A59E4,$8DABFCB98FF74F7D,$D4E049BD9BE1ABF8,$6B24D934A68CF834,$55F6AF5E81A00ED4,$9FE563BF27755248
        Data.q $3F7C295489ABD013,$CD6A11FE17F9FBCC,$14B516F19411CFE2,$3ECF13B02C052111,$051480C2F495FE99,$255D3FBF02C00100,$1E7A8A1CAD0E93B7,$8BA7E277F8DA3508,$8B4B567D3B8E24B4,$647A8C12D015E974,$4EC08E3D5F033FF2,$F1E1EF912FA3B9BC,$8BEFE9335FD20A6A,$887A81EB1C7E1991,$C4ADF01F57447E37,$A97DFD2722D53D3E,$185752FE4686EF71,$746FD056931D00FF,$5E3410D7DA487BDD,$EFD30E8E64E4B36D,$E2E969171FE049EF,$475B4A01EDFB0A7D,$4932A67C36FEEE05,$61B53034D688C8F4,$E81FFDD32D29A542,$662F52615542EB15,$E89A52FAD4AF1BBF,$47100C2B038E8CAE,$6B285ED8A969A95A,$D480E4FE8179CB5B,$7971CF36D696B7B7,$0030F22C83C0703C
        Data.q $34DDEAB1D3CA8757,$7FE157FDCBE2D97C,$BAA5EDDDE1E36BC4,$79AC3026C796CCAD,$F818FEEAF59ED307,$A56F29C262DDE1B5,$B0D1392697E1367D,$C61779453060DD7F,$746CDABFBA681ECF,$11DEDCD4E1926700,$AC39B72FEA3E5580,$16E425A39AB7844F,$BD4C9E04C2DB928E,$F495FED8AD7C3C09,$EFA354845C1FF094,$728461E3AAF12CFE,$E342FA087E68A594,$9625AC91B6299AC7,$CF1B17D2483E70F2,$D670CDF70080986F,$C5CA2025CA563C51,$A47EB3C4EC8E90A4,$94C9DF095A2D5BD5,$C31FBC14EBC8BD35,$1C09475513ADF0D7,$AA6A6C67FE5E692B,$4BE970C8EB2E4EC9,$9AA2280ACBAD2848,$F8F17D4551744426,$D0D64B6378AF8959,$613895F61275CB8B,$8085FA863FE2615E
        Data.q $543B07C8F6D37479,$E28AA2F0DFE1C761,$7A6A4D4E55E9E0C4,$324249C3896B7EB9,$C41349C2513D7BBC,$1856C1A9232392EC,$F9EA050BF7E8AD22,$96FD831C5364EABF,$F31545E18F00FFE0,$BD86E313FDD00B1F,$E248F232BD4B9645,$CFC88D191B99589E,$5BDFAAB9EE2515BF,$8407E0A90B352F08,$30579C5214454292,$DEC39BDC27B8C9E9,$12CA2E8FDB35D41D,$AFA95F855BE97D50,$9BE6F020877FF071,$C9D21DF264DE46E4,$F78AA2B0077DBC8F,$C5A75E15143CCCF2,$FD35BCAAAC3A0E71,$F77676D79AFAF8D5,$E4C8769025E6B289,$368FF51DFB510D7D,$1C5C58FE637C3E17,$EE8AA2397ED44DFE,$8C3CA25A5DA585AF,$D726F44AC189651E,$3C43AB63B1B84F97,$E3F9CF5B6B75DAE2
        Data.q $2B7D183DDDBF052F,$2A9534F1E32B8A4A,$9998E5AC1FD911AE,$A260DF3DABD1B0E2,$FFD9FFC876042B8A,$06050406004300DB,$0707060506060405,$09090A0A100A0806,$1417100C0F0E140A,$1D1A161614171818,$16161C231B1A1F25,$2A29272623202C20,$30282D302D1F1929,$4300DBFF28292825,$130A080A07070701,$281A161A28130A0A,$2828282828282828,$2828282828282828,$2828282828282828,$2828282828282828,$2828282828282828,$2828282828282828,$8000081100C0FF28,$1102002201038000,$1F00C4FF01110301,$0101010105010000,$0000000000000101,$0605040302010000,$00C4FF0B0A090807,$02030301020010B5,$0000040405050304,$1104000302017D01
        Data.q $5113064131211205,$9181321471220761,$5215C1B1422308A1,$098272623324F0D1,$26251A191817160A,$373635342A292827,$47464544433A3938,$57565554534A4948,$67666564635A5958,$77767574736A6968,$87868584837A7978,$96959493928A8988,$A5A4A3A29A999897,$B4B3B2AAA9A8A7A6,$C3C2BAB9B8B7B6B5,$D2CAC9C8C7C6C5C4,$DAD9D8D7D6D5D4D3,$E8E7E6E5E4E3E2E1,$F6F5F4F3F2F1EAE9,$1F00C4FFFAF9F8F7,$0101010101030001,$0000000001010101,$0605040302010000,$00C4FF0B0A090807,$04040201020011B5,$0100040405070403,$0411030201007702,$0751411206312105,$1408813222137161,$332309C1B1A19142,$160AD1726215F052,$191817F125E13424
        Data.q $36352A292827261A,$464544433A393837,$565554534A494847,$666564635A595857,$767574736A696867,$858483827A797877,$9493928A89888786,$A3A29A9998979695,$B2AAA9A8A7A6A5A4,$BAB9B8B7B6B5B4B3,$C9C8C7C6C5C4C3C2,$D8D7D6D5D4D3D2CA,$E7E6E5E4E3E2DAD9,$F6F5F4F3F2EAE9E8,$0C00DAFFFAF9F8F7,$0011031102000103,$648FB9A2284A003F,$2CCB20FEE68A0228,$3CC85766A09D193E,$AA76FC8F5800641C,$E4E254938AD8992B,$C2A56FA9B6DA1AFA,$C48F732163CB765E,$8CE79D5CF3FCC39E,$FB62814A8F5D17EE,$93F1B12C23766343,$EE56AE781D742496,$BE914B416BDD6BF6,$5C94F283F14C9426,$CDB53EF31B003F10,$91BD519F785B589D,$5C9007837053864C
        Data.q $9C4663BB66F88332,$AF8DABC153D7E712,$D9F5765676524D5A,$DA9A4BF87FF54C7E,$41966DD2A7D464D9,$0F3D449E9D6926BE,$0DAC48E873E58A96,$598B2D234763E243,$AD3F17199EF8A3CC,$4AA399CE8D3D3E73,$037677B145803CF3,$F6C2CE0A1DACF2A7,$1DA87EB5F0F51D63,$D3CE786700FFD74E,$9D9C2A5A851541EE,$FF34B54EC686D1D9,$B1F8B7BBE33EAD00,$B1BE2E643A179338,$F19D265D83F95748,$8B5BBCCA97B94623,$113FCA4D25827329,$621DBC6178C515FE,$8C52467DB159D72E,$06FE207168E7FBD6,$563A9E73B307C0C1,$639AE9083FE393F6,$C246B827F8E16FCB,$32497942962BC225,$F3D0D707E3EC4830,$5985EB6C31D256CA,$D0D77657B6E89175,$46F1CF788AE76C09
        Data.q $FCA8735EEF5885C1,$247C18AAD5D5F052,$10B8B3B7FC47AF6C,$8AC0E89B5FA88FB2,$126F2ED3467CA1B3,$12977C588D57EED6,$F70112E0BA7F4EA0,$9457D21C4A411F1C,$F2CEB51BBC46746C,$A7825400438A299C,$51D24237533C4590,$9510285A8A360045,$D02249A2D746FCC1,$FFB1D2ACCCD3D8E2,$35A73E80546A9600,$C57DDA69B177EAD9,$F0BD91194111E7E4,$F8AA4D5F30CF573A,$B8CFB3745BEE6EA5,$2A5A2B0ED0A727FE,$57DCD4CEC6E34CF2,$74893FBAEC377554,$DD48B94DD3812CE3,$F023418A4CF7E3B6,$67C27F288D35E76A,$15C2B9E40864843D,$3FAD811F418EB1E9,$AD8AB191E2ED6A88,$C23F2AB8E304BCCD,$2590C387459778AC,$6B4B23714F92ACCD,$09EAC38D23DCCFB9
        Data.q $D256723756A557FA,$9A87351FF907FE2F,$9E6FE3F4FECA698C,$440BC43FB98300FF,$756429E27EF8084F,$FA23630423E6B771,$DF0CA578A6579ED7,$3F8A94E73F39B40A,$F1ACF5D0BCD21F46,$651BF9A5BAA62989,$C52F29E9938C6E72,$6A2C1C69343A2585,$3B6B6A9201008F59,$E708A92C45E49A75,$A2F48AF494ABFD2C,$6DD1544BF8111FBA,$55B84BDBD996BE60,$C838231B05D76E68,$948CD2CED5DE3EE3,$80977B466BDAD095,$B795BCB2163E7635,$9DFE9F6200FF795A,$E3E0B800FF50C6E5,$F14A87EEC0A187D9,$E295A69A0C8400FF,$7313EB9B42480DBF,$3C3F92C5B28D1303,$575FD5011EE895FE,$0CEA74C7C49DB5F0,$C1883FE394DD1352,$3DF5D32769BE6BAE,$5C4A1A3A92EE3C1C
        Data.q $2350144519E84CD1,$1D35BC6D7EC7F883,$57F71FA0DC351CAA,$D6F8D020AFEDFA93,$BB42E87FBAEB7F6C,$C874D416F38D00FF,$F63FCEFCA4894407,$EAB82AC75C58F35A,$8B9767969EDE1AA4,$8DD430FEE8D1E4F7,$3D8D0CC1B192F69D,$5AEDC8831C77398C,$E69E421F5D8E2FBE,$E4C4C4CA054DB7D9,$FA58531F3C47A502,$785A099F0BF58487,$DE28DA6D08DE9299,$DECAF273043249D9,$D7D67B107A60E480,$C7AD39BC6F6D6F8A,$C17CC1CCAC0C98F6,$1F7700FF385EB293,$E2A8BA426B947A95,$791871E62300FFF6,$F57E7D692D42A5E1,$FEEEED2FD4C85CFA,$37496A9FCC0B4314,$8D00FFB0FEF360F9,$44739D9BC36FF054,$BC65DA16E6EED6BB,$7E149061E5DDEA4C,$776BA813E1931523
        Data.q $798E6589B61D5E76,$D8CD4F1D5F40C081,$B4BA8C00FFF49A71,$19DDE09DE6F0125E,$738EA40E3717C981,$C6CB6BF2C40EA090,$BEEC0DA75052A5E2,$921AA11A0C987BE4,$E17533E7FD4DCE96,$FB335D74D74A178D,$20F29222B63AA444,$3E373D63EB3EC418,$22FE3B0F8E833E41,$075D92644B359FFD,$CAD719560EF48653,$EFF32A7F469EED73,$B0E9177FE2CF5805,$19B2DADADB3017EA,$03C929712CC29964,$BEE4F535F5E9A927,$D35993A48D22D02A,$5EEB9F7A3EC928C2,$EEA68A126ABD3256,$9BA8D329947AE8FA,$DDE389BE1ACA879E,$F1DB34D4C4FE4017,$8A4A88188B0C19A5,$E08AC0DF0E60C8DD,$4170100456B14ADD,$5868E18DF8A5B5AF,$5805094E0CA9C6A5,$1D7CE9F4A999FEE4
        Data.q $AE6FD124CBFC39E2,$46707DD246DD9F3A,$26A55E4DA9304769,$C5E74EEE3761E181,$A67D5EA475A73EDA,$468F3C1ABB1C53C6,$D6851FF71AF91104,$59295CDC42785813,$FAE901EA699B7627,$3446F80FF71A7F00,$B822A78DAE911421,$79853FC8205BB621,$49C8D93204AD968E,$849D7A62B467CA92,$187A6BFCC1157F80,$F094C65A495BE2D8,$D252522E77B58CEE,$1E81A228DAB84157,$D7D46DFB494BF16B,$111C63235ADA9C80,$F4CBEBFC85FA3399,$DE152FCD624D8224,$CF65DE2762BECCDC,$42178FF74ACF3D2A,$4DDAF95CEEA967AD,$3AFEC7B5E9FB2FCA,$B8260BCCE18FBC1E,$90A5925134AA33F2,$5BB3F70F7A21C9B8,$F571F2904BEAE2E1,$09CBA2C74E95823D,$CC8D994D6DF2F29A
        Data.q $0A2702F3A5D66CDE,$F420B90014420785,$25C94284A1661C38,$800D526CDB5BACBB,$DAED57F418273870,$80801A83906DF292,$03011DC8A8642A64,$CD3106468E01C368,$CD7BFBE1C351C425,$4A259622AF9DD3CE,$BBDBE1C6E9003036,$A6E59A4608B9D77A,$9EAF3AA9D3F191AC,$9FC6887CFDB76DAB,$4BB5E1A736719B26,$E5A9922A6CE3494D,$6EC771AC8DE0809E,$DFA96D865F552048,$6E2D6CD7BA48DBF8,$EF208AA1DF7F8674,$8C633B1FA8A4D216,$0B45A6BC9556D063,$1220999600FF762F,$FE493D8FF900CE40,$7C5E1A823FBBD211,$3862BCB24C0DE257,$F8DE20ADD02E6084,$2839CDCC2B2AA707,$AB26674FAD887852,$2274DD4DAB4FB552,$F354678DCBC377F1,$BEC9323DE2731FBC
        Data.q $2C287A14615357F4,$09C2D75A59E707AC,$B396FAB7EA0BEFF4,$9DD636C95ADB3373,$F3E3F2E949550CA4,$8F7714DF7215F435,$A52CD2B631227E87,$B32C5F73DAC819CF,$ABCF95ACA226D53A,$58E4536F8B702A78,$A54BA77933BC49B5,$A79126DD56DAB7A5,$088E6EFE59608EB7,$6FE2DF4ABDA2D2C6,$0FE36F73635FFC83,$960DC6B25A68DB0F,$7E0AE56863C4A3AF,$5F0F806337CEDB67,$134D8D80C477BCC6,$4AF9FD47DDDAB693,$E137F8A747F825F7,$5EF1BE86ADB1BECD,$6920E181850D8BB0,$014F3D5566755C07,$46C9333FD1D7FA88,$B7B8209E8A4FC377,$2D6DD87CAED5B3B9,$C6F619C663FBB965,$FA494E8FF9382AB9,$377409E1633C6FD3,$A9BB75BA16F125D4,$8C3016ADAC2D495A
        Data.q $F0874E47CAEC927B,$B2E68000FF7AE815,$8D3A62156D3446F8,$5D5C00FFEDE4B3B5,$15F4F19CFAA09A4F,$AF6BF40F1FCFFEC3,$73694CF1383E6B0F,$3C50D2DE8E97A56B,$65793DB81C5491B7,$AF46276171CD7400,$ADCA9A4E2DC5A934,$8D7A6B070F32293B,$B6B74C5DA779BDDE,$C75E7E37C41DC171,$DC70C6014359E12A,$073CE64ABBD683FB,$9E6093E5F6CA526C,$1701B4FB31C688E0,$DCB2D6D3354100FF,$28A99DD8447EA3EC,$964408E29BA191A2,$F500FF9D8CDDCF05,$D58EE300FFA394CD,$29F1C9FEBB0C1EE2,$CADDBA498447E28A,$AF80F65FC7B32163,$18A90057A94319A0,$A6D03CBEE015F720,$ADFD33029167F1B1,$3FCF8F93581D8B81,$F3C87CCE7E426DAD,$0F3D7B1AB40A0AF3
        Data.q $2948BDAD0CB7BB43,$7B92318EB28B59D5,$6D9A3576D003A3F0,$B0B2CD99760B0AAE,$B103373FA87C10DB,$C6B7AEC871064EE5,$CBA5AD65F0BC1B1E,$1E5769C050FAB7AC,$2EC313E601601264,$FFE54AAF4770C349,$B58205D463EDB400,$B610E24860256AC3,$DC397667207193E7,$0F2F965AAF39CE39,$A6423EB484B48F88,$ED1B94B39786150B,$73D80E3BA4ED7265,$0447C2B6E5F12EB8,$1C8C3C0F7018E830,$5A9863057FE915F5,$3C71693CC51317EB,$810032DF26D36E6F,$6F78670DAE03C751,$B6B075AC941A17C0,$99862BDAE4527CDA,$724E115E76940089,$A231EB35794E7255,$AA308AAA6AA41AC7,$669E395F410F00A3,$5F5D75D4EAC3AA74,$BC19ADAE2CB2E843,$7DCCAF4BF466654D
        Data.q $6C6E2CD4E02CD456,$2752B4F1BC3DD0EE,$84F98A6215C1B0AA,$732B9EABA13EAAED,$AEEDAEADD5634DF0,$CCB91043764BBBE0,$802B0372D5C6846F,$2DDBF40A1C741F00,$78417CD534757912,$02CA6E6C174D2D75,$4C1F801F74143D44,$521656E48DBA5AF3,$27753C631C714EDD,$5AAAF5019CDC03A0,$F6265D7E6071ABA6,$DDB215CA7EB929F3,$2CDB154F7D8CE4D4,$8EE4D31B79AC2266,$6B35D65C4EA58765,$DA9769DFA6497CC5,$D797E81165ED85B7,$01480CB82AA4AB8B,$72809DEBAAF21C83,$C4FB7878D781E476,$8F1A5EEBBABDDA36,$6570793F7265D34D,$23D35344B03ADAB8,$B5D7A0FA6B50E3B7,$A16D6D5882202FB8,$49E5525EBBCC5078,$9393670C36807A3B,$F652A3552960F5F8
        Data.q $65764956722BA2D1,$B5F328120896783B,$94D4FBFA494E0606,$51146DD8CAF58A62,$E3716B6761998240,$1DCF146F734D0E0F,$414E4CDAB92E84CB,$E1B7FA14FEA0421F,$AD1CB5B48CD70DA8,$3F962FDFDE72CBB2,$292D1F6259E967F4,$86E7D363AF26263F,$916149E3191E982B,$8FA01E58E53AB24A,$E28B62D1555FF94A,$E29E766FF8A3AB96,$B9AD8484793BDAFA,$7360C4FC3CE324C8,$FF6944F375D5578C,$75EB3FFBF65A1700,$00FF0071C93E2BDF,$F89F521BCACDABD9,$551FCB259963E45F,$2D2CC61BFED9A3F9,$EC6EAE994B1E6D75,$3749BAED2C4B9C2F,$B12BFDEEFA76B8AA,$D723D51E1EC533AE,$41F5189A145EC413,$91574472D6EA8618,$DB6A7658F791808E,$6CEFF263D487B5D0
        Data.q $80D3F6FBF5DB746E,$EB07F7B8F261147F,$DE45DE7FAEEAF38A,$66DC970FB633F9FB,$7983A981B59414C5,$F80F720CBDBEFA6E,$3D00FF7125EC6997,$52DF10147D54C667,$A6FC85E655BD95BE,$1E63719B1D48475B,$18E30BD71C19AFEF,$FDBBE3BBAE3537AC,$C8B6A2398AC8782F,$C7686BE247723BF6,$926F32ABB7AF34DA,$322DE20B14C477EC,$321EFC5666EDD541,$8DB4B2825823F43F,$35EFD42295F63435,$973217B7B662743B,$D367D083F2832326,$3F3D2CFA5AAD01AE,$85FA4E31F7464D67,$3754B4316C252D25,$AC52F7B4DB595077,$BC8E075C63562F51,$5F36B6427069A96B,$E0CBCF524C905B66,$E3AAFCF7BA9D9D63,$22AEC28896364909,$6775D9AB37A3269D,$B1377CD5D59EFAA2
        Data.q $8437489557EB226F,$1F9C299E00FF1924,$0FF3B54D3F1613F8,$4B5B16CF0BBB7582,$7672E074F9FBABE3,$EBDB3960B0BB2BB9,$6CD4B0BF4817FB8A,$2AB4B8B7B84A9F22,$A7E3F440190C3402,$12548472D2BCBCD2,$62BFAB6A1EAEA9DF,$7266C453ACD07CE5,$A9CD853FEB8A787A,$6723769DE6EBA5AF,$5D105F6B3E26B936,$A200FFAB2C32D0B7,$53FD778D5AA70CAB,$DCAFEDD3F0973946,$2C526C8AA0963ED3,$EC0303AC728A24B1,$AD15E7969EE4D569,$E26743AD2B7CD5F8,$53D762D37D3A4C88,$FC417200FF3C668C,$B2E31CAF07473D2C,$9275604922EE6882,$841E1882D0950127,$B64D9A8A7FB9E21E,$4704B50B6E0DE0B1,$60015DF8C7C6F36C,$5EC0D7F99AFAE547,$D934ED6F8037F137
        Data.q $63CB24D2954DFBA2,$FBB14AE55748813C,$147AC591D3718E84,$5D929E9A4F13ABB0,$5B96CFE8AC939C3B,$3AE929BEE45AEB33,$543BB549ADE0A976,$142416F0BCB036B8,$9DF52E7F04C12990,$43934168CA36F16B,$07876DC41C9F62D7,$24F1255EAAD8EDFD,$8B1B6B0B5BB021BE,$0CEDDCC34D19593B,$0CA41E2B143B08CA,$8D57C2D0C4EBDB93,$A284D449535BBB48,$60A08A0A45CCD4D2,$7D757A6FFA140000,$7B0CA0284A5A0801,$6FCEA97509372B5D,$FEC5B15D16EED72E,$F8C27A9F9CFA76E2,$96046143BC89E191,$378E553BB1E54D5B,$D1D815787D46C6A9,$95A293BDB4F06E5F,$58581FB1CCBAF891,$432F00FF5DF34AA9,$68A7D3BB4E432DE6,$B8AEEA5582E5AD6F,$F3E5D1526B9D74A9
        Data.q $12B43B39ABFBAB74,$4FCDE86B1DD7CF94,$BC851ACC2DD5B34D,$453DF4E9387BC673,$6D9A8F17BE88C779,$7F937FCCB37F6F0A,$359C2B23265EE78F,$1A15F1C0AD8FBC87,$0FFC875F726F8DD6,$E9153FC7F7F050EB,$FC4748F5EDF9529B,$D78FCBFBC7D726FC,$BE573F0DC4C71535,$A52E5A9296F70CF1,$CB02F3A971CCB52D,$DACFC8703CF9C81F,$96CB346FD352EFBC,$639C1D2548DEFA82,$611DAF74AAD6E33E,$CFF49F8D329FD3A9,$FB4CF75A589D75A3,$EEF0E4D03A5EC01B,$766A5016EBA8659F,$B284609EA3790BD1,$AEF10740AEE7B97C,$346FDF940BE6DEEE,$57FA61B8D1E8A172,$976F6DEC6EA69AC2,$7F7094F76F82C097,$5CDDDB670DE2C715,$47F52696E76DB6DB,$534294AFCFABFC2B
        Data.q $2E6186AA73AD8472,$8FC407F6D1AEA444,$8EC595F5F0189E88,$30D6DA75BABE30A5,$7B50F45CF787C51D,$E25DBC94AF769CE7,$BA56EF8E78138F0B,$119D4604874B8E45,$7C9015007D540140,$92FC1EBB73E764C9,$F6EAF2F01D7CD06B,$0D83D63695F5AE48,$EB871D7E92F51FE5,$EA69F9C85B7EF95D,$6786591C5B00FFFB,$FCCF2F3BEB79944E,$1DFE166BD2C2DBCE,$06911CA1368BEED3,$A31B9BBE4A206478,$5AAA9F1E5DE70F7D,$F0FB6462122CB35F,$2356F3547D222BB8,$36880A358E348A44,$00FF5AD50E808EAA,$3A4398F60BBFB44D,$91C3E8D35506D9FD,$379DA284275F435F,$B4DAE282291FF867,$D29DBED13C5EE3A4,$4DB5F2C3EAD44BFD,$FF711B354AA37F38,$FAD9036521A72C00
        Data.q $D54D77357E08FC37,$943B9A8DE3DDAF6D,$8FFA44B6ABBC3D1F,$5C258C7878C5714F,$C33503AE7D44B53B,$E37EDD5ECBE8D563,$FF4FF49C2B8A9242
        Data.b $D9
      EndDataSection
    CompilerCase #PB_Compiler_DLL
      ;DLL.....................................................................
      Global stringmode=#PB_Ascii
      ProcedureDLL AddPopupText(id,x,y,text)
        ProcedureReturn Ribbon::AddPopupText(id,x,y,PeekS(text,-1,stringmode))
      EndProcedure
      ProcedureDLL AddRibbonItem(parent,id,typ,name,image,status)
        ProcedureReturn Ribbon::AddItem(parent,id,typ,PeekS(name,-1,stringmode),image,status)
      EndProcedure
      ProcedureDLL AddRibbonItemStatus(id,status)
        ProcedureReturn Ribbon::AddItemStatus(id,status)
      EndProcedure
      ProcedureDLL CheckRibbonActivity(*act)
        ProcedureReturn Ribbon::RibbonResponder(*act)
      EndProcedure
      ProcedureDLL CloseRibbonPopup()
        ProcedureReturn Ribbon::ClosePopup()
      EndProcedure
      ProcedureDLL CreateRibbon(hwnd,color,backcolor,style,flags)
        ProcedureReturn Ribbon::Create(hwnd,#PB_Any,color,backcolor,style,flags)
      EndProcedure
      ProcedureDLL DeinitializeDLL()
        ProcedureReturn Ribbon::DeinitializeModule()
      EndProcedure
      ProcedureDLL ExportRibbons(filename)
        ProcedureReturn Ribbon::Export(PeekS(filename,-1,stringmode))
      EndProcedure
      ProcedureDLL FlushRibbonActivity()
        ProcedureReturn Ribbon::FlushRibbonActivity()
      EndProcedure
      ProcedureDLL GetActiveRibbonCategory(handle)
        ProcedureReturn Ribbon::GetActiveCategory(handle)
      EndProcedure
      ProcedureDLL GetRibbonHandle(id)
        ProcedureReturn Ribbon::GetRibbonHandle(id)
      EndProcedure
      ProcedureDLL GetRibbonItemCheckStatus(id)
        ProcedureReturn Ribbon::GetItemCheckStatus(id)
      EndProcedure
      ProcedureDLL GetRibbonItemGadget(id)
        ProcedureReturn Ribbon::GetItemGadget(id)
      EndProcedure
      ProcedureDLL GetRibbonItemImage(id)
        Protected image
        image=Ribbon::GetItemImage(id)
        If IsImage(image)
          ProcedureReturn ImageID(image)
        Else
          ProcedureReturn -1
        EndIf
      EndProcedure
      ProcedureDLL GetRibbonItemPosition(id)
        ProcedureReturn Ribbon::GetItemPosition(id)
      EndProcedure
      ProcedureDLL GetRibbonItemStatus(id)
        ProcedureReturn Ribbon::GetItemStatus(id)
      EndProcedure
      ProcedureDLL GetRibbonItemStatusFlag(id,flag)
        ProcedureReturn Ribbon::GetItemStatusFlag(id,flag)
      EndProcedure
      ProcedureDLL GetRibbonItemText(id,text)
        Protected t.s=Ribbon::GetItemText(id)
        ProcedureReturn PokeS(text,t,Len(t),stringmode)
      EndProcedure
      ProcedureDLL GetRibbonItemTextLen(id)
        ProcedureReturn Len(Ribbon::GetItemText(id))
      EndProcedure
      ProcedureDLL GetRibbonItemType(id)
        ProcedureReturn Ribbon::GetItemType(id)
      EndProcedure
      ProcedureDLL GetRibbonMetric(handle,metric)
        ProcedureReturn Ribbon::GetMetric(handle,metric)
      EndProcedure
      ProcedureDLL GetRibbonPopupHandle(id)
        ProcedureReturn Ribbon::GetPopupHandle(id)
      EndProcedure
      ProcedureDLL HideRibbon(handle,status)
        ProcedureReturn Ribbon::Hide(handle,status)
      EndProcedure
      ProcedureDLL LinkRibbonPopup(id,head,x,y)
        ProcedureReturn Ribbon::LinkPopup(id,PeekS(head,-1,stringmode),x,y)
      EndProcedure
      ProcedureDLL MoveControlToRibbonPopup(id,handle,x,y)
        ProcedureReturn Ribbon::MoveControlToPopup(id,handle,x,y)
      EndProcedure
      ProcedureDLL MovePopupText(id,tid,x,y)
        ProcedureReturn Ribbon::MovePopupText(id,tid,x,y)
      EndProcedure
      ProcedureDLL RemovePopupText(id,tid)
        ProcedureReturn Ribbon::RemovePopupText(id,tid)
      EndProcedure
      ProcedureDLL RemoveRibbon(id)
        ProcedureReturn Ribbon::Remove(id)
      EndProcedure
      ProcedureDLL RemoveRibbonItem(id)
        ProcedureReturn Ribbon::RemoveItem(id)
      EndProcedure
      ProcedureDLL RenderRibbon(id)
        ProcedureReturn Ribbon::Render(id,Ribbon::#Ribbon_Render_Force)
      EndProcedure
      ProcedureDLL ResizeRibbonPopup(id,x,y)
        ProcedureReturn Ribbon::ResizePopup(id,x,y)
      EndProcedure
      ProcedureDLL RibbonVersion(type,version)
        Protected v.s
        Select type
          Case 0
            v=Ribbon::RibbonVersion+"-"+Ribbon::RibbonDate+" "+Ribbon::#RibbonGadget_Status
          Case 1
            v=Ribbon::#RibbonGadget_Status
          Case 2
            v=Ribbon::RibbonVersion
          Case 3
            v=Ribbon::RibbonDate
        EndSelect
        ProcedureReturn PokeS(version,v,Len(v),stringmode)
      EndProcedure
      ProcedureDLL SetActiveRibbonCategory(id)
        ProcedureReturn Ribbon::SetActiveCategory(id)
      EndProcedure
      ProcedureDLL SetCallbackMessage(message)
        ProcedureReturn Ribbon::SetCallbackMessage(message)
      EndProcedure
      ProcedureDLL SetPopupHeadline(id,text)
        ProcedureReturn Ribbon::SetPopupHeadline(id,PeekS(text,-1,stringmode))
      EndProcedure
      ProcedureDLL SetPopupText(id,tid,text)
        ProcedureReturn Ribbon::SetPopupText(id,tid,PeekS(text,-1,stringmode))
      EndProcedure
      ProcedureDLL SetPopupTextColor(id,tid,color)
        ProcedureReturn Ribbon::SetPopupTextColor(id,tid,color)
      EndProcedure
      ProcedureDLL SetRibbonFont(handle,font)
        ProcedureReturn Ribbon::SetFont(handle,PeekS(font,-1,stringmode))
      EndProcedure
      ProcedureDLL SetRibbonItemCheckStatus(id,status)
        ProcedureReturn Ribbon::SetItemCheckStatus(id,status)
      EndProcedure
      ProcedureDLL SetRibbonItemImage(id,image)
        ProcedureReturn Ribbon::SetItemImage(id,image)
      EndProcedure
      ProcedureDLL SetRibbonItemPosition(id,position)
        ProcedureReturn Ribbon::SetItemPosition(id,position)
      EndProcedure
      ProcedureDLL SetRibbonItemStatus(id,status)
        ProcedureReturn Ribbon::SetItemStatus(id,status)
      EndProcedure
      ProcedureDLL SetRibbonItemText(id,text)
        ProcedureReturn Ribbon::SetItemText(id,PeekS(text,-1,stringmode))
      EndProcedure
      ProcedureDLL SetRibbonItemToolTip(id,text,header,symbol)
        ProcedureReturn Ribbon::SetItemToolTip(id,PeekS(text,-1,stringmode),PeekS(header,-1,stringmode),symbol)
      EndProcedure
      ProcedureDLL SetRibbonMetric(handle,metric,value)
        ProcedureReturn Ribbon::SetMetric(handle,metric,value)
      EndProcedure
      ProcedureDLL SetRibbonSystemImage(handle,type,image)
        ProcedureReturn Ribbon::SetSystemImage(handle,type,image)
      EndProcedure
      ProcedureDLL SubRibbonItemStatus(id,status)
        ProcedureReturn Ribbon::SubItemStatus(id,status)
      EndProcedure
      ProcedureDLL SetRibbonStringMode(mode)
        stringmode=mode
      EndProcedure
      ProcedureDLL UnlinkRibbonPopup(id)
        ProcedureReturn Ribbon::UnlinkPopup(id)
      EndProcedure
      ; Procedure DetachProcess(Instance)
      ;   MessageRequester("","Process",0)
      ; EndProcedure
      ; Procedure DetachThread(Instance)
      ;   MessageRequester("","Thread",0)
      ; EndProcedure
  CompilerEndSelect
CompilerEndIf

; IDE Options = PureBasic 6.02 LTS (Windows - x64)
; CursorPosition = 4461
; Folding = AAAAAAAAAAAAAAAAAAIAgAeGAQAACAAAAAAAAAAAAAgC+BHAgBwBAAAAAAAAQAAAAAAAAAE-
; Optimizer
; EnableAsm
; EnableXP
; DPIAware
; CPU = 1
; SubSystem = OpenGL
; CompileSourceDirectory
; EnablePurifier
; EnableCompileCount = 17
; EnableBuildCount = 0
; EnableExeConstant