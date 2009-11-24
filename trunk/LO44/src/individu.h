/*
 * individu.h
 *
 *  Created on: 24 nov. 2009
 *      Author: Aymeric
 */

#ifndef INDIVIDU_H_
#define INDIVIDU_H_

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include "traitement_liste.h"

#define longIndiv 8

typedef unsigned char Bit;

typedef struct Element { Bit valeur;
						struct Element *suivant;
						} element;

typedef element *Individu;

Individu initialiserIT();
Individu initialiserRE();

int decoder(Individu indiv);

croiserIndividu(Individu indiv1, Individu indiv2);

float f1(int v);

#endif /* INDIVIDU_H_ */
