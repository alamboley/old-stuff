package lo43.projet.utboheme.hexagone;

import lo43.projet.utboheme.pion.UV;

public class Sommet {
	
	private int xSom;
	private int ySom;
	private UV uv;
	
	public Sommet() {
		this.xSom = 0;
		this.xSom = 0;
		this.uv = null;
	}
	
	public Sommet(int px, int py){
		this.xSom = px;
		this.ySom = py;
		System.out.println("Création d'un sommet a la position x: " + this.getXSom() + " et y: " + this.getYSom());
	}
	
	public int getXSom() {
		return xSom;
	}

	public void setXSom(int pxSom) {
		this.xSom = pxSom;
	}

	public int getYSom() {
		return ySom;
	}

	public void setYSom(int pySom) {
		this.ySom = pySom;
	}

	public UV getUv() {
		return uv;
	}

	public void setUv(UV puv) {
		this.uv = puv;
	}
	 
	public boolean hasUV() {
		if(uv != null) 
			return true;
		else {
			return false;
		}
	}

}
