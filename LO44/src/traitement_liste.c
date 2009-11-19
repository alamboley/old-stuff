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
		return 0;
	} else {
		return 1;
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
