/*
 * individu.c
 *
 *  Created on: 24 nov. 2009
 *      Author: Aymeric
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "individu.h"
#include "traitement_liste.h"

Individu initialiserIT() {
	int i;
	Individu indiv;
	srand(time(NULL)); //On démarre un timer pour la fonction rand.
	for (i=0; i<longIndiv; i++) {
		insererEnQueue(indiv, rand()%2);
	}
	return indiv;
}
