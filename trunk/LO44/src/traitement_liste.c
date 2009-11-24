/*
 * essai.c
 *
 *  Created on: 19 nov. 2009
 *      Author: Aymeric
 */

#include <stdio.h>
#include <stdlib.h>
#include "traitement_liste.h"
#include "individu.h"

void afficherListe(Individu l) {
	
	Individu tmp;
	tmp=l;
	while(tmp!=NULL) {
		printf("%d \n", tmp->valeur);
		tmp=tmp->suivant;
	}
}

int estVide(Individu l) {
	
	if (l==NULL) {
		return 1;
	} else {
		return 0;
	}
}

Individu insererEnTete(Individu l, Bit v) {
	
	Individu nouvel;
	nouvel = (element*)malloc(sizeof(element));
    (*nouvel).valeur = v;
    nouvel->suivant = l;
    return nouvel;
}

Individu insererEnQueue(Individu l,Bit v) {
	
	Individu tmp,p;
	tmp=(element*)malloc(sizeof(element));
	tmp->valeur=v;
	tmp->suivant=NULL;
	
	if (l==NULL) {
		l=tmp;
	} else {
		p=l;
		while (p->suivant!=NULL) {
			p=p->suivant;
		}
		p->suivant=tmp;
	}
	return l;	
}

Individu supprimerTete(Individu l) {
	
	Individu tmp;
	if (l==NULL) {
		tmp=l;
	} else {
		tmp=l->suivant;
		free(l);
	}
	return tmp;	
}

Individu supprimerQueue(Individu l) {
	
	if (l!=NULL) {
		if (l->suivant==NULL) {
			free(l);
			l=NULL;
		} else {
			Individu p=l;
			
			while(p->suivant->suivant!=NULL) {
				p=p->suivant;
			}
			free(p->suivant);
			p->suivant=NULL;
		}
	}
	return l;	
}

int valeur_tete(Individu l) {
	return l->valeur;
}

Individu reste(Individu l) {
	return l->suivant;
}

int contenir(Individu l, Bit v) {
	int b=0;
	Individu p=l;
	while (!estVide(p) && b==0) {
		if (valeur_tete(p)==v) {
			b=1;
		} else {
			p=reste(p);
		}
	}
	return b;
}

int nbrElementsIndividu(Individu l) {
	Individu tmp=l;
	int i=0;
	while(!estVide(tmp)) {
		i++;
		tmp=reste(tmp);
	}
	return i;
}

Individu triABulles(Individu l) {
	int inv=0;
	Individu p=l;
	int temp;
	Individu f=NULL;
	if(!estVide(p) && !estVide(reste(p))) {
		do {
			inv=0;
			p=l;
			while(reste(p)!=f) {
				if (valeur_tete(p)>valeur_tete(reste(p))) {
					temp=valeur_tete(p);
					p->valeur=valeur_tete(reste(p));
					reste(p)->valeur=temp;
					inv=1;
				}
				p=p->suivant;
			}
			f=p;
		} while(inv);
	}
	return f;
}

Individu fusion2Individus(Individu l1, Individu l2) {
	Individu l3=NULL;
	l1=triABulles(l1);
	l2=triABulles(l2);

	while(!estVide(l1) && !estVide(l2)) {
		if (valeur_tete(l1)<valeur_tete(l2)) {
			l3=insererEnQueue(l3,valeur_tete(l1));
			l1=reste(l1);
		} else {
			l3=insererEnQueue(l3,valeur_tete(l2));
			l2=reste(l2);
		}
		if (estVide(l1)) {
			while(!estVide(l2)) {
				l3=insererEnQueue(l3, valeur_tete(l2));
				l2=reste(l2);
			}
		}
		if (estVide(l2)) {
			while(!estVide(l1)) {
				l3=insererEnQueue(l3, valeur_tete(l1));
				l1=reste(l1);
			}
		}
	}
	return l3;
}
