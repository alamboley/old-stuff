package lo43.projet.utboheme.arbre;

import lo43.projet.utboheme.hexagone.Sommet;

public class ArbreBinaire {
	
	private Sommet racine;
	 
	private ArbreBinaire filsD;
	 
	private ArbreBinaire filsG;
	
	public ArbreBinaire() {
		racine = null;
		filsG = null;
		filsD = null;
	}
	
	public ArbreBinaire(Sommet r, ArbreBinaire fg, ArbreBinaire fd) {
		racine = r;
		filsG = fg;
		filsD = fd;
	}
	
	public Sommet getRacine() {
		return racine;
	}

	public void setRacine(Sommet racine) {
		this.racine = racine;
	}

	public ArbreBinaire getFilsD() {
		return filsD;
	}

	public void setFilsD(ArbreBinaire filsD) {
		this.filsD = filsD;
	}

	public ArbreBinaire getFilsG() {
		return filsG;
	}

	public void setFilsG(ArbreBinaire filsG) {
		this.filsG = filsG;
	}

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
 
    private ArbreBinaire trouverArbre(Sommet racine) {
        return this.trouverArbre(this, racine);
    }


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
	 
	public ArbreBinaire enraciner(Sommet sommet) {
		ArbreBinaire tmp = new ArbreBinaire(sommet, this, null);
		return tmp;
	}
	 
	public int cheminPlusLong() {
		return 0;
	}

}
