package lo43.projet.utboheme.hexagone;

import java.util.ArrayList;
import java.util.List;
import lo43.projet.utboheme.jeu.Joueur;

/**
 * Classe repr�sentant un hexagone
 *  - poss�de une coordonn�e x
 *  - poss�de une coordonn�e y
 *  - poss�de une taille
 *  - poss�de un boolean pour savoir s'il a le binome glandeur
 *  - poss�de un type de terrain
 *  - poss�de la liste de ces sommets
 *  - poss�de la liste de ces ar�tes
 *  - poss�de la liste de ces voisins adjacent
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
	private List<Hexagone> voisins;
	
	/**
	 * Constructeur par d�faut
	 */
	public Hexagone() {
		this.xHex = 0;
		this.yHex = 0;
		this.size = 0;
		this.binomeG = false;
		this.typeTerr = null;
		this.sommets = null;
		this.aretes = null;
		this.voisins = null;
	}

	/**
	 * Constructeur param�tr�
	 * @param pindX
	 * @param pindY
	 * @param psize
	 * @param pbinome
	 * @param ptypeT
	 */
	public Hexagone(int pindX, int pindY, int psize, boolean pbinome, TypeTerrain ptypeT) {
		this.xHex = pindX;
		this.yHex = pindY;
		this.size = psize;
		this.binomeG = pbinome;
		this.typeTerr = ptypeT;
		this.InitHexa();
		System.out.println("Cr�ation d'un hexagone '" + this.typeTerr + "' a la position x: " + this.getXHex() + " et y: " + this.getYHex());
	}
	
	/**
	 * M�thode permettant d'initialiser l'hexagone, ces sommets et ces ar�tes
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
	 * M�thode permettant de renvoyer les sommets de l'hexagone qui poss�de une UV 
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
	 * M�thode permettant de renvoyer les ar�tes de l'hexagone qui poss�de un contr�le continu
	 * @return
	 * 	- une liste d'ar�tes
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
	 * M�thode permettant de renvoyer les propri�taires des UVs pr�sentent sur les sommets de l'hexagone
	 * @return
	 * 	_ une liste de joueur
	 */
	public List<Joueur> getSommetUVProprio() {
		List<Joueur> lj = new ArrayList<Joueur>();
		List<Sommet> luv = new ArrayList<Sommet>();
		luv = getSommetsUV();
		for(Sommet s : luv) {
			lj.add(s.getUv().getProprietaire());
		}
		return lj;
	}
	
	/**
	 * M�thode permettant de r�cup�rer les sommets adjacents au sommet pass� en param�tre
	 * @param s
	 * @return
	 *  - une liste de sommets
	 */
	public List<Sommet> getSommetAdjacent(Sommet s) {
		List<Sommet> ls = new ArrayList<Sommet>();
		for(Arete a: aretes) {
			if(a.getsDebut().equals(s)) {
				ls.add(a.getsFin());
			}else if(a.getsFin().equals(s)) {
				ls.add(a.getsDebut());
			}
		}
		for(Hexagone h : voisins) {
			for(Arete va : h.getAretes()) {
				if(va.getsDebut().equals(s)) {
					ls.add(va.getsFin());
				}else if(va.getsFin().equals(s)) {
					ls.add(va.getsDebut());
				}
			}
		}
		return ls;
	}
	
	/**
	 * M�thode permettant de positionner un hexagone selon ces attributs x et y
	 * @param pxHex
	 * @param pyHex
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
	 * Renvoi la position x de l'hexagone
	 * @return
	 *  - un double
	 */
	public double getXHex() {
		return xHex;
	}

	/**
	 * Attribut le param�tre � la position x
	 * @param pxHex
	 */
	public void setXHex(double pxHex) {
		this.xHex = pxHex;
	}
	
	/**
	 * Renvoi la position y de l'hexagone
	 * @return
	 * 	- un double
	 */
	public double getYHex() {
		return yHex;
	}

	/**
	 * Attribut le param�tre � la position y
	 * @param pyHex
	 */
	public void setYHex(double pyHex) {
		this.yHex = pyHex;
	}
	
	/**
	 * Renvoi la taille de l'hexagone 
	 * @return
	 * 	- un double
	 */
	public double getSize() {
		return this.size;
	}
	
	/**
	 * Attribut le param�tre � la taille de l'hexagone
	 * @param psize
	 */
	public void setSize(double psize) {
		this.size = psize;
	}

	/**
	 * Test si l'hexagone poss�de le binome glandeur
	 * @return
	 * 	- un boolean
	 */
	public boolean isBinomeG() {
		return binomeG;
	}

	/**
	 * Attribut le binome glandeur � l'hexagone
	 * @param pbinomeg
	 */
	public void setBinomeG(boolean pbinomeg) {
		this.binomeG = pbinomeg;
	}

	/**
	 * Renvoi le type de terrain de l'hexagone
	 * @return
	 */
	public TypeTerrain getTypeTerr() {
		return typeTerr;
	}
	 
	/**
	 * Renvoi la liste des sommets de l'hexagone
	 * @return
	 * 	- une liste de sommets
	 */
	public List<Sommet> getSommets() {
		return sommets;
	}

	/**
	 * Renvoi la liste des ar�tes de l'hexagone
	 * @return
	 * 	- une liste d'ar�tes
	 */
	public List<Arete> getAretes() {
		return aretes;
	}

}
