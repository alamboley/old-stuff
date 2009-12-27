#ifndef TYPE_H_
#define TYPE_H_

int longIndiv;
float pCroise;
int taillePop;
float tSelect;
int nGen;
int fonctionQualite;

typedef unsigned char Bit;

typedef struct Element {
	Bit valeur;
	struct Element *suivant;
} element;

typedef element *Individu;

typedef struct Pop {
	Individu valeur;
	struct Pop *suivant;
} population;

typedef population *Population;

#endif
