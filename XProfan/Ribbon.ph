'PH für Ribbon.dll
'Version 0.3.67
'von Jac de Lad
'21.10.2021

Ribbon_SystemIcon_Checked48   =  1;
Ribbon_SystemIcon_Unchecked48 =  2;
Ribbon_SystemIcon_Inbetween48 =  3;
Ribbon_SystemIcon_Checked16   =  4;
Ribbon_SystemIcon_Unchecked16 =  5;
Ribbon_SystemIcon_Inbetween16 =  6;
Ribbon_SystemIcon_Checked     =  7;'Alle Größen checked setzen
Ribbon_SystemIcon_Unchecked   =  8;'Alle Größen unchecked setzen
Ribbon_SystemIcon_Inbetween   =  9;'Alle Größen inbetween setzen
Ribbon_SystemIcon_Checked16   = 10;
Ribbon_SystemIcon_Unchecked16 = 11;

Ribbon_Color_Auto  = -1;'Für CreateRibbon(parent,COLOR,style), als Farbwert (entspricht GetSysColor(CLR_BTNFACE))
Ribbon_Color_Error = -2;'Fehlerhafte Farbabfrage

'Rückgabeevents, abrufbar mit CheckRibbonActivity(ribbon#), enthalten in ribbon#.event&
Ribbon_Event_None             = 0;
Ribbon_Event_LeftClick        = 1;
Ribbon_Event_RightClick       = 2;
Ribbon_Event_LeftDoubleClick  = 3;
Ribbon_Event_RightDoubleClick = 4;
Ribbon_Event_Hover            = 5;
Ribbon_Event_PopupOpen        = 6;
Ribbon_Event_PopupClose       = 7;

Ribbon_Flag_Autosize                  =   1;'Größe passt sich automatisch an das Fenster an
Ribbon_Flag_Collapsible               =   2;'Zusammenklappbar
Ribbon_Flag_HoverEvents               =   4;'Hovern erzeugt ein Event
Ribbon_Flag_FullHover                 =   8;'Hovern erzeugt nicht nur einen Rahmen sondern hebt das ganze Element hervor
Ribbon_Flag_UseOriginalCheckboxImages =  16;'Nicht in der DLL verwendet!
Ribbon_Flag_DiscardImages             =  32;'Übergebene Bilder löschen
Ribbon_flag_GadgetAutoWidth           =  64;'Combobxen passen ihre Größe automatisch an

Ribbon_Image_None = -1;'Wenn ein Ribbon-Element kein Icon haben soll oder sowieso keins besitzt (Category/Group/Checkbox/Separator/RightHeadText/HeadSeparator/RightHeadSeparator/Container/ButtonContainer)

Ribbon_Metric_Collapsed   = 1;'Ermittelt ob Ribbon zusammengeklappt ist
Ribbon_Metric_Roundness   = 2;'Ermittelt die Stärke der Rundung der Items (0..12)
Ribbon_Metric_UpdateMode  = 3;'Ermittelt den Updatemodus (ob das Ribbon gezeichnet wird oder nicht) 0=aktiv,1=inaktiv
Ribbon_Metric_Color       = 4;'Ermittelt die aktuell eingestellte Farbe im RGB-Format
Ribbon_Metric_Style       = 5;'Ermittelt den aktuell einstellten Style (siehe Ribbon_Style_xxx)
Ribbon_Metric_Disabled    = 6;'das Ribbon nimmt keine Eingaben entgegen und gibt auch nichts aus (entspricht "EnableWindow ribbon&,0")
Ribbon_Metric_ScrollPitch = 7;'Scrollweite, wenn das Fenster nicht breit genug ist
Ribbon_Metric_BackColor   = 8;'Ermittelt die aktuell eingestellte Hintergrundfarbe im RGB-Format

'Metric-Standardwerte
Ribbon_Metric_StandardScrollPitch = 64;'Standard-Scrollweite

'Neuzeichnen erzwingen, für RenderRibbon(force)
Ribbon_Render_NoForce = 0;
Ribbon_Render_Force   = 1;

'Ribbon Anzeigen oder nicht (oder umschalten), für HideRibbon(id,SHOW)
Ribbon_Show_Alternate = -1;
Ribbon_Show_Show      =  0;
Ribbon_Show_Hide      =  1;

