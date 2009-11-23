/*
 * essai.c
 *
 *  Created on: 19 nov. 2009
 *      Author: Aymeric
 */

#include <stdio.h>
#include <stdlib.h>
#include "traitement_liste.h"

void afficherListe(liste l) {
	
	liste tmp;
	tmp=l;
	while(tmp!=NULL) {
		printf("%d \n", tmp->valeur);
		tmp=tmp->suivant;
	}
}

int estVide(liste l) {
	
	if (l==NULL) {
		return 1;
	} else {
		return 0;
	}
}

liste insererEnTete(liste l, int v) {
	
	liste nouvel;
	nouvel = (element*)malloc(sizeof(element));
    (*nouvel).valeur = v;
    nouvel->suivant = l;
    return nouvel;
}

liste insererEnQueue(liste l,int v) {
	
	liste tmp,p;
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

liste supprimerTete(liste l) {
	
	liste tmp;
	if (l==NULL) {
		tmp=l;
	} else {
		tmp=l->suivant;
		free(l);
	}
	return tmp;	
}

liste supprimerQueue(liste l) {
	
	if (l!=NULL) {
		if (l->suivant==NULL) {
			free(l);
			l=NULL;
		} else {
			liste p=l;
			
			while(p->suivant->suivant!=NULL) {
				p=p->suivant;
			}
			free(p->suivant);
			p->suivant=NULL;
		}
	}
	return l;	
}

int valeur_tete(liste l) {
	return l->valeur;
}

liste reste(liste l) {
	return l->suivant;
}

int contenir(liste l, int v) {
	int b=0;
	liste p=l;
	while (!estVide(p) && b==0) {
		if (valeur_tete(p)==v) {
			b=1;
		} else {
			p=reste(p);
		}
	}
	return b;
}

int nbrElementsListe(liste l) {
	liste tmp=l;
	int i=0;
	while(!estVide(tmp)) {
		i++;
		tmp=reste(tmp);
	}
	return i;
}

liste triABulles(liste l) {
	int inv=0;
	liste p=l;
	int temp;
	liste f=NULL;
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

liste fusion2listes(liste l1, liste l2) {
	liste l3=NULL;
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
