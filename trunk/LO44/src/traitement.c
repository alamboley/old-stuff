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
//Fonctions nécessaires à la manipulation des types de données et des fonctions du projet
//

//Affichage de l'individu passé en paramètre (cf type.h)
void afficherListe(Individu indiv)
{

	Individu tmp;
	tmp = indiv;
	int i = 1;
	while (tmp!=NULL) {
	    printf("%d", tmp->valeur);
	    //On sépare chaque quartet par un espace pour une meilleure lisibilité
	    if (i % 4 == 0) {
	    	printf(" ");
	    }

		tmp=tmp->suivant;
		i++;
	}
	printf("\n");
}

//Insertion d'une valeur à la fin d'un individu (cf type.h)
Individu insererEnQueue(Individu indiv, Bit v)
{
	Individu tmp, p;
	tmp = (Individu)malloc(sizeof(element));
	tmp->valeur = v;
	tmp->suivant = NULL;
	
	if (indiv == NULL) {
		indiv = tmp;
	} else {
		p = indiv;
		while (p->suivant != NULL) {
			p = p->suivant;
		}
		p->suivant = tmp;
	}
	return indiv;
}

//Fonction vérifiant si une population est vide ou pas (cf type.h)
bool est_vide(Population p)
{
	if (p == NULL)
		return true;
	else
		return false;
}

Population reste(Population p)
{
	return p -> suivant;
}

//retourner la QUALITE du premier individu de la population
float qualite_tete(Population p)
{
	return qualite(decoder(p->valeur));
}

Individu valeur_tete(Population p)
{
	return p->valeur;
}

//Fusionne deux population en ajoutant à la fin de la première population la seconde
Population ajout_file(Population debut, Population fin)
{
	Population tmp = debut;
	if (tmp == NULL) {
		tmp = fin;
	} else {
		while (tmp->suivant != NULL) {
			tmp = tmp->suivant;
		}
		tmp->suivant = fin;
	}
	return debut;
}

//Ajoute un individu à la fin de la population
Population insererIndividu(Population p, Individu i)
{
	Population tmp, t;
	tmp = (Population)malloc(sizeof(population));
	tmp->valeur = i;
	tmp->suivant = NULL;
	
	if (p == NULL) {
		p = tmp;
	} else {
		t = p;
		while (t->suivant != NULL) {
			t = t->suivant;
		}
		t->suivant = tmp;
	}
	return p;
}

//Affiche la qualité de chaque individu de la population (fonction de test)
void afficher_qualitePop(Population p)
{

	Population tmp;
	tmp = p;
	int i = 0;
	
	printf("{ ");
	while(tmp!=NULL) {
		printf("%f at %d ", qualite(decoder(tmp->valeur)), i++);
		tmp=tmp->suivant;
		if (tmp != NULL) {
			printf(" | ");
		}
	}
	printf("}");
	printf("\n");

}

//Génère un nombre aléatoire compris entre deux valeurs passées en paramètre
int nombreAleatoire(int valeurMini, int valeurMax) {
	return (int) (valeurMini + ((float) rand() / RAND_MAX * (valeurMax - valeurMini + 1)));
}
