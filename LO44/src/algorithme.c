/*
 * Auteurs : Anne Lassabe & Aymeric Lamboley
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

/*
Fonctions specifiques au projet
*/


//Manipulation des Individus (cf type.h)

//Initialise aleatoirement un individu de maniere iterative
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

//Initialise aleatoirement un individu de maniere recursive
//Parametres : individu a initialiser "indiv", longueur de l'individu "l"
Individu initialiserRE(Individu indiv, int l)
{
	Bit j;
	j = rand()%2;

	//Cas trivial : l'individu est compose d'un seul bit
	if (l == 1) {
		indiv = insererEnQueue(indiv, j);
		//Cas general : l'individu est compose de plusieurs bits
	} else {
		indiv = insererEnQueue(indiv, j);
		indiv = initialiserRE(indiv, l-1);
	}
	return indiv;
}

//Convertit l'individu (liste de bits) en valeur decimale
//Parametre : l'individu "indiv" a convertir
int decoder(Individu indiv)
{
	Individu tmp;
	int i, v = 0;
	//pointeur pour parcourir l'individu a decoder
	tmp = indiv;
	i = longIndiv;
	while(tmp != NULL) {
		//valeur decimale = somme des valeurs des bits * leur puissance
		//puissance maximale : "i" = longIndiv - 1
		v = v+(pow(2,i-1))*(tmp->valeur);
		i--;
		tmp = tmp->suivant;
	}
	return v;
}

//Intervertit aleatoirement (selon une probabilite) les bits de deux individus
//Parametres : "indiv1" et "indiv2" les individus a croiser
void croiserIndividu(Individu indiv1, Individu indiv2)
{
	Individu indiv3, indiv4;
	int tmp;

	indiv3 = indiv1;
	indiv4 = indiv2;

	while (indiv3!=NULL) {
	//pour chaque bit on echange les valeurs si la probabilite est respectee
		if ( (float)(rand()%101)/100 < pCroise ) {
			tmp=indiv3->valeur;
			indiv3->valeur=indiv4->valeur;
			indiv4->valeur=tmp;
		}
		indiv3=indiv3->suivant;
		indiv4=indiv4->suivant;
	}
}

//Appelle la fonction de qualite specifiee (ou non) en argument du main
//Parametre : la valeur decodee d'un individu
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

//Fonction de qualite par defaut
//Parametre : la valeur decodee d'un individu
float qualiteF1(int v)
{
	int A = -1, B = 1;
	float qualite, tmp;
	tmp = ((v/pow(2,longIndiv))*(B-A))+A;
	qualite = - pow(tmp,2);
	return qualite;
}

//Variante de la fonction de qualite utilisant le logarithme neperien
//Parametre : la valeur decodee d'un individu
float qualiteF2(int v)
{
	float A = 0.1, B = 5.0;
	float qualite, tmp;
	tmp = ((v/pow(2,longIndiv))*(B-A))+A;
	qualite = - log(tmp);
	return qualite;
}

//Autre variante utilisant la fonction cosinus
//Parametre : la valeur decodee d'un individu
float qualiteF3(int v)
{
	float qualite, tmp;
	tmp = ((v/pow(2,longIndiv))*(M_PI+M_PI)) + (-M_PI);
	qualite = - cos(tmp);
	return qualite;
}


//Fonctions manipulant une Population (cf type.h)

//Initilisation aleatoire d'une population
Population initialiserPop()
{
	int i;
	Individu citoyen = NULL;
	Population newPop = NULL;

	for (i = 0 ; i < taillePop ; i++) {
		//On initialise le nombre d'individus necessaires a une population
		citoyen = initialiserIT();
		//Et on les ajoute a la nouvelle population
		newPop = insererIndividu(newPop, citoyen);
	}
	return newPop;
}

