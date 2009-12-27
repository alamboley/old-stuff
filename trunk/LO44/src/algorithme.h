/*
 * Auteurs : Aymeric Lamboley & Anne Lassabe
 */

#ifndef ALGORITHME_H_
#define ALGORITHME_H_

Individu initialiserIT();

Individu initialiserRE(Individu individu, int longueur);

int decoder(Individu individu);

void croiserIndividu(Individu individu1, Individu individu2);

float qualite(int valeur);

float qualiteF1(int valeur);

float qualiteF2(int valeur);

float qualiteF3(int valeur);

Population initialiserPop();

Population quicksort(Population population);

Population selection(Population population);

Population croiserPop(Population population);

#endif
