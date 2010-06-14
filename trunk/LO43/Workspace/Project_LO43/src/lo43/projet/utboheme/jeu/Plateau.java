package lo43.projet.utboheme.jeu;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import lo43.projet.utboheme.carte.TypeCartes;
import lo43.projet.utboheme.hexagone.Arete;
import lo43.projet.utboheme.hexagone.HexaRessource;
import lo43.projet.utboheme.hexagone.HexaZoneTroc;
import lo43.projet.utboheme.hexagone.Hexagone;
import lo43.projet.utboheme.hexagone.Jeton;
import lo43.projet.utboheme.hexagone.Sommet;
import lo43.projet.utboheme.hexagone.TypeTerrain;

/**
 * Classe representant le plateau du jeu
 * 	- possede une taille
 *  - possede une liste d'hexagones
 * @author alexandreaugen
 *
 */
public class Plateau {
	
	private int sizeHexa;
	private List<Hexagone> hexagones;
	
	/**
	 * Constructeur par defaut
	 */
	public Plateau() {
		this.sizeHexa = 0;
		this.hexagones = null;
	}
		
	/**
	 * Constructeur parametre
	 * @param psize
	 */
	public Plateau(int psize) {
		this.sizeHexa = psize;
		
		this.InitHexa();
	}
	
