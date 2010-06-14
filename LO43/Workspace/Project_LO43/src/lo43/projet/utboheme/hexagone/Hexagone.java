package lo43.projet.utboheme.hexagone;

import java.util.ArrayList;
import java.util.List;
import lo43.projet.utboheme.jeu.Joueur;

/**
 * Classe representant un hexagone
 *  - possede une coordonnee x
 *  - possede une coordonnee y
 *  - possede une taille
 *  - possede un boolean pour savoir s'il a le binome glandeur
 *  - possede un type de terrain
 *  - possede la liste de ses sommets
 *  - possede la liste de ses aretes
 *  - possede la liste de ses voisins adjacent
 * @author alexandreaugen
 *
 */
public class Hexagone {
	
	private double xHex;
	private double yHex;
	private double size;
	 
	private boolean binomeG;
	 
	private TypeTerrain typeTerr;
	private List<Sommet> sommets;
	private List<Arete> aretes;
	
	/**
	 * Constructeur par defaut
	 */
	public Hexagone() {
		this.xHex = 0;
		this.yHex = 0;
		this.size = 0;
		this.binomeG = false;
		this.typeTerr = null;
		this.sommets = null;
		this.aretes = null;
	}

	/**
	 * Constructeur parametre
	 * @param pindX coordonnee en x
	 * @param pindY coordonnee en y
	 * @param psize taille de l'hexagone
	 * @param pbinome si le binome est sur l'hexagone
	 * @param ptypeT type de terrain
	 */
	public Hexagone(int pindX, int pindY, int psize, boolean pbinome, TypeTerrain ptypeT) {
		this.xHex = pindX;
		this.yHex = pindY;
		this.size = psize;
		this.binomeG = pbinome;
		this.typeTerr = ptypeT;
		this.InitHexa();
		System.out.println("Creation d'un hexagone '" + this.typeTerr + "' a la position x: " + this.getXHex() + " et y: " + this.getYHex());
	}
	
	/**
	 * Methode permettant d'initialiser l'hexagone, ses sommets et ses aretes
	 */
	public void InitHexa(){
		this.sommets = new ArrayList<Sommet>();
		this.aretes = new ArrayList<Arete>();
		
		if (this.getYHex() % 2==0) {
			this.setXHex((2 * this.getXHex() + 1) * this.getSize() * Math.cos(Math.toRadians(30)));
			this.setYHex((this.getSize() * 1.5) * this.getYHex() + this.getSize());
		} else {
			this.setXHex((2 * this.getXHex() + 2) * this.getSize() * Math.cos(Math.toRadians(30)));
			this.setYHex((this.getSize() * 1.5) * this.getYHex() + this.getSize());
		}
		
		final double p=this.getSize()/2;
		final double g= this.getSize() * (Math.cos(Math.toRadians(30)));
		
		Sommet sommet1 = new Sommet((int)(this.getXHex()), (int)(this.getYHex() + this.getSize()));
		this.sommets.add(new Sommet((int)(this.getXHex()), (int)(this.getYHex() + this.getSize())));
		
		Sommet sommet2 = new Sommet((int)(this.getXHex() + g), (int)(this.getYHex() + p));
		this.sommets.add(sommet2);
		
		Arete arete1 = new Arete(sommet1, sommet2);
		this.aretes.add(arete1);
		
		Sommet sommet3 = new Sommet((int)(this.getXHex() + g), (int)(this.getYHex() - p));
		this.sommets.add(sommet3);
		
		Arete arete2 = new Arete(sommet2, sommet3);
		this.aretes.add(arete2);
		
		Sommet sommet4 = new Sommet((int)(this.getXHex()), (int)(this.getYHex() - this.getSize()));
		this.sommets.add(sommet4);
		
		Arete arete3 = new Arete(sommet3, sommet4);
		this.aretes.add(arete3);
		
		Sommet sommet5 = new Sommet((int)(this.getXHex() - g), (int)(this.getYHex() - p));
		this.sommets.add(sommet5);
		
		Arete arete4 = new Arete(sommet4, sommet5);
		this.aretes.add(arete4);
		
		Sommet sommet6 = new Sommet((int)(this.getXHex() - g), (int)(this.getYHex() + p));
		this.sommets.add(sommet6);
		
		Arete arete5 = new Arete(sommet5, sommet6);
		this.aretes.add(arete5);
		Arete arete6 = new Arete(sommet6, sommet1);
		this.aretes.add(arete6);
	}
	
