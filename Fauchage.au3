#cs ----------------------------------------------------------------------------

 AutoIt Version : 3.3.8.0
 Auteur:         MonNom

 Fonction du Script :
	Mod�le de Script AutoIt.

#ce ----------------------------------------------------------------------------

; D�but du script - Ajouter votre code ci-dessous.


Func Fauchage()

	DetectRessource()
	Sleep(13000)  ;Temporaire, en attendant une meilleure solution
	Verif()



EndFunc   ;==>Fauchage




Func Verif()

	VerifNiveau() ; Fonction qui verifie si LVL UP => bouton OK rouge au centre de l'ecran

	fauchage()

EndFunc
