package lo43.projet.utboheme.hexagone;

import java.util.Random;

public enum TypeTerrain {
	
	BARS,
	LIEUREPOS,
	FOURNISSEURCAFE,
	LIEUXCOURS,
	RESTAURANT,
	DESERT,
	ZONETROC,
	REMPART;
	
	
	
	/**
	 * type de terrain aléatoir parmis les terrains de ressource
	 * @return
	 */
	public static TypeTerrain random() {
	    int pick = new Random().nextInt(TypeTerrain.values().length-3);
	    return TypeTerrain.values()[pick];
	}
	



}
