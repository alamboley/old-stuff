/*
 * Auteurs : Anne Lassabe & Aymeric Lamboley
 */

#ifndef TYPE_H_

#define TYPE_H_

//Parametres du projet :
//Nombre de bits constituant un individu
int longIndiv;
//Probabilite de croisement de deux individus
float pCroise;
//Taille d'une Population
int taillePop;
//Pourcentage de selection des Individus d'une Population
float tSelect;
//Nombre de generations de Population
int nGen;
//Entier servant a indiquer quelle fonction de qualite utiliser
int fonctionQualite;


//Definition des types de structures specifiques au projet
typedef unsigned char Bit;

//Definition d'un element d'un Individu
typedef struct Element {
	Bit valeur;
	struct Element *suivant;
} element;

//Definition d'un individu : liste chaînee de Bits
typedef element *Individu;

//Definition d'un element d'une Population
typedef struct Pop {
	Individu valeur;
	struct Pop *suivant;
} population;

//Definition d'une Population : liste chaînee d'Individus
typedef population *Population;

#endif
