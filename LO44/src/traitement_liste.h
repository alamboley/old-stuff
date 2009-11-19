/*
 * essai.h
 *
 *  Created on: 19 nov. 2009
 *      Author: Aymeric
 */

#ifndef TRAITEMENT_LISTE_H_
#define TRAITEMENT_LISTE_H_

#include <stdio.h>
#include <stdlib.h>

typedef struct elem { int valeur;
			struct elem *suivant;
			} element;
typedef element *liste;

//Variables :

liste l;
int v;

//Fonctions :

void afficherListe(liste l);
int estVide(liste l);
liste insererEnTete(liste l, int v);
liste insererEnQueue(liste l,int v);
liste supprimerTete(liste l);
liste supprimerQueue(liste l);

#endif /* TRAITEMENT_LISTE_H_ */
