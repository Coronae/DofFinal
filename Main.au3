#cs ----------------------------------------------------------------------------

 AutoIt Version : 3.3.8.0
 Auteur:         MonNom

 Fonction du Script :
	Modèle de Script AutoIt.

#ce ----------------------------------------------------------------------------

; Début du script - Ajouter votre code ci-dessous.

#include "FastFind.au3"
#Include <WinAPI.au3>
#include "Affichage.au3"
#Include "Couleur.au3"
#include "Fauchage.au3"

global const $DEBUG_DEFAULT = 3
global const $DEBUG_GRAPHIC = $DEBUG_DEFAULT + 4
global const $WINDOW_CLASS = "ShockwaveFlash" ; CLASS of the target Window
global const $WINDOW_TITLE = "Dofus" ; TITLE of the target Window
Global $MaRessource = "avoine" ; Determine ressource recherché. Disponible actuellement :  ble orge avoine fer cuivre ATTENTTION  TOUT MINUSCULE



FFSetDebugMode($DEBUG_GRAPHIC) 	 ; Enable advanced (graphical) debug mode, so you will have traces + graphical feedback
FFSetDefaultSnapShot(0)

;-------------------------------------------------------------------------------
;                           Raccourcis claviers
;-------------------------------------------------------------------------------

HotKeySet("{ESC}", "Bye") ; On assigne la fonction Bye (Pour quitter) à la touche 'Echap'


;-------------------------------------------------------------------------------
;                               Ouvre Dofus
;-------------------------------------------------------------------------------

SelectWindow() ; Lance Dofus

fauchage()







Func Bye()
	Exit 0
EndFunc   ;==>Bye


