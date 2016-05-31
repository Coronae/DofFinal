#cs ----------------------------------------------------------------------------

 AutoIt Version : 3.3.8.0
 Auteur:         MonNom

 Fonction du Script :
	Modèle de Script AutoIt.

#ce ----------------------------------------------------------------------------

; Début du script - Ajouter votre code ci-dessous.


Func DetectBle()
	FFSetDebugMode($DEBUG_GRAPHIC)
	FFTrace(@lf&"   ** Detection de zone ble "&@lf&"") ; Put this in the different debugging channels (tracer.txt, console...) as set with FFSetDebugMode
	local $ShadeVariation=0
	local $ResBle
	do
		$ResBle = FFNearestPixel ( 0, 0, 0xF5CC12) ; Vielle solution => FFBestSpot(50, 1, 150, 100, 100, 0xF5CC12, $ShadeVariation, 0, 0, 0, 0, true) ; Force un nouveau snapShot à chaque passage (cf DetectBlancNoir pour optimisation simple possible)
		if (Not IsArray($ResBle)) Then $ShadeVariation += 1
	until (IsArray($ResBle) OR $ShadeVariation >250)
	if (IsArray($ResBle)) Then

		MouseMove($ResBle[0], $ResBle[1] + 30) ; +30 car curseur decale, vue que mousemove prend en compte l'ecran total pour les coord alors que FFBestSpot ne prend en compte que dofus pour coord...... C'EST LA MERDE
		MouseClick("left", $ResBle[0], $ResBle[1] + 30)
		sleep(500)
		MouseClick("left", $ResBle[0] + 10, $ResBle[1] + 91)
		local $sMsg = " pixels found (ShadeVariation : "&$ShadeVariation&"): the corresponding spot the closest is in "&$ResBle[0]&","&$ResBle[1];
		FFTrace("   ** "&$sMsg&""&@lf&"")
		;TrayTip("Area found", $sMsg, 2000)

	Else
		local $sMsg = "Pas de ble"
		FFTrace("   ** "&$sMsg&@lf&"")
		;TrayTip("Not found", $sMsg, 2000)
	EndIf
EndFunc
