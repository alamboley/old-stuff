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

/**
 * Classe repr�sentant un joueur
 * 	- poss�de un identifiant
 *  - poss�de un nom
 *  - poss�de une couleur
 *  - poss�de un nombre de point de victoire
 *  - poss�de un attribut pour rep�rer s'il poss�de ancien plus vieu
 *  - poss�de un attribut pour rep�rer s'il poss�de cursus plus long
 *  - poss�de un attribut pour savoir s'il est actif
 *  - poss�de une liste de groupe de cartes (ressource et d�veloppement)
 *  - poss�de une liste de groupe de cartes de developpement d�j� jou�es
 *  - poss�de une liste de contr�le continu 
 *  - poss�de une liste d'uv
 *  - poss�de une liste d'uv**
 *  - poss�de une liste de chemin pour cursus plus long
 * @author alexandreaugen
 *
 */
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
	
	/**
	 * Constructeur par d�faut
	 */
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
	
	/**
	 * Constructeur param�tr�
	 * @param pident
	 * @param pnom
	 * @param pc
	 */
	public Joueur(Integer pident, String pnom, Color pc) {
		this();
		this.ident = pident;
		this.nom = pnom;
		this.couleur = pc;
		
		//Attribution par d�faut des diff�rents groupes de cartes vide
		this.lcartes = new ArrayList<GroupeCartes>();
		lcartes.add(new GroupeCartes(4, TypeCartes.BIERE));
		lcartes.add(new GroupeCartes(4, TypeCartes.SOMMEIL));
		lcartes.add(new GroupeCartes(4, TypeCartes.CAFE));
		lcartes.add(new GroupeCartes(4, TypeCartes.SUPPORT));
		lcartes.add(new GroupeCartes(4, TypeCartes.NOURRITURE));

		this.lcartesJouees = new ArrayList<GroupeCartesDev>();
		this.luvstar = new ArrayList<UV>();
		this.luv = new ArrayList<UV>();
		this.lcc = new ArrayList<Pion>();
		
		//Attribution par d�faut des diff�rents pions du joueurs
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

	/**
	 * Renvoi l'identifiant du joueur
	 * @return
	 * 	- un entier
	 */
	public int getIdent() {
		return ident;
	}

	/**
	 * Renvoi le nom du joueur
	 * @return
	 * 	- un string
	 */
	public String getNom() {
		return nom;
	}

	/**
	 * Attribut le param�tre au nom au joueur 
	 * @param nom
	 */
	public void setNom(String nom) {
		this.nom = nom;
	}

	/**
	 * Renvoi la couleur associ� au joueur
	 * @return
	 * 	- une couleur
	 */
	public Color getCouleur() {
		return couleur;
	}

	/**
	 * Attribut le param�tre � la couleur associ� au joueur
	 * @param c
	 */
	public void setCouleur(Color c) {
		this.couleur = c;
	}

	/**
	 * Renvoi le nombre de points de victoire du joueur
	 * @return
	 * 	- un entier
	 */
	public int getNbPoints() {
		return nbPoints;
	}
	
	/**
	 * M�thode permettant d'ajouter un nombre "nb" au point de victoire du joueur
	 * @param nb
	 */
	public void addNbPoints(int nb) {
		this.nbPoints += nb;
	}

	/**
	 * Test si le joueur poss�de la carte ancien le plus vieu
	 * @return
	 */
	public boolean isAncien() {
		return ancien;
	}

	/**
	 * Attribut ancien le plus vieu au joueur ou enleve
	 * @param ancien
	 */
	public void setAncien(boolean ancien) {
		this.ancien = ancien;
	}

	/**
	 * Test si le joueur poss�de la carte cursus le plus long
	 * @return
	 */
	public boolean isCursus() {
		return cursus;
	}

	/**
	 * Attribut cursus le plus long au joueur ou enleve
	 * @param cursus
	 */
	public void setCursus(boolean cursus) {
		this.cursus = cursus;
	}

	/**
	 * Test si le joueur est actif
	 * @return
	 */
	public boolean isActif() {
		return actif;
	}

	/**
	 * Attribut le joueur comme joueur actif ou non actif
	 * @param actif
	 */
	public void setActif(boolean actif) {
		this.actif = actif;
	}
	
	/**
	 * M�thode permettant de renvoyer un groupe de cartes du stock du joueur selon le type pass� en param�tre
	 * @param ptype
	 * @return
	 * 	- un groupe de cartes
	 */
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
	
	/**
	 * M�thode permettant d'attribuer un nombre de cartes "nbCartes" au type du groupe de cartes pass� en param�tre 
	 * @param ptype
	 * @param nbCartes
	 */
	public void AugmGroupeCarte(TypeCartes ptype, int nbCartes) {
		this.getGroupeCartes(ptype).addCartes(nbCartes);
	}
	
	public void DimGroupeCarte(TypeCartes ptypeC, int pnb) {
		this.getGroupeCartes(ptypeC).remCartes(pnb);
		if(getGroupeCartes(ptypeC).getNombre() < 0) 
			this.getGroupeCartes(ptypeC).setNombre(0);
	}
	
	public void MoveAllCartes(TypeCartes type){
		this.getGroupeCartes(type).remCartes(getGroupeCartes(type).getNombre());
	}

	/**
	 * Renvoi la liste des contr�les continu du joueur
	 * @return
	 * 	- une liste de pions
	 */
	public List<Pion> getLcc() {
		return lcc;
	}
	
	public void addCC(Pion p) {
		this.lcc.add(p);
	}
	
	public void remCC() {
		this.lcc.remove(0);
	}
	
	public Pion getCC() {
		return this.lcc.get(0);
	}
	
	/**
	 * Renvoi la liste des uv du joueur
	 * @return
	 * 	- une liste d'uv
	 */
	public List<UV> getLuv() {
		return luv;
	}
	
	public void addUV(UV puv) {
		this.luv.add(puv);
	}
	
	public void remUV() {
		this.luv.remove(0);
	}
	
	public UV getUV() {
		return this.luv.get(0);
	}
	
	/**
	 * Renvoi la liste des uv** du joueur
	 * @return
	 * 	- une liste d'uv**
	 */
	public List<UV> getLuvstar() {
		return luvstar;
	}
	
	public void addUVStar(UV puvstar) {
		this.luvstar.add(puvstar);
	}
	
	public void remUVStar() {
		this.luvstar.remove(0);
	}
	
	public UV getUVStar() {
		return this.luvstar.get(0);
	}

	/**
	 * Renvoi la nombre d'uv du joueur
	 * @return
	 * 	- un entier
	 */
	public int getNbUV() {
		return luv.size();
	}

	/**
	 * Renvoi le nombre d'uv** du joueur
	 * @return
	 * 	- un entier
	 */
	public int getNbUVStar() {
		return luvstar.size();
	}

	/**
	 * Renvoi le nombre de contr�le continu du joueur
	 * @return
	 * 	- un entier
	 */
	public int getNbCC() {
		return lcc.size();
	}
	
	/**
	 * Renvoi le nombre des cartes d'un ensemble de groupe de cartes du type pass� en param�tre
	 * @param ptype
	 * @return
	 * 	- un entier
	 */
	public int getNbCartes(TypeCartes ptype) {
		return this.getGroupeCartes(ptype).getNombre();
	}

	public List<ArbreBinaire> getChemins() {
		return chemins;
	}

	public void setChemins(List<ArbreBinaire> chemins) {
		this.chemins = chemins;
	}
	
	public boolean TestRess(Pion p) {
		boolean res = false;
		if(p.getClass() == UV.class) {
			UV uv = (UV) p;
			if(uv.isDoubleEtoile()) {
				if(getNbCartes(TypeCartes.SUPPORT) >= 2 && getNbCartes(TypeCartes.SOMMEIL) >= 3) {
					res = true;
				}
			}else{
				if(getNbCartes(TypeCartes.BIERE) >= 1 && getNbCartes(TypeCartes.NOURRITURE) >= 1 && getNbCartes(TypeCartes.SUPPORT) >=1 && getNbCartes(TypeCartes.CAFE) >= 1) {
					res = true;
				}
			}
		}else if(p.getClass() == Pion.class) {
			if(getNbCartes(TypeCartes.BIERE) >= 1 && getNbCartes(TypeCartes.NOURRITURE) >= 1) {
				res = true;
			}
		}
		return res;
	}
	
	public void remRess(Pion p) {
		if(p.getClass() == UV.class) {
			UV uv = (UV) p;
			if(uv.isDoubleEtoile()) {
				if(getNbCartes(TypeCartes.SUPPORT) >= 2 && getNbCartes(TypeCartes.SOMMEIL) >= 3) {
					this.DimGroupeCarte(TypeCartes.SUPPORT, 2);
					this.DimGroupeCarte(TypeCartes.SOMMEIL, 3);
				}
			}else{
				if(getNbCartes(TypeCartes.BIERE) >= 1 && getNbCartes(TypeCartes.NOURRITURE) >= 1 && getNbCartes(TypeCartes.SUPPORT) >=1 && getNbCartes(TypeCartes.CAFE) >= 1) {
					this.DimGroupeCarte(TypeCartes.BIERE, 1);
					this.DimGroupeCarte(TypeCartes.NOURRITURE, 1);
					this.DimGroupeCarte(TypeCartes.SUPPORT, 1);
					this.DimGroupeCarte(TypeCartes.CAFE, 1);
				}
			}
		}else if(p.getClass() == Pion.class) {
			if(getNbCartes(TypeCartes.BIERE) >= 1 && getNbCartes(TypeCartes.NOURRITURE) >= 1) {
				this.DimGroupeCarte(TypeCartes.BIERE, 1);
				this.DimGroupeCarte(TypeCartes.NOURRITURE, 1);
			}
		}
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
