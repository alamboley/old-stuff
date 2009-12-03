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
/*#include "traitement_liste.h"
#include "individu.h"*/

#define longIndiv 8

typedef unsigned char Bit;

typedef struct Element { Bit valeur;
						struct Element *suivant;
						} element;

typedef element *Individu;

Individu initialiserIT();
void afficherListe(Individu indiv);
Individu insererEnQueue(Individu indiv, Bit v);

int main(void) {
	Individu indiv;
	indiv=initialiserIT();
	afficherListe(indiv);
	return EXIT_SUCCESS;
}

Individu initialiserIT() {
	int i, j;
	Bit toto;
	Individu indiv;
	srand(time(NULL)); //On démarre un timer pour la fonction rand.
	for (i=0; i<longIndiv; i++) {
		j=rand()%2;
		toto=j;
		insererEnQueue(indiv, toto);
	}
	return indiv;
}

void afficherListe(Individu indiv) {

	Individu tmp;
	tmp=indiv;
	while(tmp!=NULL) {
		printf("%c \n", tmp->valeur);
		tmp=tmp->suivant;
	}
}

Individu insererEnQueue(Individu indiv, Bit v) {

	printf("ma valeur : %c",v);

	Individu tmp,p;
	tmp=(element*)malloc(sizeof(element));
	tmp->valeur=v;
	tmp->suivant=NULL;

	if (indiv==NULL) {
		indiv=tmp;
	} else {
			p=indiv;
			while (p->suivant!=NULL) {
					p=p->suivant;
			}
			p->suivant=tmp;
	}
	return indiv;
}
