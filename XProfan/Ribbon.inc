'Inc für Ribbon.dll
'Version 0.3.67
'von Jac de Lad
'21.10.2021

Struct RibbonEvent=Ribbon&,event&,id&,controlx&,controly&,controldx&,controldy&,mousex&,mousey&

Def AddPopupText(4)             !"Ribbon.dll","AddPopupText"
Def AddRibbonItem(6)            !"Ribbon.dll","AddRibbonItem"
Def AddRibbonItemStatus(2)      !"Ribbon.dll","AddRibbonItemStatus"
Def CheckRibbonActivity(1)      !"Ribbon.dll","CheckRibbonActivity"
Def CloseRibbonPopup(0)         !"Ribbon.dll","CloseRibbonPopup"
Def CreateRibbon(5)             !"Ribbon.dll","CreateRibbon"
Def DeinitializeDLL(0)      		!"Ribbon.dll","DeinitializeDLL"
Def FlushRibbonActivity(0)      !"Ribbon.dll","FlushRibbonActivity"
Def GetActiveRibbonCategory(1)  !"Ribbon.dll","GetActiveRibbonCategory"
Def GetRibbonHandle(1)          !"Ribbon.dll","GetRibbonHandle"
Def GetRibbonItemCheckStatus(1) !"Ribbon.dll","GetRibbonItemCheckStatus"
Def GetRibbonItemGadget(1)      !"Ribbon.dll","GetRibbonItemGadget"
Def GetRibbonItemImage(1)       !"Ribbon.dll","GetRibbonItemImage"
Def GetRibbonItemPosition(1)    !"Ribbon.dll","GetRibbonItemPosition"
Def GetRibbonItemStatus(1)      !"Ribbon.dll","GetRibbonItemStatus"
Def GetRibbonItemStatusFlag(2)  !"Ribbon.dll","GetRibbonItemStatusFlag"
Def GetRibbonItemText(2)        !"Ribbon.dll","GetRibbonItemText"
Def GetRibbonItemType(1)        !"Ribbon.dll","GetRibbonItemType"
Def GetRibbonMetric(2)          !"Ribbon.dll","GetRibbonMetric"
Def GetRibbonPopupHandle(1)     !"Ribbon.dll","GetRibbonPopupHandle"
Def HideRibbon(2)               !"Ribbon.dll","HideRibbon"
Def LinkRibbonPopup(4)          !"Ribbon.dll","LinkRibbonPopup"
Def MoveControlToRibbonPopup(4) !"Ribbon.dll","MoveControlToRibbonPopup"
Def MovePopupText(4)            !"Ribbon.dll","MovePopupText"
Def RemovePopupText(2)          !"Ribbon.dll","RemovePopupText"
Def RemoveRibbon(1)             !"Ribbon.dll","RemoveRibbon"
Def RemoveRibbonItem(1)         !"Ribbon.dll","RemoveRibbonItem"
Def RenderRibbon(1)             !"Ribbon.dll","RenderRibbon"
Def ResizeRibbonPopup(3)        !"Ribbon.dll","ResizeRibbonPopup"
Def RibbonVersion(2)            !"Ribbon.dll","RibbonVersion"
Def SetActiveRibbonCategory(1)  !"Ribbon.dll","ActivateRibbonCategory"
Def SetCallbackMessage(1)       !"Ribbon.dll","SetCallbackMessage"
Def SetPopupHeadline(3)  	      !"Ribbon.dll","SetPopupHeadline"
Def SetPopupText(3)      	      !"Ribbon.dll","SetPopupText"
Def SetPopupTextColor(3)	      !"Ribbon.dll","SetPopupTextColor"
Def SetRibbonFont(2)            !"Ribbon.dll","SetRibbonFont"
Def SetRibbonItemCheckStatus(2) !"Ribbon.dll","SetRibbonItemCheckStatus"
Def SetRibbonItemImage(2)       !"Ribbon.dll","SetRibbonItemImage"
Def SetRibbonItemPosition(2)    !"Ribbon.dll","SetRibbonItemPosition"
Def SetRibbonItemStatus(2)      !"Ribbon.dll","SetRibbonItemStatus"
Def SetRibbonItemText(2)        !"Ribbon.dll","SetRibbonItemText"
Def SetRibbonMetric(3)          !"Ribbon.dll","SetRibbonMetric"
Def SetRibbonSystemImage(3)     !"Ribbon.dll","SetRibbonCheckboxImage"
Def SubRibbonItemStatus(2)      !"Ribbon.dll","SubRibbonItemStatus"
Def UnlinkRibbonPopup(1)        !"Ribbon.dll","UnlinkRibbonPopup"

subproc Create.Ribbon
Parameters hwnd&,color&,backcolor&,style&,flags&
Return CreateRibbon(hwnd&,color&,backcolor&,style&,flags&)
endproc
