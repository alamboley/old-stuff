package lo43.projet.utboheme.jeu;

import java.awt.Color;
import java.util.ArrayList;
import java.util.List;

import lo43.projet.utboheme.arbre.ArbreBinaire;
import lo43.projet.utboheme.carte.GroupeCartes;
import lo43.projet.utboheme.carte.GroupeCartesDev;
import lo43.projet.utboheme.carte.SousTypeCartes;
import lo43.projet.utboheme.carte.TypeCartes;
import lo43.projet.utboheme.pion.Pion;
import lo43.projet.utboheme.pion.UV;

/**
 * Classe representant un joueur
 * 	- possede un identifiant
 *  - possede un nom
 *  - possede une couleur
 *  - possede un nombre de point de victoire
 *  - possede un attribut pour reperer s'il possede ancien plus vieu
 *  - possede un attribut pour reperer s'il possede cursus plus long
 *  - possede un attribut pour savoir s'il est actif
 *  - possede une liste de groupe de cartes (ressource et developpement)
 *  - possede une liste de groupe de cartes de developpement dejˆ jouees
 *  - possede une liste de controle continu 
 *  - possede une liste d'uv
 *  - possede une liste d'uv**
 *  - possede une liste de chemin pour cursus plus long
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
	 * Constructeur par defaut
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
	 * Constructeur parametre
	 * @param pident
	 * @param pnom
	 * @param pc
	 */
	public Joueur(Integer pident, String pnom, Color pc) {
		this();
		this.ident = pident;
		this.nom = pnom;
		this.couleur = pc;
		
		//Attribution par defaut des differents groupes de cartes vide
		this.lcartes = new ArrayList<GroupeCartes>();
		lcartes.add(new GroupeCartes(0, TypeCartes.BIERE));
		lcartes.add(new GroupeCartes(0, TypeCartes.SOMMEIL));
		lcartes.add(new GroupeCartes(0, TypeCartes.CAFE));
		lcartes.add(new GroupeCartes(0, TypeCartes.SUPPORT));
		lcartes.add(new GroupeCartes(0, TypeCartes.NOURRITURE));
		lcartes.add(new GroupeCartesDev(0, TypeCartes.DEVELOPPEMENT, SousTypeCartes.ANCIEN));
		lcartes.add(new GroupeCartesDev(0, TypeCartes.DEVELOPPEMENT, SousTypeCartes.CONSTRUCTIONCC));
		lcartes.add(new GroupeCartesDev(0, TypeCartes.DEVELOPPEMENT, SousTypeCartes.DECOUVERTE));
		lcartes.add(new GroupeCartesDev(0, TypeCartes.DEVELOPPEMENT, SousTypeCartes.MONOPOLE));
		lcartes.add(new GroupeCartesDev(0, TypeCartes.DEVELOPPEMENT, SousTypeCartes.POINTVICTOIRE));

		this.lcartesJouees = new ArrayList<GroupeCartesDev>();
		lcartesJouees.add(new GroupeCartesDev(4, TypeCartes.DEVELOPPEMENT, SousTypeCartes.ANCIEN));
		lcartesJouees.add(new GroupeCartesDev(0, TypeCartes.DEVELOPPEMENT, SousTypeCartes.CONSTRUCTIONCC));
		lcartesJouees.add(new GroupeCartesDev(0, TypeCartes.DEVELOPPEMENT, SousTypeCartes.DECOUVERTE));
		lcartesJouees.add(new GroupeCartesDev(0, TypeCartes.DEVELOPPEMENT, SousTypeCartes.MONOPOLE));
		lcartesJouees.add(new GroupeCartesDev(0, TypeCartes.DEVELOPPEMENT, SousTypeCartes.POINTVICTOIRE));
		this.luvstar = new ArrayList<UV>();
		this.luv = new ArrayList<UV>();
		this.lcc = new ArrayList<Pion>();
		
		//Attribution par defaut des differents pions du joueurs
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
	 * Attribut le parametre au nom au joueur 
	 * @param nom
	 */
	public void setNom(String nom) {
		this.nom = nom;
	}

	/**
	 * Renvoi la couleur associe au joueur
	 * @return
	 * 	- une couleur
	 */
	public Color getCouleur() {
		return couleur;
	}

	/**
	 * Attribut le parametre ˆ la couleur associe au joueur
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
	 * Methode permettant d'ajouter un nombre "nb" au point de victoire du joueur
	 * @param nb
	 */
	public void addNbPoints(int nb) {
		this.nbPoints += nb;
	}

	/**
	 * Test si le joueur possede la carte ancien le plus vieu
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
	 * Test si le joueur possede la carte cursus le plus long
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
	 * Methode permettant de renvoyer un groupe de cartes du stock du joueur selon le type passe en parametre
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
	 * Methode permettant d'attribuer un nombre de cartes "nbCartes" au type du groupe de cartes passe en parametre 
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
	
	public GroupeCartes MoveAllCartes(TypeCartes type){
		GroupeCartes gc = new GroupeCartes(getGroupeCartes(type).getNombre(), type);
		this.getGroupeCartes(type).remCartes(getGroupeCartes(type).getNombre());
		return gc;
	}
	
	public void AugmenterGroupeCarteDev(SousTypeCartes sstype, int nb) {
		this.getGroupeCartesDev(sstype).addCartes(nb);
	}
	
	public void DimGroupeCarteDev(SousTypeCartes sstype, int nb) {
		this.getGroupeCartesDev(sstype).remCartes(nb);
		if(getGroupeCartesDev(sstype).getNombre() < 0) 
			this.getGroupeCartesDev(sstype).setNombre(0);
	}
	

	/**
	 * Renvoi la liste des controles continu du joueur
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
	 * Renvoi le nombre de controle continu du joueur
	 * @return
	 * 	- un entier
	 */
	public int getNbCC() {
		return lcc.size();
	}
	
	/**
	 * Renvoi le nombre des cartes d'un ensemble de groupe de cartes du type passe en parametre
	 * @param ptype
	 * @return
	 * 	- un entier
	 */
	public int getNbCartes(TypeCartes ptype) {
		return this.getGroupeCartes(ptype).getNombre();
	}
	
	public int getNbCartesRessTotal(){
		int res = 0;
		for(GroupeCartes gc : getGroupeCartesRess()){
			res += gc.getNombre();
		}
		return res;
	}
	
	public List<GroupeCartes> getGroupeCartesRess() {
		List<GroupeCartes> liste = new ArrayList<GroupeCartes>();
		for(GroupeCartes g : lcartes) {
			if(g.getTypeCartes() != TypeCartes.DEVELOPPEMENT) {
				liste.add(g);
			}
		}
		return liste;
	}
	
	public List<GroupeCartes> getGroupeCartesDev() {
		List<GroupeCartes> liste = new ArrayList<GroupeCartes>();
		for(GroupeCartes g : lcartes) {
			if(g.getTypeCartes() == TypeCartes.DEVELOPPEMENT){
				liste.add(g);
			}
		}
		return liste;
	}
	
	public GroupeCartes getGroupeCartesDev(SousTypeCartes sstype) {
		GroupeCartes gc = new GroupeCartes();
		for (GroupeCartes g : getGroupeCartesDev()) {
			GroupeCartesDev gcd = (GroupeCartesDev) g;
			if(gcd.getSousTypeCartes() == sstype) {
				gc = gcd;
				break;
			}
		}
		return gc;
	}
	
	public GroupeCartes getGroupeCartesDevJoue(SousTypeCartes sstype) {
		GroupeCartes gc = new GroupeCartes();
		for (GroupeCartesDev g : lcartesJouees) {
			if(g.getSousTypeCartes() == sstype) {
				gc = g;
				break;
			}
		}
		return gc;
	}
	
	public int getNbCartesDev(SousTypeCartes sstype) {
		int res = 0;
		for(GroupeCartes gc : getGroupeCartesDev()) {
			GroupeCartesDev gcd = (GroupeCartesDev) gc;
			if(gcd.getSousTypeCartes() == sstype){
				res = gcd.getNombre();
				break;
			}
		}
		return res;
	}
	
	public int getNbCartesDevJoue(SousTypeCartes sstype) {
		int res = 0;
		for(GroupeCartesDev gcd : lcartesJouees) {
			if(gcd.getSousTypeCartes() == sstype){
				res = gcd.getNombre();
				break;
			}
		}
		return res;
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
	
	public boolean payCartesDev() {
		boolean res = false;
		if(getNbCartes(TypeCartes.SUPPORT) >= 1 && getNbCartes(TypeCartes.CAFE) >= 1 && getNbCartes(TypeCartes.SOMMEIL) >= 1) {
			this.DimGroupeCarte(TypeCartes.SUPPORT, 1);
			this.DimGroupeCarte(TypeCartes.CAFE, 1);
			this.DimGroupeCarte(TypeCartes.SOMMEIL, 1);
			res = true;
		}
		return res;
	}
	
	public void jouerCarteDev(SousTypeCartes sstype) {
		DimGroupeCarteDev(sstype, 1);
		for(GroupeCartesDev gcd : lcartesJouees) {
			if(gcd.getSousTypeCartes() == sstype) {
				gcd.addCartes(1);
				break;
			}
		}
	}

}
