#cs ----------------------------------------------------------------------------

 AutoIt Version : 3.3.8.0
 Auteur:         MonNom

 Fonction du Script :
	Modèle de Script AutoIt.

#ce ----------------------------------------------------------------------------

; Début du script - Ajouter votre code ci-dessous.



;-------------------------------------------------------------------------------
;                               Ouvre Dofus
;-------------------------------------------------------------------------------
Func SelectWindow()
	FFTrace(@lf&"   ** SelectWindow"&@lf&"") ; Put this in the different debugging channels as set with FFSetDebugMode
	local $hWnd = WinActivate("[CLASS:"&$WINDOW_CLASS&"; TITLE:"&$WINDOW_TITLE&"]", "") ; We try to find and activate the proper windows
	if $hWnd="" Then
		$hWnd = WinGetHandle("[ACTIVE]", "") ; If the proper set window can't be found, we use the current active window
		MsgBox(0,"Erreur fenetre","Fenetre dofus non trouve")
	EndIf
	WinSetOnTop ( $hWnd, "", 1)

	FFSetDebugMode($DEBUG_DEFAULT)
	FFSetWnd($hWnd)
	FFSnapShot()
	TrayTip("Select Window","Title of the Window: "&WinGetTitle($hWnd)&" Class:"&_WinAPI_GetClassName($hWnd), 2000)
	FFTrace("   ** SelectWindow => Title of the Window: "&WinGetTitle($hWnd)&" Class:"&_WinAPI_GetClassName($hWnd)&@lf) ; Put this in the different debugging channels as set with FFSetDebugMode
EndFunc