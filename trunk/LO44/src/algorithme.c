/*
 * Auteurs : Aymeric Lamboley & Anne Lassabe
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

//
//Fonctions spécifiques au projet
//

//Initialise aléatoirement un individu de manière itérative
Individu initialiserIT()
{
	int i;
	Bit j;
	Individu indiv = NULL;

	for (i = 0 ; i < longIndiv ; i++) {
		j = rand()%2;
		indiv = insererEnQueue(indiv, j);
	}
	return indiv;
}

//Initialise aléatoirement un individu de manière récursive
//Paramètres : individu à initialiser "indiv", longueur de l'individu "l"
Individu initialiserRE(Individu indiv, int l)
{
	Bit j;
	j = rand()%2;

	//Cas trivial : l'individu est composé d'un seul bit
	if (l == 1) {
		indiv = insererEnQueue(indiv, j);
		//Cas général : l'individu est composé de plusieurs bits
	} else {
		indiv = insererEnQueue(indiv, j);
		indiv = initialiserRE(indiv, l-1);
	}
	return indiv;
}

//Convertit l'individu (liste de bits) en valeur décimale
//Paramètre : l'individu "indiv" à convertir
int decoder(Individu indiv)
{
	Individu tmp;
	int i, v = 0;
	//pointeur pour parcourir l'individu à décoder
	tmp = indiv;
	i = longIndiv;
	while(tmp != NULL) {
		//valeur décimale = somme des valeurs des bits * leur puissance
		//puissance maximale : "i" = longIndiv - 1
		v = v+(pow(2,i-1))*(tmp->valeur);
		i--;
		tmp = tmp->suivant;
	}
	return v;
}

//Intervertit aléatoirement (selon une probabilité) les bits de deux individus
//Paramètres : "indiv1" et "indiv2" les individus à croiser
void croiserIndividu(Individu indiv1, Individu indiv2)
{
	Individu indiv3, indiv4;
	int tmp;

	indiv3 = indiv1;
	indiv4 = indiv2;

	while (indiv3!=NULL) {
	//pour chaque bit on échange les valeurs si la probabilité est respectée
		if ( (float)(rand()%101)/100 < pCroise ) {
			tmp=indiv3->valeur;
			indiv3->valeur=indiv4->valeur;
			indiv4->valeur=tmp;
		}
		indiv3=indiv3->suivant;
		indiv4=indiv4->suivant;
	}
}

//Appelle la fonction de qualité spécifiée (ou non) en argument du main
float qualite(int v) {
	switch (fonctionQualite) {
		case 1:
			return qualiteF1(v);
		case 2:
			return qualiteF2(v);
		case 3:
			return qualiteF3(v);
		default:
			// Ne devrait pas se produire
			break;
	}
	// Ne devrait pas se produire non plus
	return qualiteF1(v);
}

//Fonction de qualité par défaut
float qualiteF1(int v)
{
	int A = -1, B = 1;
	float qualite, tmp;
	tmp = (v/pow(2,longIndiv))*((B-A)+A);
	qualite = - pow(tmp,2);
	return qualite;
}

//Variante de la fonction de qualité utilisant le logarithme néperien
float qualiteF2(int v)
{
	float A = 0.5, B = 5.0;
	float qualite, tmp;
	tmp = (v/pow(2,longIndiv))*((B-A)+A);
	qualite = - log(tmp);
	return qualite;
}

//Autre variante utilisant la fonction cosinus
float qualiteF3(int v)
{
	float qualite, tmp;
	tmp = (v/pow(2,longIndiv))*((M_PI+M_PI)+ (-M_PI));
	qualite = - cos(tmp);
	return qualite;
}


//Fonctions manipulant une population

//Initilisation aléatoire d'une population
Population initialiserPop()
{
	int i;
	Individu citoyen = NULL;
	Population newPop = NULL;

	for (i = 0 ; i < taillePop ; i++) {
		//On initialise le nombre d'individus nécessaires
		citoyen = initialiserIT();
		//Puis on les ajoute à la nouvelle population
		newPop = insererIndividu(newPop, citoyen);
	}
	return newPop;
}

//Tri rapide décroissant basé sur la qualité des individus d'une population
Population quicksort(Population aTrier)
{
	if (est_vide(aTrier) || est_vide(reste(aTrier))) {
		return aTrier;
	} else {
		Population petits = NULL, grands = NULL;
		Population gauche = NULL, droite = NULL;
		float valeur;
		Individu indivValeur, indivPivot = valeur_tete(aTrier);
		float pivot = qualite_tete(aTrier);

		while (!est_vide(aTrier) && (reste(aTrier) != NULL)) {
			valeur = qualite_tete(reste(aTrier));
			indivValeur = valeur_tete(reste(aTrier));
			if (valeur <= pivot) {
				petits = insererIndividu(petits, indivValeur);
			} else {
				grands = insererIndividu(grands, indivValeur);
			}
			aTrier = reste(aTrier);
		}

		gauche = quicksort(grands);
		droite = quicksort(petits);

		gauche = insererIndividu(gauche, indivPivot);
		ajout_file(gauche, droite); // On fusionne les 2 listes
		return gauche;
	}
}

Population selection(Population elite)
{
	//Calcul du nombre d'individus à sélectionner
	int nbIndiv = taillePop * tSelect;
	int i = 0;
	Population resultat = NULL;
	Population tmp = NULL;
	for(i = 0; i<nbIndiv; i++) {
		Individu in = elite->valeur;
		resultat = insererIndividu(resultat, in);
		elite = elite->suivant;
	}
	tmp = resultat;
	for(i = 0; i<(taillePop - nbIndiv); i++)
	{
		Individu in = tmp->valeur;
		resultat = insererIndividu(resultat, in);
		tmp = tmp->suivant;
	}
	return resultat;
}

Population croiserPop(Population parent)
{
	Population enfant = NULL;
	int i, j;
	for(i = 0; i < taillePop; i += 2) {
		int choixPetit, choixGrand;
		Individu petit = NULL, grand = NULL;
		Population tmp = parent;

		//choix aléatoire du premier individu
		choixPetit = rand() % (taillePop - 1);

		//choix aléatoire du deuxième individu
		choixGrand = nombreAleatoire(choixPetit, taillePop - 1);

		for (j = 0; j <= choixGrand; j++){
			if (j == choixPetit) {
				petit = tmp->valeur;
			}
			if (j == choixGrand) {
				grand = tmp->valeur;
			}
			tmp = tmp->suivant;
		}
		croiserIndividu(petit, grand);
		enfant = insererIndividu(enfant, petit);
		enfant = insererIndividu(enfant, grand);
	}
	return enfant;
}