'Status einzelner Ribbon-ELemente:
'Zu verwenden bei AddRibbonItem(parent,id,type,text,icon,STATUS), SetRibbonItemStatus(id,STATUS), AddRibbonItemStatus(id,STATUS), SubRibbonItemStatus(id,STATUS) oder als Rückgabewert von GetRibbonItemStatus(id)
Ribbon_Status_Standard         = 0;'Normal
Ribbon_Status_Deactivated      = 1;'Deaktiviert (Jedes Element kann deaktiviert werden, alle Subelemente werden mit deaktiviert)
Ribbon_Status_Checked          = 2;'Haken bei Checkboxen/RadioButtons, Aktivierung bei PushButtons
Ribbon_Status_Hidden           = 4;'Versteckt. Alle anderen Elemente werden automatisch neu positioniert!
Ribbon_Status_UseOriginalImage = 8;'Nur für PureBasic und nicht in der DLL verwendet!

Ribbon_Style_NoChange = -1;
'Art der Textanzeige des Ribbons
'Zu verwenden bei CreateRibbon(parent,color,STYLE)
Ribbon_Style_Auto  = 0;'Entweder Light oder Dark, je nachdem wie dunkel das Ribbon ist
Ribbon_Style_White = 1;'Weißer Text
Ribbon_Style_Black = 2;'Schwarzer Text
Ribbon_Style_Dark  = 3;'Text dunkler als das Ribbon
Ribbon_Style_Light = 4;'Text heller als das Ribbon

'Reservierte System-IDs. Für die Rückgabe der Ribbon-IDs
Ribbon_SystemID_Collapser = -1;'Pfeil am rechten, oberen Bildschirmrand
Ribbon_SystemID_Sidebar   = -2;'ID des Steuerelements zum Ein-/Ausklappen der Sidebar (noch ohne Funktion)

'Zu verwenden bei AddRibbonItem(parent,id,TYPE,text,icon,status) oder als Rückgabewert von GetRibbonItemType(id)
Ribbon_Type_None                    = 0;
Ribbon_Type_Category                = 1;
Ribbon_Type_Group                   = 2;
Ribbon_Type_Container               = 3;
Ribbon_Type_ButtonContainer         = 4;
Ribbon_Type_Separator               = 5;
Ribbon_Type_Button                  = 6;
Ribbon_Type_PushButton              = 7;
Ribbon_Type_Checkbox                = 8;
Ribbon_Type_HeadSeparator           = 9;
Ribbon_Type_HeadButton              = 10;
Ribbon_Type_HeadPushButton          = 11;
Ribbon_Type_RightHeadSeparator      = 12;
Ribbon_Type_RightHeadButton         = 13;
Ribbon_Type_RightHeadPushButton     = 14;
Ribbon_Type_RightHeadText           = 15;
Ribbon_Type_RightHeadTextButton     = 16;
Ribbon_Type_Image                   = 17;
Ribbon_Type_ImageButton             = 18;
Ribbon_Type_HeadImage               = 19;
Ribbon_Type_HeadImageButton         = 20;
Ribbon_Type_RightHeadImage          = 21;
Ribbon_Type_RightHeadImageButton    = 22;
Ribbon_Type_RadioButton             = 23;
Ribbon_Type_Combobox                = 24;
'Folgende Hierarchie ist einzuhalten, wobei die Erstellreihenfolge die Reihenfolge der Steuerelemente bestimmt:
'Ribbon
'  |->Category
'  |   |->Group
'  |       |->Button/PushButton/Checkbox/Separator (Icongröße: 48*48), Image (Höhe 70)/ImageButton(Höhe 68)
'  |       |->Container
'  |       |     |->Button/PushButton/Checkbox/RadioButton/Combobox (max. 3 pro Container, Icongröße: 16*16)
'  |       |->ButtonContainer
'  |             |->Button/PushButton/Separator (Icongröße: 24*24)
'  |->HeadButton/HeadPushButton/HeadSeparator (Icongröße: 16*16)/HeadImage/HeadImageButton (Höhe 18)
'  |->RightHeadButton/RightHeadPushButton/RightHeadSeparator/RightHeadTextButton/RightHeadText (Icongröße: 16*16)/RightHeadImage/RightHeadImageButton (Höhe 18)

'Versionsinformationen ermitteln:
Ribbon_Version_Full    = 0;'Kompletter Versionsstring
Ribbon_Version_Status  = 1;'Status (Alpha, Beta, Release...)
Ribbon_Version_Version = 2;'Versionsstring
Ribbon_Version_Date    = 3;'Compilierdatum

Ribbon_StandardMessage = 10000;'Standardmessage