	/**
	 * Methode permettant d'initialiser la liste des hexagones 
	 */
	public void InitHexa() {
		
		this.hexagones = new ArrayList<Hexagone>();
		
		List<HexaRessource> lHexaRess = new ArrayList<HexaRessource>();
		List<Hexagone> lHexaZoneT = new ArrayList<Hexagone>();
		List<Jeton> lJetons = new ArrayList<Jeton>();
		int typeTroc;
		TypeTerrain typeRess;
		TypeCartes typeCar;
		int numJeton = 2;
		
		//Hexagone de zone de troc
		for(int i=0; i<9; i++) {
			typeTroc = (i < 5) ? 2 : 3;
			lHexaZoneT.add(new HexaZoneTroc(0, 0, this.getSizeHexa(), false, TypeTerrain.ZONETROC, typeTroc, TypeCartes.random()));
			
		}
		//On melange la liste
		lHexaZoneT = melanger(lHexaZoneT);
		
		//Creation des Jetons
		lJetons.add(new Jeton(numJeton));
		for(int i=0; i<9; i++) {
			numJeton++;
			if(i != 4) {
				lJetons.add(new Jeton(numJeton));
				lJetons.add(new Jeton(numJeton));
			}
		}
		lJetons.add(new Jeton(++numJeton));
		//On melange la liste
		lJetons = melangerJeton(lJetons);
		
		//Hexagone de ressource
		for(int i=0; i<18; i++) {
			typeRess = (i < 4) ? TypeTerrain.BARS : (i >= 4 && i < 7) ? TypeTerrain.LIEUREPOS : (i >= 7 && i < 11) ? TypeTerrain.FOURNISSEURCAFE : (i >= 11 && i < 15) ? TypeTerrain.LIEUXCOURS : TypeTerrain.RESTAURANT;
			typeCar = (i < 4) ? TypeCartes.BIERE : (i >= 4 && i < 7) ? TypeCartes.SOMMEIL : (i >= 7 && i < 11) ? TypeCartes.CAFE : (i >= 11 && i < 15) ? TypeCartes.SUPPORT : TypeCartes.NOURRITURE;
			lHexaRess.add(new HexaRessource(0, 0, this.getSizeHexa(), false, typeRess, typeCar, null));
		}
		//On melange la liste
		lHexaRess = melangerRess(lHexaRess);
		
		//Selon le dessin de positionnement : ligne 1
		hexagones.add(lHexaRess.get(0).setPosition(3, 2).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(3, 3).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(new Hexagone(4, 4, this.getSizeHexa(), true, TypeTerrain.DESERT));
		hexagones.add(lHexaRess.get(0).setPosition(4, 5).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(5, 6).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		
		//Selon le dessin de positionnement : ligne 2 droite
		hexagones.add(lHexaRess.get(0).setPosition(4, 2).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(4, 3).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(5, 4).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(5, 5).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		
		//Selon le dessin de positionnement : ligne 2 : gauche
		hexagones.add(lHexaRess.get(0).setPosition(2, 3).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(3, 4).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(3, 5).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(4, 6).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		
		//Selon le dessin de positionnement : ligne 3 : droite 
		hexagones.add(lHexaRess.get(0).setPosition(5, 2).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(5, 3).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(6, 4).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		
		//Selon le dessin de positionnement : ligne 3 : gauche 
		hexagones.add(lHexaRess.get(0).setPosition(2, 4).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(2, 5).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(3, 6).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		
		//Selon le dessin de positionnement : Zones de troc
		hexagones.add(lHexaZoneT.get(0).setPosition(2, 1));
		lHexaZoneT.remove(0);
		hexagones.add(lHexaZoneT.get(0).setPosition(4, 1));
		lHexaZoneT.remove(0);
		hexagones.add(lHexaZoneT.get(0).setPosition(6, 2));
		lHexaZoneT.remove(0);
		hexagones.add(lHexaZoneT.get(0).setPosition(7, 4));
		lHexaZoneT.remove(0);
		hexagones.add(lHexaZoneT.get(0).setPosition(6, 6));
		lHexaZoneT.remove(0);
		hexagones.add(lHexaZoneT.get(0).setPosition(4, 7));
		lHexaZoneT.remove(0);
		hexagones.add(lHexaZoneT.get(0).setPosition(2, 7));
		lHexaZoneT.remove(0);
		hexagones.add(lHexaZoneT.get(0).setPosition(1, 5));
		lHexaZoneT.remove(0);
		hexagones.add(lHexaZoneT.get(0).setPosition(1, 3));
		lHexaZoneT.remove(0);
		
		//Selon le dessin de positionnement : Remparts
		hexagones.add(new Hexagone(2, 2, this.getSizeHexa(), false, TypeTerrain.REMPART));
		hexagones.add(new Hexagone(3, 1, this.getSizeHexa(), false, TypeTerrain.REMPART));
		hexagones.add(new Hexagone(5, 1, this.getSizeHexa(), false, TypeTerrain.REMPART));
		hexagones.add(new Hexagone(6, 3, this.getSizeHexa(), false, TypeTerrain.REMPART));
		hexagones.add(new Hexagone(6, 5, this.getSizeHexa(), false, TypeTerrain.REMPART));
		hexagones.add(new Hexagone(5, 7, this.getSizeHexa(), false, TypeTerrain.REMPART));
		hexagones.add(new Hexagone(3, 7, this.getSizeHexa(), false, TypeTerrain.REMPART));
		hexagones.add(new Hexagone(2, 6, this.getSizeHexa(), false, TypeTerrain.REMPART));
		hexagones.add(new Hexagone(1, 4, this.getSizeHexa(), false, TypeTerrain.REMPART));
		
	}
	
	/**
	 * Renvoi la taille d'un hexagone
	 * @return
	 * 	- un entier
	 */
	public int getSizeHexa() {
		return sizeHexa;
	}

	/**
	 * Renvoi la liste des hexagones du plateau
	 * @return
	 *	- une liste d'hexagone
	 */
	public List<Hexagone> getHexagones() {
		return this.hexagones;
	}
	
	/**
	 * Renvoi la largeur du plateau
	 * @return
	 * 	- un entier
	 */
	public int getWidth() {
		return 15 * this.getSizeHexa();
	}
	
	/**
	 * Renvoi la longeur du plateau
	 * @return
	 * 	- un entier
	 */
	public int getHeight() {
		return 13 * this.getSizeHexa();
	}
	
	/**
	 * Methode pour melanger une liste d'hexagones
	 * @param listeD
	 * @return
	 * 	- une liste d'hexagones
	 */
	public List<Hexagone> melanger(List<Hexagone> listeD){
		List<Hexagone> ListeR = new ArrayList<Hexagone>(listeD);
		Collections.shuffle(ListeR);
		return ListeR;
	}
	
	/**
	 * Methode pour melanger une liste de jetons
	 * @param listeD
	 * @return
	 * 	- une liste de jetons
	 */
	public List<Jeton> melangerJeton(List<Jeton> listeD){
		List<Jeton> ListeR = new ArrayList<Jeton>(listeD);
		Collections.shuffle(ListeR);
		return ListeR;
	}
	
	/**
	 * Methode pour melanger une liste d'hexagones de ressource
	 * @param listeD
	 * @return
	 * 	- une liste d'hexagones de ressource
	 */
	public List<HexaRessource> melangerRess(List<HexaRessource> listeD){
		List<HexaRessource> ListeR = new ArrayList<HexaRessource>(listeD);
		Collections.shuffle(ListeR);
		return ListeR;
	}
	 
	/**
	 * Methode qui renvoi l'hexagone qui possede le binome glandeur
	 * @return
	 * 	- un hexagone
	 */
	public Hexagone getHexaBinomeG() {
		Hexagone hexRes = new Hexagone();
		for (Hexagone h : this.getHexagones()) {
			if(h.isBinomeG()) {
				hexRes = h;
				break;
			}
		}
		return hexRes;
	}
	
	/**
	 * Methode qui renvoi la liste des hexagones classiques
	 * @return
	 * 	- une liste d'hexagone
	 */
	public List<Hexagone> getHexaClass() {
		List<Hexagone> lHexa = new ArrayList<Hexagone>();
		for(Hexagone h : this.getHexagones()) {
			if(h.getClass() == Hexagone.class) {
				lHexa.add(h);
			}
		}
		return lHexa;
	}
	
	/**
	 * Methode qui renvoi la liste des hexagones de ressource
	 * @return
	 * 	- une liste d'hexagone de ressource
	 */
	public List<HexaRessource> getHexaRess() {
		List<HexaRessource> lHexaR = new ArrayList<HexaRessource>();
		for(Hexagone h : this.getHexagones()) {
			if(h.getClass() == HexaRessource.class) {
				lHexaR.add((HexaRessource) h);
			}
		}
		return lHexaR;
	}
	
	/**
	 * Methode qui renvoi la liste des hexagones de zone de troc
	 * @return
	 * 	- une liste d'hexagone de zone de troc
	 */
	public List<HexaZoneTroc> getHexZoneT() {
		List<HexaZoneTroc> lHexaZ = new ArrayList<HexaZoneTroc>();
		for(Hexagone h : this.getHexagones()) {
			if(h.getClass() == HexaZoneTroc.class) {
				lHexaZ.add((HexaZoneTroc) h);
			} 
		}
		return lHexaZ;
	}
	 
	/**
	 * Methode qui renvoi une liste d'hexagone de ressource selon le nombre du jeton associe et le nombre passe en parametre
	 * @param pnum
	 * @return
	 * 	- une liste d'hexagone de ressource
	 */
	public List<HexaRessource> getHexaByNum(int pnum) {
		List<HexaRessource> lHexaR = new ArrayList<HexaRessource>();
		for(HexaRessource h : this.getHexaRess()) {
			if(h.getJeton().getNumero() == pnum) {
				lHexaR.add(h);
			}
		}
		return lHexaR;
	}
	 
	/**
	 * Methode qui renvoi une liste d'hexagones de zone de troc selon le UV du joueur passe en parametre present sur les hexagones
	 * @param pjoueur
	 * @return
	 * 	- une liste d'hexagone de zone de troc
	 */
	public List<HexaZoneTroc> getZoneTroc(Joueur pjoueur) {
		List<HexaZoneTroc> lHexaZ = new ArrayList<HexaZoneTroc>();
		for(HexaZoneTroc h : this.getHexZoneT()) {
			if(h.getSommetUVProprio().contains(pjoueur)) {
				lHexaZ.add(h);
			}
		}
		return lHexaZ;
	}
	
	/**
	 * Methode qui renvoi une liste d'hexagones de ressource qui possedent une UV selon le numero passe en parametre
	 * @param pnum
	 * @return
	 */
	public List<HexaRessource> getHexaRessWithUv(int pnum) {
		List<HexaRessource> lHexaWithUv = new ArrayList<HexaRessource>();
		for(HexaRessource h : this.getHexaByNum(pnum)) {
			if(!h.getSommetsUV().isEmpty()) {
				lHexaWithUv.add(h);
			}
		}
		return lHexaWithUv;
	}
		
	// TODO appeler la fonction correspondante dans Jeu avec le sommet en parametre
	public boolean constructionUV (Sommet s) {
		return false;
	}
	
	// TODO appeler la fonction correspondante dans Jeu avec le sommet en parametre
	public boolean constructionCC (Arete a) {
		return false;
	}
}
