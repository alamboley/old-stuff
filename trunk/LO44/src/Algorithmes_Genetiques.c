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

#define TaillePop 20;
#define longIndiv 8
#define A -1
#define B 1

typedef unsigned char Bit;

typedef struct Element { Bit valeur;
						struct Element *suivant;
						} element;

typedef element *Individu;

typedef struct Pop { Individu valeur;
					struct Pop *suivant;
					} population;
typedef population *Population;

Individu initialiserIT();
Individu initialiserRE(Individu indiv, int l);
void afficherListe(Individu indiv);
Individu insererEnQueue(Individu indiv, Bit v);
int decoder(Individu indiv);
void croiserIndividu(Individu indiv1, Individu indiv2);
float qualiteF1(int v);

int main(void) {
	Individu indiv1, indiv2;
	int valeurIndiv1, valeurIndiv2;
	float qualiteIndiv1, qualiteIndiv2;

	indiv1=initialiserIT();
	afficherListe(indiv1);
	valeurIndiv1=decoder(indiv1);
	printf("L'individu 1 vaut : %d \n", valeurIndiv1);

	indiv2=initialiserRE(indiv2, longIndiv);
	afficherListe(indiv2);
	valeurIndiv2=decoder(indiv2);
	printf("L'individu 2 vaut : %d \n", valeurIndiv2);

	croiserIndividu(indiv1, indiv2);
	printf("\nApres croisement des Individus : \n");
	valeurIndiv1=decoder(indiv1);
	printf("L'individu 1 vaut : %d \n", valeurIndiv1);
	valeurIndiv2=decoder(indiv2);
	printf("L'individu 2 vaut : %d \n", valeurIndiv2);

	qualiteIndiv1=qualiteF1(valeurIndiv1);
	printf("La qualite de l'individu 1 vaut : %f \n", qualiteIndiv1);
	qualiteIndiv2=qualiteF1(valeurIndiv2);
	printf("La qualite de l'individu 2 vaut : %f \n", qualiteIndiv2);

	return EXIT_SUCCESS;
}

Individu initialiserIT() {
	int i;
	Bit j;
	Individu indiv;

	srand(time(NULL)); //On demarre un timer pour la fonction rand.

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
		v=v+pow(2,i-1)*tmp->valeur;
		i--;
		tmp=tmp->suivant;
	}
	return v;
}

void croiserIndividu(Individu indiv1, Individu indiv2) {

   Individu indiv3, indiv4;
   indiv3=(Individu)malloc(sizeof(element));
   indiv4=(Individu)malloc(sizeof(element));
   int tmp, pCroise;

   indiv3=indiv1;
   indiv4=indiv2;

   while (indiv3!=NULL) {
       pCroise=rand()%2;
       if (pCroise==1) {
           tmp=indiv3->valeur;
           indiv3->valeur=indiv4->valeur;
           indiv4->valeur=tmp;
       }
       indiv3=indiv3->suivant;
       indiv4=indiv4->suivant;
   }
}

float qualiteF1(int v) {

	float qualite, tmp1, tmp2, tmp3;
	tmp1=pow(2,longIndiv);
	tmp2=(B-A)+A;
	tmp3= (v/tmp1)*tmp2;
	qualite = - pow(tmp3,2);
	return qualite;
}
