package lo43.projet.utboheme.jeu;

import java.awt.Color;
import java.util.ArrayList;
import java.util.List;

import lo43.projet.utboheme.arbre.ArbreBinaire;
import lo43.projet.utboheme.carte.GroupeCartes;
import lo43.projet.utboheme.carte.GroupeCartesDev;
import lo43.projet.utboheme.carte.TypeCartes;
import lo43.projet.utboheme.pion.Pion;
import lo43.projet.utboheme.pion.UV;

public class Joueur {
	
	private int ident;
	private String nom;
	private Color couleur;
	private int nbPoints;
	private boolean ancien;
	private boolean cursus;
	private boolean actif;

	private List<GroupeCartes> lcartes;
	private List<GroupeCartesDev> lcartesJouees;
	private List<Pion> lcc;
	private List<UV> luv;
	private List<UV> luvstar;
	private List<ArbreBinaire> chemins;
	
	public Joueur() {
		this.ident = 0;
		this.nom = null;
		this.couleur = null;
		this.nbPoints = 0;
		this.ancien = false;
		this.cursus = false;
		this.actif = false;
		this.lcartes = null;
		this.lcartesJouees = null;
		this.lcc = null;
		this.luv = null;
		this.luvstar = null;
		this.chemins = null;
	}
	
	public Joueur(Integer pident, String pnom, Color pc) {
		this();
		this.ident = pident;
		this.nom = pnom;
		this.couleur = pc;
		
		this.lcartes = new ArrayList<GroupeCartes>();
		lcartes.add(new GroupeCartes(0, TypeCartes.BIERE));
		lcartes.add(new GroupeCartes(0, TypeCartes.SOMMEIL));
		lcartes.add(new GroupeCartes(0, TypeCartes.CAFE));
		lcartes.add(new GroupeCartes(0, TypeCartes.SUPPORT));
		lcartes.add(new GroupeCartes(0, TypeCartes.NOURRITURE));

		this.lcartesJouees = new ArrayList<GroupeCartesDev>();
		this.luvstar = new ArrayList<UV>();
		this.luv = new ArrayList<UV>();
		this.lcc = new ArrayList<Pion>();
		
		for(int i=0; i<4; i++) {
			this.luvstar.add(new UV(this, 2, true));
		}
		for(int i=0; i<5; i++) {
			this.luv.add(new UV(this, 1, false));
		}
		for(int i=0; i<15; i++) {
			this.lcc.add(new Pion(this));
		}
	}

	
	public int getIdent() {
		return ident;
	}

