/*
 * Auteurs : Aymeric Lamboley & Anne Lassabe
 */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <string.h>

#include "type.h"
#include "algorithme.h"
#include "traitement.h"

int main(int argc, char* argv[])
{
	srand(time(NULL));
	
	//Affectation des valeurs par défaut aux paramètres du projet
	longIndiv = 8;
	pCroise = 0.5;
	taillePop = nombreAleatoire(20, 200);
	tSelect = (float) nombreAleatoire(10, 90) / 100;
	nGen = nombreAleatoire(20, 200);
	fonctionQualite = 1;
	
	//Si une fonction de qualité (f1, f2 ou f3) a été passée en argument,
	//on affecte les valeurs correspondantes aux paramètres :
	//taille d'un individu et fonction de qualité à utiliser
	if (argc == 2) {
		if (strcmp("f2", argv[1]) == 0) {
			fonctionQualite = 2;
			longIndiv = 16;
		} else if (strcmp("f3", argv[1]) == 0) {
			fonctionQualite = 3;
			longIndiv = 32;
		}
	}
	
	//Début du jeu d'essai
	Population maPop = NULL;
	maPop = initialiserPop();

	int i;
	for (i = 0; i < nGen; i++) {
		maPop = croiserPop(maPop);
		maPop = quicksort(maPop);
		maPop = selection(maPop);
	}

	printf("Meilleur individu dans une population de %d après %d générations :\n", taillePop, nGen);
	afficherListe(maPop->valeur);
	printf("Sa qualité vaut %f\n", qualite_tete(maPop));
	
	//Fin du jeu d'essai
	
	return EXIT_SUCCESS;
}
