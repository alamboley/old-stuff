/*
 * Auteurs : Anne Lassabe & Aymeric Lamboley
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
	
	//Affectation des valeurs par defaut aux parametres du projet
	longIndiv = 8;
	pCroise = 0.5;
	taillePop = 20;//nombreAleatoire(20, 200);
	tSelect = (float) nombreAleatoire(10, 90) / 100;
	nGen = 20;//nombreAleatoire(20, 200);
	fonctionQualite = 1;
	
	//Si une fonction de qualite (f1, f2 ou f3) a ete passee en argument,
	//on affecte les valeurs correspondantes aux parametres :
	//taille d'un individu et fonction de qualite a utiliser
	if (argc == 2) {
		if (strcmp("f2", argv[1]) == 0) {
			fonctionQualite = 2;
			longIndiv = 16;
		} else if (strcmp("f3", argv[1]) == 0) {
			fonctionQualite = 3;
			longIndiv = 32;
		}
	}
	
	//Debut du jeu d'essai

	Population maPop = NULL;
	maPop = initialiserPop();
	printf("Population avant croisement :\n");
	afficher_qualitePop(maPop);

	int i;
	for (i = 0; i < nGen; i++) {
		maPop = croiserPop(maPop);
		printf("Génération n°%d : population croisée :\n", i+1);
		afficher_qualitePop(maPop);
		maPop = quicksort(maPop);
		printf("Population triée :\n");
		afficher_qualitePop(maPop);
		maPop = selection(maPop);
		printf("Population sélectionnée :\n");
		afficher_qualitePop(maPop);
	}
	printf("Taux de selection : %f ; probabilite de croisement : %f\n", tSelect, pCroise);
	printf("Meilleur individu dans une population de %d apres %d generations :\n", taillePop, nGen);
	afficherListe(maPop->valeur);
	printf("Sa qualite vaut %f\n", qualite_tete(maPop));
	
	
	//Fin du jeu d'essai
	
	return EXIT_SUCCESS;
}
