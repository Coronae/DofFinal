#cs ----------------------------------------------------------------------------

 AutoIt Version : 3.3.8.0
 Auteur:         MonNom

 Fonction du Script :
	Modèle de Script AutoIt.

#ce ----------------------------------------------------------------------------

; Début du script - Ajouter votre code ci-dessous.

Global $SurbriCouleur = "A3AE32" ; useless pour le moment, voir commentaire fonction DetectSurbri($Coord)


Func DetectRessource()

	FFSetDebugMode($DEBUG_GRAPHIC)


	local $ShadeVariation=0 ; Variable de Variation de couleur
	local $Coord ; Recupere coordonne du pixel trouve sous forme $Coord[0], $Coord[1]
	Local $Ressource

	$Ressource = GetColor($MaRessource)

	FFTrace(@lf&"   ** Detection de zone " &$MaRessource &@lf&"") ; Put this in the different debugging channels (tracer.txt, console...) as set with FFSetDebugMode


	do
		$Coord = FFNearestPixel ( 0, 0, $Ressource) ;  Recherche la couleur de la ressource, stock dans $Coord[0], $Coord[1]
		if (Not IsArray($Coord)) Then $ShadeVariation += 1 ; Si pas de couleur trouve, on augmente la Variation

	until (IsArray($Coord) OR $ShadeVariation >250)  ;Boucle tant que couleur trouve ou Variation > 250


	if (IsArray($Coord)) Then  ; Si couleur trouve faire

		CliqueRessource($Coord, $ShadeVariation) ;Fonction qui check et clique ressource

	Else

		;////////////////: DEBUG //////////////////////////

		local $sMsg = "Pas de ble"
		FFTrace("   ** "&$sMsg&@lf&"")
		;TrayTip("Not found", $sMsg, 2000)

		;////////////////: DEBUG //////////////////////////
	EndIf
EndFunc





;Fonction qui check et clique ressource
Func CliqueRessource($Coord, $ShadeVariation)

		MouseMove($Coord[0], $Coord[1] + 40) ; +40 car curseur decale, vue que mousemove prend en compte l'ecran total pour les coord alors que FFBestSpot ne prend en compte que dofus pour coord...... C'EST LA MERDE
		;DetectSurbri($Coord)
		MouseClick("left", $Coord[0], $Coord[1] + 40) ; clique sur ressource

		sleep(500)

		MouseMove($Coord[0] + 10, $Coord[1] + 91) ; Deplace la souris où est suppose être l'action ( i.e faucher, miner couper etc)
		DetectRougeAction ($Coord)
		MouseClick("left", $Coord[0] + 10, $Coord[1] + 91)

			;////////////////: DEBUG //////////////////////////
		local $sMsg = " pixels found (ShadeVariation : "&$ShadeVariation&"): the corresponding spot the closest is in "&$Coord[0]&","&$Coord[1];
		FFTrace("   ** "&$sMsg&""&@lf&"")
		TrayTip("Area found", $sMsg, 2000)
			;//////////////// /DEBUG //////////////////////////

EndFunc


;Fonction qui permet d'attribuer dynamiquement les codes couleurs des ressources, MaRessource ce configure dans le Main (variable global).
;Temporaire, le temps de creer la petite boite qui demandera à chaque lancement la roussource voulu.

Func GetColor ($MaRessource)

	;RAPPEL COULEUR:

	;FERMIER
	;Couleur du ble 0xF5CC12
	;Couleur Orge 0x546800
	;Couleur Avoine 0xC76E00

	;MINEUR
	;Couleur Fer 0xE3E2D1
	;Couleur Cuivre 0xD38440


	;RAPPEL SURBRILLANCE:
	; ble surbrillance E2C95A
	; orge surbrillance 8CD342
	; avoine surbrillance C89500
	; fer surbrillance BCBBB2

	Switch $MaRessource
		Case "orge"

			$SurbriCouleur = "8CD342"
			return 0x546800

		Case "ble"

			$SurbriCouleur = "E2C95A"
			return 0xF5CC12

		Case "avoine"

			$SurbriCouleur = "C89500"
			return 0xC76E00

		Case "fer"
			$SurbriCouleur = "BCBBB2"
			return 0xE3E2D1

		Case "cuivre"

			$SurbriCouleur = "BCBBB2" ; TODO surbri cuivre
			return 0xD38440


		Case Else
			MsgBox(0, "ErreurGetColor", "$Couleur est inconnu")
			Exit 0

	EndSwitch

EndFunc



;Fonction qui verifie si la couleur de la ressource en surbrillance correspond a ce qui est attendu
;NE FONCTIONE PAS CORRECTEMENT car c'est la merde pour trouver le bon code couleur, autre solution à tester, checker si difference dans cette zone avec le snapshot
Func DetectSurbri($Coord)

	$Color = PixelGetColor($Coord[0], $Coord[1]) ; On récupère la couleur sous la souris.
	Hex($Color, 6) ; On la convertie en Hexadécimal
	if $Color = $SurbriCouleur Then MsgBox(0,"trouve","Surbri trouve !") ;Me sert de debug pour savoir si j'ai la bonne couleur X)
	If Not $Color = $SurbriCouleur Then Verif() ;Si la couleur sous le curseur n'est pas celle d'une ressource en surbrillance, on lance la fonction Verif().

EndFunc



;Fonction qui verifie si la couleur est celle du "Rouge Action" ( i.e faucher, miner couper etc)
Func DetectRougeAction ($Coord)

	$Color = PixelGetColor($Coord[0], $Coord[1]) ; On récupère la couleur sous la souris.
	Hex($Color, 6) ; On la convertie en Hexadécimal
	If Not $Color = $SurbriCouleur Then Verif() ;Si la couleur sous le curseur n'est pas celle d'une ressource en surbrillance, on lance la fonction Verif().

EndFunc


; Fonction qui verifie si LVL UP => bouton OK rouge au centre de l'ecran
;TODO BON FONCTIONNEMENT A VERIFIER, Testé à "blanc" en regardant où la souris se positionné mais necessite un vrai test...
Func VerifNiveau()

	$size = WinGetClientSize("[active]") ;On recupere la taille de la fenetre dofus
	$niveau = PixelGetColor($size[0], $size[1]) ; Récupère la couleur  où se trouve le bouton Ok lors d'un message de passage à un niveau supérieur.
	$niveau = Hex($niveau, 6)

	If $niveau = 'FF6100' Then   ; On teste si le bouton Ok de passage à niveau est présent, si c'est la cas, on lance la fonction Niveau().
		MouseClick("", $size[0]/2, $size[1]/2) ; On clique sur Ok et on relance la fonction Verif() au cas ou... Si tout vas bien, Verif() relancera la fonction Fauchage() qui relancera la fonction Verif etc.
		Verif()
	EndIf



EndFunc
