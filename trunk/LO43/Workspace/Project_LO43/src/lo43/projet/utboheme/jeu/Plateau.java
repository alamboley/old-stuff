package lo43.projet.utboheme.jeu;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import lo43.projet.utboheme.hexagone.Arete;
import lo43.projet.utboheme.hexagone.HexaRessource;
import lo43.projet.utboheme.hexagone.HexaZoneTroc;
import lo43.projet.utboheme.hexagone.Hexagone;
import lo43.projet.utboheme.hexagone.Jeton;
import lo43.projet.utboheme.hexagone.Sommet;
import lo43.projet.utboheme.hexagone.TypeTerrain;

public class Plateau {
	
	private int sizeHexa;
	private List<Hexagone> hexagones;
	
	public Plateau() {
		this.setSizeHexa(0);
		this.setHexagones(null);
	}
		
	public Plateau(int psize) {
		this.setSizeHexa(psize);
		
		this.InitHexa();
	}
	
	public void InitHexa() {
		
		this.hexagones = new ArrayList<Hexagone>();
		
		List<HexaRessource> lHexaRess = new ArrayList<HexaRessource>();
		List<Hexagone> lHexaZoneT = new ArrayList<Hexagone>();
		List<Jeton> lJetons = new ArrayList<Jeton>();
		int typeTroc;
		TypeTerrain typeRess;
		int numJeton = 2;
		
		for(int i=0; i<9; i++) {
			typeTroc = (i < 5) ? 2 : 3;
			lHexaZoneT.add(new HexaZoneTroc(0, 0, this.getSizeHexa(), false, TypeTerrain.ZONETROC, typeTroc, TypeTerrain.random()));
			
		}
		lHexaZoneT = melanger(lHexaZoneT);
		
		lJetons.add(new Jeton(numJeton));
		for(int i=0; i<9; i++) {
			numJeton++;
			if(i != 7) {
				lJetons.add(new Jeton(numJeton));
				lJetons.add(new Jeton(numJeton));
			}
		}
		lJetons.add(new Jeton(++numJeton));
		lJetons = melangerJeton(lJetons);
		
		for(int i=0; i<18; i++) {
			typeRess = (i < 4) ? TypeTerrain.BARS : (i >= 4 && i < 7) ? TypeTerrain.LIEUREPOS : (i >= 7 && i < 11) ? TypeTerrain.FOURNISSEURCAFE : (i >= 11 && i < 15) ? TypeTerrain.LIEUXCOURS : TypeTerrain.RESTAURANT;
			lHexaRess.add(new HexaRessource(0, 0, this.getSizeHexa(), false, typeRess, null));
		}
		lHexaRess = melangerRess(lHexaRess);
		
		// 1
		hexagones.add(lHexaRess.get(0).setPosition(3, 2).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(3, 3).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(new Hexagone(4, 4, this.getSizeHexa(), true, TypeTerrain.DESERT));
		hexagones.add(lHexaRess.get(0).setPosition(4, 5).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(5, 6).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		
		// 2 : droite
		hexagones.add(lHexaRess.get(0).setPosition(4, 2).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(4, 3).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(5, 4).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(5, 5).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		
		// 2 : gauche
		hexagones.add(lHexaRess.get(0).setPosition(2, 3).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(3, 4).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(3, 5).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(4, 6).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		
		// 3 : droite 
		hexagones.add(lHexaRess.get(0).setPosition(5, 2).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(5, 3).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(6, 4).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		
		// 3 : gauche 
		hexagones.add(lHexaRess.get(0).setPosition(2, 4).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(2, 5).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		hexagones.add(lHexaRess.get(0).setPosition(3, 6).setJeton(lJetons.get(0)));
		lHexaRess.remove(0); lJetons.remove(0);
		
		// Zones de troc
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
		
		// Remparts
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
	
	public int getSizeHexa() {
		return sizeHexa;
	}

	public void setSizeHexa(int psize) {
		this.sizeHexa = psize;
	}

	public List<Hexagone> getHexagones() {
		return this.hexagones;
	}

	public void setHexagones(List<Hexagone> lh) {
		for(Hexagone h : lh) {
			this.setHexagone(h);
		}
	}
	
	public void setHexagone(Hexagone ph) {
		this.hexagones.add(ph);
	}
	
	public int getWidth() {
		return 15 * this.getSizeHexa();
	}
	
	public int getHeight() {
		return 13 * this.getSizeHexa();
	}
	
	public List<Hexagone> melanger(List<Hexagone> listeD){
		List<Hexagone> ListeR = new ArrayList<Hexagone>(listeD);
		Collections.shuffle(ListeR);
		return ListeR;
	}
	
	public List<Jeton> melangerJeton(List<Jeton> listeD){
		List<Jeton> ListeR = new ArrayList<Jeton>(listeD);
		Collections.shuffle(ListeR);
		return ListeR;
	}
	
	public List<HexaRessource> melangerRess(List<HexaRessource> listeD){
		List<HexaRessource> ListeR = new ArrayList<HexaRessource>(listeD);
		Collections.shuffle(ListeR);
		return ListeR;
	}
	 
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
	
	public List<Hexagone> getHexaClass() {
		List<Hexagone> lHexa = new ArrayList<Hexagone>();
		for(Hexagone h : this.getHexagones()) {
			if(h.getClass() == Hexagone.class) {
				lHexa.add(h);
			}
		}
		return lHexa;
	}
	
	public List<HexaRessource> getHexaRess() {
		List<HexaRessource> lHexaR = new ArrayList<HexaRessource>();
		for(Hexagone h : this.getHexagones()) {
			if(h.getClass() == HexaRessource.class) {
				lHexaR.add((HexaRessource) h);
			}
		}
		return lHexaR;
	}
	
	public List<HexaZoneTroc> getHexZoneT() {
		List<HexaZoneTroc> lHexaZ = new ArrayList<HexaZoneTroc>();
		for(Hexagone h : this.getHexagones()) {
			if(h.getClass() == HexaZoneTroc.class) {
				lHexaZ.add((HexaZoneTroc) h);
			} 
		}
		return lHexaZ;
	}
	 
	public List<HexaRessource> getHexaByNum(int pnum) {
		List<HexaRessource> lHexaR = new ArrayList<HexaRessource>();
		for(HexaRessource h : this.getHexaRess()) {
			if(h.getJeton().getNumero() == pnum) {
				lHexaR.add(h);
			}
		}
		return lHexaR;
	}
	 
	public List<HexaZoneTroc> getZoneTroc(Joueur pjoueur) {
		List<HexaZoneTroc> lHexaZ = new ArrayList<HexaZoneTroc>();
		for(HexaZoneTroc h : this.getHexZoneT()) {
			if(h.getSommetUVProprio().contains(pjoueur)) {
				lHexaZ.add(h);
			}
		}
		return lHexaZ;
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
