package lo43.projet.utboheme.hexagone;

import java.util.ArrayList;
import java.util.List;
import lo43.projet.utboheme.jeu.Joueur;

public class Hexagone {
	
	private double xHex;
	private double yHex;
	private double size;
	 
	private boolean binomeG;
	 
	private TypeTerrain typeTerr;
	private List<Sommet> sommets;
	private List<Arete> aretes;
	private List<Hexagone> voisins;
	
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
	
	public Hexagone(int pindX, int pindY, int psize, boolean pbinome, TypeTerrain ptypeT) {
		this.xHex = pindX;
		this.yHex = pindY;
		this.size = psize;
		this.binomeG = pbinome;
		this.typeTerr = ptypeT;
		this.InitHexa();
		System.out.println("Création d'un hexagone '" + this.typeTerr + "' a la position x: " + this.getXHex() + " et y: " + this.getYHex());
	}
	
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
	

	public List<Sommet> getSommetsUV() {
		List<Sommet> luv = new ArrayList<Sommet>();
		for(Sommet s : sommets){
			if(s.hasUV()){
				luv.add(s);
			}
		}
		return luv;
	}
	 
	public List<Arete> getAretesCC() {
		List<Arete> lcc = new ArrayList<Arete>();
		for (Arete a : aretes){
			if(a.hasCC()){
				lcc.add(a);
			}
		}
		return lcc;
	}
	
	public List<Joueur> getSommetUVProprio() {
		List<Joueur> lj = new ArrayList<Joueur>();
		List<Sommet> luv = new ArrayList<Sommet>();
		luv = getSommetsUV();
		for(Sommet s : luv) {
			lj.add(s.getUv().getProprietaire());
		}
		return lj;
	}
	
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
	
	public Hexagone setPosition(int pxHex, int pyHex) {
		this.setXHex(pxHex);
		this.setYHex(pyHex);
		this.InitHexa();
		return this;
	}

	public double getXHex() {
		return xHex;
	}

	public void setXHex(double pxHex) {
		this.xHex = pxHex;
	}

	public double getYHex() {
		return yHex;
	}

	public void setYHex(double pyHex) {
		this.yHex = pyHex;
	}
	
	public double getSize() {
		return this.size;
	}

	public void setSize(double psize) {
		this.size = psize;
	}

	public boolean isBinomeG() {
		return binomeG;
	}

	public void setBinomeG(boolean pbinomeg) {
		this.binomeG = pbinomeg;
	}

	public TypeTerrain getTypeTerr() {
		return typeTerr;
	}

	public void setTypeTerr(TypeTerrain ptypeT) {
		this.typeTerr = ptypeT;
	}
	 
	public List<Sommet> getSommets() {
		return sommets;
	}

	public void setSommets(List<Sommet> psommets) {
		if(psommets.size() <= 6) {
			this.sommets = psommets;
		}else{
			System.out.println("La liste de sommets passée en paramétre dépasse 6 sommets !");
		}
	}
	
	public void setSommet(Sommet s) {
		if(this.sommets.size() < 6) {
			this.sommets.add(s);
		}else{
			System.out.println("La liste des sommets de l'hexagone ciblé est compléte !");
		}
	}

	public List<Arete> getAretes() {
		return aretes;
	}

	public void setAretes(List<Arete> paretes) {
		if(paretes.size() <= 6) {
			this.aretes = paretes;
		}else {
			System.out.println("La liste des aretes passée en paramétre dépasse 6 aretes !");
		}
	}
	
	public void setArete(Arete a) {
		if(this.aretes.size() < 6) {
			this.aretes.add(a);
		}else {
			System.out.println("La liste des aretes de l'hexagone ciblé est compléte !");
		}
	}

	public List<Hexagone> getVoisins() {
		return voisins;
	}

	public void setVoisins(List<Hexagone> pvoisins) {
		if(pvoisins.size() <= 6) {
			this.voisins = pvoisins;
		}else{
			System.out.println("La liste des hexagones voisins passée en paramétre dépasse 6 hexagones !");
		}
	}
	
	public void setVoisin(Hexagone h) {
		if(this.voisins.size() < 6) {
			this.voisins.add(h);
		}else{
			System.out.println("La liste des hexagones voisins de l'hexagone ciblé est compléte !");
		}
	}
}
