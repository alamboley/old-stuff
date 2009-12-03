/*
 ============================================================================
 Name        : Algorithmes_Genetiques.c
 Author      : Aymeric & Anne
 Version     :
 Copyright   : 
 Description : Algorithme Genetique
 ============================================================================
 */

#include <math.h>
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
Individu initialiserRE(Individu indiv, int l);
void afficherListe(Individu indiv);
Individu insererEnQueue(Individu indiv, Bit v);
int decoder(Individu indiv);

int main(void) {
	Individu indiv;
	srand(time(NULL)); //On demarre un timer pour la fonction rand.
	//indiv=initialiserIT();
	indiv=initialiserRE(indiv, longIndiv);
	afficherListe(indiv);

	int valeurIndiv;
	valeurIndiv=decoder(indiv);
	printf("L'individu vaut : %d \n", valeurIndiv);
	return EXIT_SUCCESS;
}

Individu initialiserIT() {
	int i;
	Bit j;
	Individu indiv;

	for (i=0; i<longIndiv; i++) {
		j=rand()%2;
		indiv=insererEnQueue(indiv, j);
	}
	return indiv;
}

Individu initialiserRE(Individu indiv, int l) {
	Bit j;
	j=rand()%2;
	if (l==1) {
		indiv=insererEnQueue(indiv, j);
	} else {
		indiv=insererEnQueue(indiv, j);
		indiv=initialiserRE(indiv, l-1);
	}
	return indiv;
}

void afficherListe(Individu indiv) {

	Individu tmp;
	tmp=indiv;
	while(tmp!=NULL) {
		printf("%d \n", tmp->valeur);
		tmp=tmp->suivant;
	}
}

Individu insererEnQueue(Individu indiv, Bit v) {

	Individu tmp,p;
	tmp=(Individu)malloc(sizeof(element));
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

int decoder(Individu indiv) {
	Individu tmp;
	int i,v;
	tmp=indiv;
	i=longIndiv;
	while(tmp!=NULL) {
		v=v+pow(2,i)*tmp->valeur;
		i--;
		tmp=tmp->suivant;
	}
	return v;
}
