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
int valeur_tete(liste l);
liste reste(liste l);
int contenir(liste l, int v);
int nbrElementsListe(liste l);
liste triABulles(liste l);
liste fusion2listes(liste l1, liste l2);

#endif /* TRAITEMENT_LISTE_H_ */
