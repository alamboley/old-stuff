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
#include "individu.h"

//Variables :

Individu l;
int v;

//Fonctions :

void afficherListe(Individu l);
int estVide(Individu l);
Individu insererEnTete(Individu l, Bit v);
Individu insererEnQueue(Individu l,Bit v);
Individu supprimerTete(Individu l);
Individu supprimerQueue(Individu l);
int valeur_tete(Individu l);
Individu reste(Individu l);
int contenir(Individu l, Bit v);
int nbrElementsIndividu(Individu l);
Individu triABulles(Individu l);
Individu fusion2Individus(Individu l1, Individu l2);

#endif /* TRAITEMENT_Individu_H_ */