//Tri rapide decroissant base sur la qualite des individus d'une population
//Parametre : Population a trier
Population quicksort(Population aTrier)
{
	//Cas trivial : s'il y a trop peu de valeurs a trier
	if (est_vide(aTrier) || est_vide(reste(aTrier))) {
		return aTrier;
	//Cas general

	} else {
		//On separera les valeurs en deux listes :
		//les valeurs plus petites que le pivot et les valeurs plus grandes
		Population petits = NULL, grands = NULL;
		Population gauche = NULL, droite = NULL;
		
		//Declaration des variables temporaires
		float valeur;
		//indivValeur = individu a comparer et deplacer dans la liste
		//indivPivot = individu dont la qualite servira de comparaison
		Individu indivValeur, indivPivot = valeur_tete(aTrier);
		//La valeur pivot est la qualite de l'individu pivot, ici le premier de la liste
		float pivot = qualite_tete(aTrier);

		while (!est_vide(aTrier) && (reste(aTrier) != NULL)) {
		//Tant qu'on a au moins deux individus a trier on compare leur qualite au pivot
			valeur = qualite_tete(reste(aTrier));
			indivValeur = valeur_tete(reste(aTrier));
			if (valeur <= pivot) {
				petits = insererIndividu(petits, indivValeur);
			} else {
				grands = insererIndividu(grands, indivValeur);
			}
			aTrier = reste(aTrier);
		}
		
		//Appel recursif de la fonction sur les listes ainsi formees
		//c'est-a-dire les individus plus petits et plus grand que le pivot
		gauche = quicksort(grands);
		droite = quicksort(petits);

		//Une fois les deux listes triees on les fusionne en inserant le pivot au milieu
		gauche = insererIndividu(gauche, indivPivot);
		ajout_file(gauche, droite);
		return gauche;
	}
}

//Selection des meilleurs individus de la population et
//recopie de ces individus sur le reste de la liste
//Parametre : Population "elite" dont on selectionne les meilleurs individus
Population selection(Population elite)
{
	//Calcul du nombre d'individus a selectionner
	int nbIndiv = (int)ceil(taillePop * tSelect);
	int i = 0;
	Population resultat = NULL;
	Population tmp = NULL;
	//On recopie les individus a selectionner dans la liste de resultat
	for(i = 0; i<nbIndiv; i++) {
		Individu in = elite->valeur;
		resultat = insererIndividu(resultat, in);
		elite = elite->suivant;
	}
	tmp = resultat;
	//Puis on parcourt la liste resultat pour recopier ses valeurs
	//jusqu'a avoir la bonne taille de population
	for(i = 0; i<(taillePop - nbIndiv); i++)
	{
		Individu in = tmp->valeur;
		resultat = insererIndividu(resultat, in);
		tmp = tmp->suivant;
	}
	return resultat;
}

int taillePopulation(Population population)
{
	int taille = 0;
	while (population != NULL)
	{
		taille++;
		population = population->suivant;
	}
	return taille;
}

//Cree une nouvelle population a partir de croisements d'individus
//Parametre : Population dont on croise les individus aleatoirement
Population croiserPop(Population parent)
{
	Population enfant = NULL;
	int i, j;
	//On cree deux nouveaux individus par croisement jusqu'a avoir une population de taille normale
	for(i = 0; i < taillePop; i += 2) {
		int choixUn, choixDeux;
		Individu un = NULL, deux = NULL;
		Population tmp = parent;

		//choix aleatoire du premier individu
		choixUn = rand() % (taillePop - 1);

		//choix aleatoire du deuxieme individu
		choixDeux = rand() % (taillePop - 1);

		for (j = 0; j < taillePop; j++){
			if (j == choixUn) {
				un = tmp->valeur;
			}
			if (j == choixDeux) {
				deux = tmp->valeur;
			}
			tmp = tmp->suivant;
		}
		croiserIndividu(un, deux);
		if (taillePopulation(enfant) < taillePop)
			enfant = insererIndividu(enfant, un);

		if (taillePopulation(enfant) < taillePop)
			enfant = insererIndividu(enfant, deux);
	}
	return enfant;
}
