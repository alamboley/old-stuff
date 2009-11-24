/*
 ============================================================================
 Name        : Algorithmes_Genetiques.c
 Author      : Aymeric & Anne
 Version     :
 Copyright   : 
 Description : Algorithme Génétique
 ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "traitement_liste.h"
#include "individu.h"

int main(void) {

	Individu i=initialiserIT();

	afficherListe(i);

	return EXIT_SUCCESS;
}