	/**
	 * Methode permettant de renvoyer les sommets de l'hexagone qui possedent une UV 
	 * @return
	 * 	- une liste de sommets
	 */
	public List<Sommet> getSommetsUV() {
		List<Sommet> luv = new ArrayList<Sommet>();
		for(Sommet s : sommets){
			if(s.hasUV()){
				luv.add(s);
			}
		}
		return luv;
	}
	
	/**
	 * Methode permettant de renvoyer les sommets de l'hexagone qui possedent une UV** 
	 * @return
	 * 	- une liste de sommets
	 */
	public List<Sommet> getSommetsUVStar() {
		List<Sommet> luvstar = new ArrayList<Sommet>();
		for(Sommet s : sommets){
			if(s.hasUVStar()){
				luvstar.add(s);
			}
		}
		return luvstar;
	}
	 
	/**
	 * Methode permettant de renvoyer les aretes de l'hexagone qui possedent un controle continu
	 * @return
	 * 	- une liste d'aretes
	 */
	public List<Arete> getAretesCC() {
		List<Arete> lcc = new ArrayList<Arete>();
		for (Arete a : aretes){
			if(a.hasCC()){
				lcc.add(a);
			}
		}
		return lcc;
	}
	
	/**
	 * Methode permettant de renvoyer les proprietaires des UVs presentes sur les sommets de l'hexagone
	 * @return
	 * 	_ une liste de joueur
	 */
	public List<Joueur> getSommetUVProprio() {
		List<Joueur> lj = new ArrayList<Joueur>();
		for(Sommet s : getSommetsUV()) {
			lj.add(s.getUv().getProprietaire());
		}
		return lj;
	}
	
	/**
	 * Methode permettant de renvoyer les proprietaires des UV**s presentes sur les sommets de l'hexagone
	 * @return
	 * 	_ une liste de joueur
	 */
	public List<Joueur> getSommetUVStarProprio() {
		List<Joueur> lj = new ArrayList<Joueur>();
		for(Sommet s : getSommetsUVStar()) {
			lj.add(s.getUv().getProprietaire());
		}
		return lj;
	}
	
	/**
	 * Methode permettant de positionner un hexagone selon ses attributs x et y
	 * @return
	 * 	- un hexagone
	 */
	public Hexagone setPosition(int pxHex, int pyHex) {
		this.setXHex(pxHex);
		this.setYHex(pyHex);
		this.InitHexa();
		return this;
	}

	/**
	 * Renvoie la position x de l'hexagone
	 * @return
	 *  - un double
	 */
	public double getXHex() {
		return xHex;
	}

	/**
	 * Attribue le parametre a la position x
	 */
	public void setXHex(double pxHex) {
		this.xHex = pxHex;
	}
	
	/**
	 * Renvoie la position y de l'hexagone
	 * @return
	 * 	- un double
	 */
	public double getYHex() {
		return yHex;
	}

	/**
	 * Attribue le parametre a la position y
	 */
	public void setYHex(double pyHex) {
		this.yHex = pyHex;
	}
	
	/**
	 * Renvoie la taille de l'hexagone 
	 * @return
	 * 	- un double
	 */
	public double getSize() {
		return this.size;
	}
	
	/**
	 * Attribue le parametre a la taille de l'hexagone
	 */
	public void setSize(double psize) {
		this.size = psize;
	}

	/**
	 * Teste si l'hexagone possede le binome glandeur
	 * @return
	 * 	- un boolean
	 */
	public boolean isBinomeG() {
		return binomeG;
	}

	/**
	 * Attribue le binome glandeur a l'hexagone
	 */
	public void setBinomeG(boolean pbinomeg) {
		this.binomeG = pbinomeg;
	}

	/**
	 * Renvoie le type de terrain de l'hexagone
	 */
	public TypeTerrain getTypeTerr() {
		return typeTerr;
	}
	 
	/**
	 * Renvoie la liste des sommets de l'hexagone
	 * @return
	 * 	- une liste de sommets
	 */
	public List<Sommet> getSommets() {
		return sommets;
	}

	/**
	 * Renvoie la liste des aretes de l'hexagone
	 * @return
	 * 	- une liste d'aretes
	 */
	public List<Arete> getAretes() {
		return aretes;
	}

	/**
	 * Teste si une arete adjacente au sommet s possede un controle continu
	 * du joueur j
	 * @param s
	 * @param j
	 * @return
	 * 	- un boolean
	 */
	public boolean AreteHasCC(Sommet s, Joueur j) {
		boolean res = false;
		for(Arete a : aretes) {
			if (a.getsDebut() == s || a.getsFin() == s) {
				if(a.hasCC() && a.getControleC().getProprietaire() == j) {
					res = true;
					break;
				}
			}
		}
		return res;
	}

}
