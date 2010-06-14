package lo43.projet.utboheme.arbre;

import lo43.projet.utboheme.hexagone.Sommet;

/**
 * Classe represantant un arbre binaire
 * Utilise pour stcoker les cursus les plus long
 * @author alexandreaugen
 *	
 */
public class ArbreBinaire {
	
	private Sommet racine;
	private ArbreBinaire filsD;
	private ArbreBinaire filsG;
	
	/**
	 * Contructeur par defaut
	 */
	public ArbreBinaire() {
		racine = null;
		filsG = null;
		filsD = null;
	}
	
	/**
	 * constructeur parametre
	 * @param r
	 * @param fg
	 * @param fd
	 */
	public ArbreBinaire(Sommet r, ArbreBinaire fg, ArbreBinaire fd) {
		racine = r;
		filsG = fg;
		filsD = fd;
	}
	
	/**
	 * Renvoi la racine
	 * @return
	 * 	- un sommet
	 */
	public Sommet getRacine() {
		return racine;
	}

	/**
	 * Attribut un sommet ˆ la racine
	 * @param racine
	 */
	public void setRacine(Sommet racine) {
		this.racine = racine;
	}

	/**
	 * Renvoi l'arbre binaire de droite
	 * @return
	 * 	- un arbre binaire
	 */
	public ArbreBinaire getFilsD() {
		return filsD;
	}

	/**
	 * Attribut un arbre binaire au fils droit
	 * @param filsD
	 */
	public void setFilsD(ArbreBinaire filsD) {
		this.filsD = filsD;
	}

	/**
	 * Renvoi l'arbre binaire de gauche
	 * @return
	 * 	- un arbre binaire
	 */
	public ArbreBinaire getFilsG() {
		return filsG;
	}

	/**
	 * Attribut un arbre binaire au fils de gauche
	 * @param filsG
	 */
	public void setFilsG(ArbreBinaire filsG) {
		this.filsG = filsG;
	}

	/**
	 * Methode qui recherche un arbre dans l'arbre binaire base et selon le sommet racine
	 * @param base
	 * @param racine
	 * @return
	 * 	- un arbre binaire
	 */
	private ArbreBinaire trouverArbre(ArbreBinaire base, Sommet racine) {
        ArbreBinaire gauche = null;
        ArbreBinaire droite = null;

        if (base != null) {
            if (base.racine == racine) {
                return base;
            }

            if (base.filsG != null) {
                gauche = this.trouverArbre(base.filsG, racine);
            }

            if (base.filsD != null) {
                droite = this.trouverArbre(base.filsD, racine);
            }
        }

        if (gauche != null) {
            return gauche;
        }

        if (droite != null) {
            return droite;
        }

        return null;
    }
 
	/**
	 * Methode qui recherche un arbre binaire selon le sommet racine
	 * @param racine
	 * @return
	 * 	- un arbre binaire
	 */
    private ArbreBinaire trouverArbre(Sommet racine) {
        return this.trouverArbre(this, racine);
    }


    /**
     * MŽthode pour ajouter un noeud par rapport a un sommet
     * @param attache
     * @param ajout
     * @return
     * 	- un boolean
     */
    public boolean ajouterNoeud(Sommet attache, Sommet ajout) {
        ArbreBinaire tmp = this.trouverArbre(attache);
        boolean resultat = true;

        if (tmp == null) {
            System.out.println("WTF! arbre introuvable...");
            resultat = false;
        } else {
            if (tmp.filsG == null) {
                tmp.filsG = new ArbreBinaire();
                tmp.filsG.racine = ajout;
                // System.out.println("ajout a gauche " + attache + " ===> " + ajout);
            } else if (tmp.filsD == null) {
                tmp.filsD = new ArbreBinaire();
                tmp.filsD.racine = ajout;
                // System.out.println("ajout a droite " + attache + " ===> " + ajout);
            } else {
                tmp.enraciner(ajout);
                // System.out.println("ajout a racine " + ajout);
            }
        }
        return resultat;
    }
	 
    /**
     * Methode pour enraciner un sommet
     * @param sommet
     * @return
     * 	- un arbre binaire
     */
	public ArbreBinaire enraciner(Sommet sommet) {
		ArbreBinaire tmp = new ArbreBinaire(sommet, this, null);
		return tmp;
	}
	 
	/**
	 * Methode pour rechercher le chemin le plus long
	 * @return
	 * 	- un entier
	 */
	public int cheminPlusLong() {
		return 0;
	}

}