	public void setIdent(int ident) {
		this.ident = ident;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public Color getCouleur() {
		return couleur;
	}

	public void setCouleur(Color c) {
		this.couleur = c;
	}

	public int getNbPoints() {
		return nbPoints;
	}

	public void setNbPoints(int nb) {
		this.nbPoints = nb;
	}
	
	public void addNbPoints(int nb) {
		this.nbPoints += nb;
	}

	public boolean isAncien() {
		return ancien;
	}

	public void setAncien(boolean ancien) {
		this.ancien = ancien;
	}

	public boolean isCursus() {
		return cursus;
	}

	public void setCursus(boolean cursus) {
		this.cursus = cursus;
	}

	
	public boolean isActif() {
		return actif;
	}

	public void setActif(boolean actif) {
		this.actif = actif;
	}

	public List<GroupeCartes> getCartes() {
		return lcartes;
	}
	
	public GroupeCartes getGroupeCartes(TypeCartes ptype) {
		GroupeCartes resGroupeCartes = new GroupeCartes();
		for(GroupeCartes gc : this.lcartes) {
			if(gc.getTypeCartes() == ptype) {
				resGroupeCartes = gc;
				break;
			}
		}
		return resGroupeCartes;
	}
	
	public void setGroupeCarte(TypeCartes ptype, int nbCartes) {
		this.getGroupeCartes(ptype).addCartes(nbCartes);
	}

	public void setCartes(List<GroupeCartes> pcartes) {
		this.lcartes = pcartes;
	}
	
	public void setGroupeCartes(GroupeCartes pgc) {
		this.lcartes.add(pgc);
	}

	public List<GroupeCartesDev> getCartesJouees() {
		return lcartesJouees;
	}

	public void setCartesJouees(List<GroupeCartesDev> cartesJouees) {
		this.lcartesJouees = cartesJouees;
	}

	public List<Pion> getLcc() {
		return lcc;
	}

	public List<UV> getLuv() {
		return luv;
	}

	public List<UV> getLuvstar() {
		return luvstar;
	}

	public int getNbUV() {
		return luv.size();
	}

	public int getNbUVStar() {
		return luvstar.size();
	}

	public int getNbCC() {
		return lcc.size();
	}
	
	public int getNbCartes(TypeCartes ptype) {
		return this.getGroupeCartes(ptype).getNombre();
	}

	public List<ArbreBinaire> getChemins() {
		return chemins;
	}

	public void setChemins(List<ArbreBinaire> chemins) {
		this.chemins = chemins;
	}

	/*public boolean construireUV(Sommet sommet, boolean etoile) {
		//phase de fondation ?
		if (nbUV > 3) {
			nbUV--;
			nbPoints++;
		} else {
			if (etoile) { // UV etoilee
				// on dispose des ressources necessaires (2 supports, 3 sommeils)
				if ((cartes.get(4).getNombre() >= 2) && (cartes.get(3).getNombre() >= 3)) {
					if (nbUVStar == 0) {
						//pas de pion !
						return false;
					} else {
						cartes.get(4).remCartes(2);
						cartes.get(3).remCartes(3);
						nbUVStar--;
						nbPoints += 2;
					}
				} else { //pas assez de ressources
					return false;
				}
			} else { //UV simple
				//on dispose des ressources n�cessaires (1 biere, 1 nourriture, 1 support, 1 cafe)
				if ((cartes.get(0).getNombre() >= 1) && (cartes.get(1).getNombre() >= 1) && (cartes.get(2).getNombre() >= 1) && (cartes.get(4).getNombre() >= 1)) {
					if (nbUV == 0) {
						//pas de pion
						return false;
					} else {
						cartes.get(0).remCartes(1);
						cartes.get(1).remCartes(1);
						cartes.get(2).remCartes(1);
						cartes.get(4).remCartes(1);
						nbUV--;
						nbPoints++;
					}
				} else { //pas assez de ressources
					return false;
				}
			}
		}
		return true;
	}
	 
	public boolean construireCC(Arete arrete) {
		//phase de fondation ?
		if (nbCC > 13) {
			nbCC--;
			chemins.add(new ArbreBinaire(arrete.getsDebut(), (new ArbreBinaire(arrete.getsFin(), null, null)), null));
		} else {
			// on dispose des ressources necessaires (1 biere, 1 nourriture)
			if ((cartes.get(0).getNombre() >= 1) && (cartes.get(2).getNombre() >= 1)) {
				if (nbCC == 0) {
					//pas de pion !
					return false;
				} else { //on peut construire
					cartes.get(0).remCartes(1);
					cartes.get(2).remCartes(1);
					nbCC--;
					if (!chemins.get(0).ajouterNoeud(arrete.getsDebut(), arrete.getsFin())) {
						if (!chemins.get(1).ajouterNoeud(arrete.getsDebut(), arrete.getsFin())) {
							return false;
						}
					}
				}
			} else { //pas assez de ressources
				return false;
			}
		}
		return true;
	}
	 
	public boolean echange(Joueur joueur, TypeCartes typeDem, int nbDem, TypeCartes typeOff, int nbOff) {
		int inOffre = 0, inDemande = 0; //indices dans les listes pour retrouver le bon type de cartes
		// on recupere les ressources dispos du joueur initiateur de la transaction
		for (int i = 0; i < cartes.size(); i++) {
			if (cartes.get(i).getTypeCartes() == typeOff) {// on trouve le bon type
				if (cartes.get(i).getNombre() >= nbOff) { //on a assez de ressource
					inOffre = i;
				} else {
					return false; //pas assez de ressource
				}
			}
		}
		//on recupere les ressources dispos de l'autre joueur
		for (int i = 0; i < joueur.cartes.size(); i++) {
			if (joueur.cartes.get(i).getTypeCartes() == typeDem) {// on trouve le bon type
				if (joueur.cartes.get(i).getNombre() >= nbDem) { //on a assez de ressource
					inDemande = i;
				} else {
					return false; //pas assez de ressource
				}
			}
		}
		
		//on retire de ses cartes le nombre necessaire et on les ajoute au joueur adverse
		cartes.get(inOffre).remCartes(nbOff);
		joueur.cartes.get(inOffre).addCartes(nbOff);
		//on ajoute a ses cartes les nombre voulu et on les retire du joueur adverse
		cartes.get(inDemande).addCartes(nbDem);
		joueur.cartes.get(inDemande).remCartes(nbDem);
		return true;
	}
	 
	//j'ai fait de la merde
	public boolean troc(TypeCartes matiere, int symbole) {
		// TODO refaire la methode
		for (GroupeCartes grpCartes : cartes) {
			if (grpCartes.getTypeCartes() == matiere) {
				if (grpCartes.getNombre() < symbole) {
					return false;
				} else {
					grpCartes.remCartes(symbole);
					return true;
				}
			}
		}
		return false;
	}
	 
	public GroupeCartes get_cartes(TypeCartes typeCarte) {
		for (GroupeCartes grp : cartes) {
			if (grp.getTypeCartes() == typeCarte) {
				return grp;
			}
		}
		return null;
	}
	 
	public void decouverte(TypeCartes type1, TypeCartes type2) {
		//on ajoute les cartes voulues au stock du joueur warning : il faudra les enlever du stock du jeu
		this.get_cartes(type1).addCartes(1);
		this.get_cartes(type2).addCartes(1);
		this.set_cartesJouees(SousTypeCartes.DECOUVERTE, 1);
	}
	 
	//TODO deplacer la methode monopole dans la classe jeu
	public void monopole(TypeCartes typeRess, int nb) {
		// dans cette classe on ne peut que retirer des cartes du stock du joueur
		this.get_cartes(typeRess).addCartes(nb);
		this.set_cartesJouees(SousTypeCartes.MONOPOLE, 1);
	}
	 
	public boolean volerCarte(Joueur joueur) {
		return false;
	}
	 
	 
	public GroupeCartesDev get_cartesJouees(SousTypeCartes typeCarte) {
		for (GroupeCartesDev dev : cartesJouees) {
			if (dev.getSousTypeCartes() == typeCarte) {
				return dev;
			}
		}
		return null;
	}
	 
	public void set_cartesJouees(SousTypeCartes typeCarte, int nb) {
		for (GroupeCartesDev dev : cartesJouees) {
			if (dev.getSousTypeCartes() == typeCarte) {
				dev.addCartes(nb);
			}
		}
	}
	 
	// TODO definir une methode identique dans Jeu pour les manipulations des cartes de dvpt
	public boolean jouerCartes(SousTypeCartes cartes) {
		return false;
	}
	
	//What is it ?
	public int get_pions(int typePion) {
		return 0;
	}
	 
	//What is it ?
	public boolean acheterCartes() {
		return false;
	}
	
	//n'aurait-elle pas sa place dans Jeu plutot ?
	public boolean deplacerBinomeG(Hexagone HexaInit, Hexagone HexaDest) {
		return false;
	}*/
}
