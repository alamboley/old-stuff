package lo43.projet.utboheme.jeu;

import java.util.ArrayList;

import lo43.projet.utboheme.arbre.ArbreBinaire;
import lo43.projet.utboheme.carte.GroupeCartes;
import lo43.projet.utboheme.carte.GroupeCartesDev;
import lo43.projet.utboheme.carte.SousTypeCartes;
import lo43.projet.utboheme.carte.TypeCartes;
import lo43.projet.utboheme.hexagone.Arete;
import lo43.projet.utboheme.hexagone.Hexagone;
import lo43.projet.utboheme.hexagone.Sommet;

public class Joueur {
	
	private int idJoueur;
	private String nom;
	private String couleur;
	private byte nbPoints;
	private boolean ancien;
	private boolean cursus;
	private ArrayList<GroupeCartes> cartes;
	private ArrayList<GroupeCartesDev> cartesJouees;
	private int nbUV;
	private int nbUVStar;
	private int nbCC;
	private ArrayList<ArbreBinaire> chemins;
	
	public Joueur() {
		idJoueur = 0;
		nom = null;
		couleur = null;
		nbPoints = 0;
		ancien = false;
		cursus = false;
		nbUV = 5;
		nbUVStar = 4;
		nbCC = 15;
		cartes = new ArrayList<GroupeCartes>();
		// Biere ---> indice 0
		cartes.add(new GroupeCartes(0, TypeCartes.BIERE));
		// Cafe ---> indice 1
		cartes.add(new GroupeCartes(0, TypeCartes.CAFE));
		// Nourriture ---> indice 2
		cartes.add(new GroupeCartes(0, TypeCartes.NOURRITURE));
		// Sommeil ---> indice 3
		cartes.add(new GroupeCartes(0, TypeCartes.SOMMEIL));
		// Support ---> indice 4
		cartes.add(new GroupeCartes(0, TypeCartes.SUPPORT));
		cartesJouees = new ArrayList<GroupeCartesDev>();
		
	}
	
	public Joueur(int id) {
		this();
		idJoueur = id;
	}
	
	 
	public int getIdJoueur() {
		return idJoueur;
	}

	public void setIdJoueur(int idJoueur) {
		this.idJoueur = idJoueur;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getCouleur() {
		return couleur;
	}

	public void setCouleur(String couleur) {
		this.couleur = couleur;
	}

	public byte getNbPoints() {
		return nbPoints;
	}

	public void setNbPoints(byte nbPoints) {
		this.nbPoints = nbPoints;
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

	public ArrayList<GroupeCartes> getCartes() {
		return cartes;
	}

	public void setCartes(ArrayList<GroupeCartes> cartes) {
		this.cartes = cartes;
	}

	public ArrayList<GroupeCartesDev> getCartesJouees() {
		return cartesJouees;
	}

	public void setCartesJouees(ArrayList<GroupeCartesDev> cartesJouees) {
		this.cartesJouees = cartesJouees;
	}

	public int getNbUV() {
		return nbUV;
	}

	public void setNbUV(int nbUV) {
		this.nbUV = nbUV;
	}

	public int getNbUVStar() {
		return nbUVStar;
	}

	public void setNbUVStar(int nbUVStar) {
		this.nbUVStar = nbUVStar;
	}

	public int getNbCC() {
		return nbCC;
	}

	public void setNbCC(int nbCC) {
		this.nbCC = nbCC;
	}

	public ArrayList<ArbreBinaire> getChemins() {
		return chemins;
	}

	public void setChemins(ArrayList<ArbreBinaire> chemins) {
		this.chemins = chemins;
	}

	public boolean construireUV(Sommet sommet, boolean etoile) {
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
		return null;
	}
	 
	public boolean decouverte(TypeCartes type1, TypeCartes type2) {
		return false;
	}
	 
	public boolean monopole(TypeCartes typeRess) {
		return false;
	}
	 
	public boolean volerCarte(Joueur joueur) {
		return false;
	}
	 
	 
	public GroupeCartesDev get_cartesJouees(SousTypeCartes typeCarte) {
		return null;
	}
	 
	public void set_cartesJouees(TypeCartes typeCarte, int nb) {
	 
	}
	 
	public boolean jouerCartes(SousTypeCartes cartes) {
		return false;
	}
	 
	public int get_pions(int typePion) {
		return 0;
	}
	 
	public boolean acheterCartes() {
		return false;
	}
	 
	public boolean deplacerBinomeG(Hexagone HexaInit, Hexagone HexaDest) {
		return false;
	}
}
