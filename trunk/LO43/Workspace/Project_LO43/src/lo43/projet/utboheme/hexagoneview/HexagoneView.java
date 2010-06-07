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

@SuppressWarnings("serial")
public class HexagoneView extends Polygon{
	
	private Hexagone hexa;
	private List<SommetView> lsommetsV;
	private List<AreteView> laretesV;
	
	public HexagoneView(Hexagone ph) {
		super();
		this.hexa = ph;
		lsommetsV = new ArrayList<SommetView>();
		laretesV = new ArrayList<AreteView>();
		
		for(Sommet s : hexa.getSommets()) {
			this.addPoint(s.getXSom(), s.getYSom());
			lsommetsV.add(new SommetView(s, (int)(hexa.getSize() / 4)));
		}
		
		for(Arete a : hexa.getAretes()) {
			laretesV.add(new AreteView(a, (int)(hexa.getSize() / 4)));
		}
	}

	public void paint(Graphics g) {
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
		g.fillPolygon(this);
		g.setColor(Color.white);
		g.drawPolygon(this);
		
		for(AreteView av : this.laretesV) {
			av.paint(g);
		}
		
		for(SommetView sv : this.lsommetsV) {
			sv.paint(g);
		}
		
		if(this.hexa.getClass() == HexaRessource.class) {
			HexaRessource hr = (HexaRessource) hexa;
			new JetonView(hr.getJeton(), (int)hr.getXHex(), (int)hr.getYHex(), (int)hr.getSize() / 2).paint(g);
		}
		
		if(hexa.isBinomeG()) {
			g.setColor(Color.black);
			g.fillOval((int)(hexa.getXHex() + hexa.getSize() / 8), (int)(hexa.getYHex() - hexa.getSize()/5), (int)(hexa.getSize() / 3), (int)(hexa.getSize() / 3));
			g.fillRoundRect((int)(hexa.getXHex() + hexa.getSize() / 8), (int)(hexa.getYHex() + hexa.getSize() / 8), (int)(hexa.getSize() / 3), (int)(hexa.getSize() / 3),  (int)(hexa.getSize() / 8), (int)(hexa.getSize() / 8));
		}
		
		
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
			int tailleNum = (int)(hz.getSize() / 3);
			g.fillOval((int)(hz.getXHex() - hz.getSize() / 2), (int)(hz.getYHex() - hz.getSize() / 2), (int)hz.getSize(), (int)hz.getSize());
			g.setColor(Color.black);
			g.setFont(new Font("Comics", Font.CENTER_BASELINE, tailleNum));
			g.drawString(String.valueOf(hz.getTypeTroc() + ":1"), (int)(hz.getXHex() - tailleNum), (int)(hz.getYHex() + tailleNum /4));
		}
		
	}

	public Hexagone getHexa() {
		return hexa;
	}

	public void setHexa(Hexagone ph) {
		this.hexa = ph;
	}

	public List<SommetView> getLSommetV() {
		return lsommetsV;
	}

	public void setLSommetV(List<SommetView> plsmtV) {
		this.lsommetsV = plsmtV;
	}

	public List<AreteView> getLAreteV() {
		return laretesV;
	}

	public void setLAreteV(List<AreteView> plaV) {
		this.laretesV = plaV;
	}
	
}
