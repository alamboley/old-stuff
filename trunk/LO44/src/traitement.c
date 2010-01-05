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
Fonctions necessaires a la manipulation des types de donnees et des fonctions du projet (cf type.h)
*/

//Affichage de l'individu passe en parametre
//Parametre : l'Individu "indiv" a afficher
void afficherListe(Individu indiv)
{

	Individu tmp;
	tmp = indiv;
	int i = 1;
	while (tmp!=NULL) {
	    printf("%d", tmp->valeur);
	    //On separe chaque quartet par un espace pour une meilleure lisibilite
	    if (i % 4 == 0) {
	    	printf(" ");
	    }

		tmp=tmp->suivant;
		i++;
	}
	printf("\n");
}

//Insertion d'une valeur a la fin d'un individu
//Parametres : Individu "indiv" a la fin duquel on insere le Bit "v"
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

//Fonction verifiant si une population est vide ou pas
//Parametre : Population "p"
bool est_vide(Population p)
{
	if (p == NULL)
		return true;
	else
		return false;
}

//Renvoie la Population privee de son premier individu
//Parametre : Population "p" non tronquee
Population reste(Population p)
{
	return p -> suivant;
}

//Retourne la QUALITE du premier individu de la population
//Parametre : Population "p"
float qualite_tete(Population p)
{
	return qualite(decoder(p->valeur));
}

Individu valeur_tete(Population p)
{
	return p->valeur;
}

//Fusionne deux populations
//Parametres : Population "debut" a la fin de laquelle on ajoute la Population "fin"
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

//Ajoute un individu a la population
//Parametre : Population "p" a fin de laquelle on ajoute l'Individu "i"
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

//Affiche la qualite de chaque individu de la population (fonction de test)
//Parametre : Population "p"
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

//Genere un nombre aleatoire compris entre deux valeurs passees en parametre
//Parametres : les valeurs limites du nombre aleatoire (entiers)
int nombreAleatoire(int valeurMini, int valeurMax) {
	return (int) (valeurMini + ((float) rand() / RAND_MAX * (valeurMax - valeurMini + 1)));
}
