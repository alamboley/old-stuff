package lo43.projet.utboheme.hexagoneview;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Polygon;
import java.util.ArrayList;
import java.util.List;

import lo43.projet.utboheme.carte.TypeCartes;
import lo43.projet.utboheme.hexagone.Arete;
import lo43.projet.utboheme.hexagone.HexaRessource;
import lo43.projet.utboheme.hexagone.HexaZoneTroc;
import lo43.projet.utboheme.hexagone.Hexagone;
import lo43.projet.utboheme.hexagone.Sommet;
import lo43.projet.utboheme.hexagone.TypeTerrain;

/**
 * Classe representant graphiquement les classes Hexagone, HexaRessource et HexaZoneTroc
 * Herite de Polygon
 * 	- possede un attribut de type Hexagone pour savoir l'hexagone a representer
 * 	- possede une liste de representation graphique des sommets qui composent l'hexagone associe
 * 	- possede une liste de representation graphique des aretes qui composent l'hexagone associe
 * @author alexandreaugen
 *
 */
@SuppressWarnings("serial")
public class HexagoneView extends Polygon{
	
	private Hexagone hexa;
	private List<SommetView> lsommetsV;
	private List<AreteView> laretesV;
	
	/**
	 * Constructeur parametre
	 * @param ph
	 */
	public HexagoneView(Hexagone ph) {
		super();
		this.hexa = ph;
		lsommetsV = new ArrayList<SommetView>();
		laretesV = new ArrayList<AreteView>();
		
		//Mise en place du polygone gr‰ce au sommet de l'attribut hexagone 
		//Creation des sommets et aretes graphique et ajout a la liste associe
		for(Sommet s : hexa.getSommets()) {
			this.addPoint(s.getXSom(), s.getYSom());
			lsommetsV.add(new SommetView(s, (int)(hexa.getSize() / 4)));
		}
		
		for(Arete a : hexa.getAretes()) {
			laretesV.add(new AreteView(a, (int)(hexa.getSize() / 4)));
		}
	}

	/**
	 * Methode permettant de peindre le composant  
	 * @param g
	 */
	public void paint(Graphics g) {
		//Test du type de l'attribut hexagone pour attribuer une image differente
		if(this.hexa.getTypeTerr() == TypeTerrain.BARS) {
			g.setColor(new Color(128, 0, 128));
		}else if(this.hexa.getTypeTerr() == TypeTerrain.LIEUREPOS) {
			g.setColor(new Color(128, 255, 255));
		}else if(this.hexa.getTypeTerr() == TypeTerrain.FOURNISSEURCAFE) {
			g.setColor(new Color(128, 64, 0));
		}else if(this.hexa.getTypeTerr() == TypeTerrain.LIEUXCOURS) {
			g.setColor(new Color(255, 128, 64));
		}else if(this.hexa.getTypeTerr() == TypeTerrain.RESTAURANT) {
			g.setColor(new Color(255, 180, 255));
		}else if(this.hexa.getTypeTerr() == TypeTerrain.ZONETROC) {
			g.setColor(new Color(192, 192, 192));
		}else if(this.hexa.getTypeTerr() == TypeTerrain.DESERT) {
			g.setColor(new Color(255, 255, 128));
		}else if(this.hexa.getTypeTerr() == TypeTerrain.REMPART) {
			g.setColor(new Color(128, 128, 128));
		}
		//On dessine le polygone
		g.fillPolygon(this);
		g.setColor(Color.white);
		g.drawPolygon(this);
		
		//On dessine les aretes graphiques
		for(AreteView av : this.laretesV) {
			av.paint(g);
		}
		
		//On dessine les sommets graphiques
		for(SommetView sv : this.lsommetsV) {
			sv.paint(g);
		}
		
		//Si c'est un hexagone de ressource, on lui attribut un jeton initialement vide
		if(this.hexa.getClass() == HexaRessource.class) {
			HexaRessource hr = (HexaRessource) hexa;
			new JetonView(hr.getJeton(), (int)hr.getXHex(), (int)hr.getYHex(), (int)hr.getSize() / 2).paint(g);
		}
		
		//Si l'hexagone possede le binome glandeur, on dessine un carre sur ce dernier
		if(hexa.isBinomeG()) {
			g.setColor(Color.black);
			g.fillOval((int)(hexa.getXHex() + hexa.getSize() / 8), (int)(hexa.getYHex() - hexa.getSize()/5), (int)(hexa.getSize() / 3), (int)(hexa.getSize() / 3));
			g.fillRoundRect((int)(hexa.getXHex() + hexa.getSize() / 8), (int)(hexa.getYHex() + hexa.getSize() / 8), (int)(hexa.getSize() / 3), (int)(hexa.getSize() / 3),  (int)(hexa.getSize() / 8), (int)(hexa.getSize() / 8));
		}
		
		//Si l'hexagone est une zone de troc, on dessine un rond different selon le type de carte associe
		if(this.hexa.getClass() == HexaZoneTroc.class) {
			HexaZoneTroc hz = (HexaZoneTroc) hexa;
			if(hz.getTypeCarte() == TypeCartes.BIERE) {
				g.setColor(new Color(128, 0, 128));
			}else if(hz.getTypeCarte() == TypeCartes.SOMMEIL) {
				g.setColor(new Color(128, 255, 255));
			}else if(hz.getTypeCarte() == TypeCartes.CAFE) {
				g.setColor(new Color(128, 64, 0));
			}else if(hz.getTypeCarte() == TypeCartes.SUPPORT) {
				g.setColor(new Color(255, 128, 64));
			}else if(hz.getTypeCarte() == TypeCartes.NOURRITURE) {
				g.setColor(new Color(255, 180, 255));
			}
			//On dessine le rond avec le type de troc
			int tailleNum = (int)(hz.getSize() / 3);
			g.fillOval((int)(hz.getXHex() - hz.getSize() / 2), (int)(hz.getYHex() - hz.getSize() / 2), (int)hz.getSize(), (int)hz.getSize());
			g.setColor(Color.black);
			g.setFont(new Font("Comics", Font.CENTER_BASELINE, tailleNum));
			g.drawString(String.valueOf(hz.getTypeTroc() + ":1"), (int)(hz.getXHex() - tailleNum), (int)(hz.getYHex() + tailleNum /4));
		}
		
	}
	
	/**
	 * Renvoi la liste des sommets graphiques
	 * @return
	 * 	- une liste de SommetView
	 */
	public List<SommetView> getLSommetV() {
		return lsommetsV;
	}

	/**
	 * Renvoi la liste des aretes graphiques
	 * @return
	 * 	- une liste de AreteView
	 */
	public List<AreteView> getLAreteV() {
		return laretesV;
	}

	public Hexagone getHexa() {
		return hexa;
	}
	
	
	
}
