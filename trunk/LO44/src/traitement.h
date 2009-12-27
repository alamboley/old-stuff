/*
 * Auteurs : Aymeric Lamboley & Anne Lassabe
 */

#ifndef TRAITEMENT_H_
#define TRAITEMENT_H_

void afficherListe(Individu individu);

Individu insererEnQueue(Individu individu, Bit bit);

bool est_vide(Population population);

Population reste(Population population);

Population ajout_file(Population population1, Population population2);

float qualite_tete(Population population);

Individu valeur_tete(Population population);

Population insererIndividu(Population population, Individu individu);

void afficher_qualitePop(Population population);

int nombreAleatoire(int min, int max);

#endif
