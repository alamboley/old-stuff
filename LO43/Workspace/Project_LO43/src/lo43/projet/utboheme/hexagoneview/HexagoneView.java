package lo43.projet.utboheme.hexagoneview;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Polygon;
import java.util.ArrayList;
import java.util.List;

import lo43.projet.utboheme.hexagone.Arete;
import lo43.projet.utboheme.hexagone.HexaRessource;
import lo43.projet.utboheme.hexagone.HexaZoneTroc;
import lo43.projet.utboheme.hexagone.Hexagone;
import lo43.projet.utboheme.hexagone.Sommet;
import lo43.projet.utboheme.hexagone.TypeTerrain;

@SuppressWarnings("serial")
public class HexagoneView extends Polygon{
	
	private Hexagone h;
	private List<SommetView> lsmtV;
	private List<AreteView> laV;
	
	public HexagoneView(Hexagone ph) {
		super();
		this.h = ph;
		lsmtV = new ArrayList<SommetView>();
		laV = new ArrayList<AreteView>();
		
		for(Sommet s : h.getSommets()) {
			this.addPoint(s.getXSom(), s.getYSom());
			lsmtV.add(new SommetView(s, (int)(h.getSize() / 4)));
		}
		
		for(Arete a : h.getAretes()) {
			laV.add(new AreteView(a));
		}
	}

	public void paint(Graphics g) {
		if(this.h.getTypeTerr() == TypeTerrain.BARS) {
			g.setColor(new Color(128, 0, 128));
		}else if(this.h.getTypeTerr() == TypeTerrain.LIEUREPOS) {
			g.setColor(new Color(128, 255, 255));
		}else if(this.h.getTypeTerr() == TypeTerrain.FOURNISSEURCAFE) {
			g.setColor(new Color(128, 64, 0));
		}else if(this.h.getTypeTerr() == TypeTerrain.LIEUXCOURS) {
			g.setColor(new Color(255, 128, 64));
		}else if(this.h.getTypeTerr() == TypeTerrain.RESTAURANT) {
			g.setColor(new Color(255, 180, 255));
		}else if(this.h.getTypeTerr() == TypeTerrain.ZONETROC) {
			g.setColor(new Color(192, 192, 192));
		}else if(this.h.getTypeTerr() == TypeTerrain.DESERT) {
			g.setColor(new Color(255, 255, 128));
		}else if(this.h.getTypeTerr() == TypeTerrain.REMPART) {
			g.setColor(new Color(128, 128, 128));
		}
		g.fillPolygon(this);
		
		for(AreteView av : this.laV) {
			av.paint(g);
		}
		
		for(SommetView sv : this.lsmtV) {
			sv.paint(g);
		}
		
		if(this.h.getClass() == HexaRessource.class) {
			HexaRessource hr = (HexaRessource) h;
			new JetonView(hr.getJeton(), (int)hr.getXHex(), (int)hr.getYHex(), (int)hr.getSize() / 2).paint(g);
		}
		
		if(h.isBinomeG()) {
			g.setColor(Color.black);
			g.fillOval((int)(h.getXHex() + h.getSize() / 8), (int)(h.getYHex() - h.getSize() / 3), (int)(h.getSize() / 2), (int)(h.getSize() / 2));
			g.fillRoundRect((int)(h.getXHex() + h.getSize() / 8), (int)(h.getYHex() + h.getSize() / 8), (int)(h.getSize() / 2), (int)(h.getSize() / 2),  (int)(h.getSize() / 8), (int)(h.getSize() / 8));
		}
		
		
		if(this.h.getClass() == HexaZoneTroc.class) {
			HexaZoneTroc hz = (HexaZoneTroc) h;
			if(hz.getTypeRessource() == TypeTerrain.BARS) {
				g.setColor(new Color(128, 0, 128));
			}else if(hz.getTypeRessource() == TypeTerrain.LIEUREPOS) {
				g.setColor(new Color(128, 255, 255));
			}else if(hz.getTypeRessource() == TypeTerrain.FOURNISSEURCAFE) {
				g.setColor(new Color(128, 64, 0));
			}else if(hz.getTypeRessource() == TypeTerrain.LIEUXCOURS) {
				g.setColor(new Color(255, 128, 64));
			}else if(hz.getTypeRessource() == TypeTerrain.RESTAURANT) {
				g.setColor(new Color(255, 180, 255));
			}
			int tailleNum = (int)(hz.getSize() / 3);
			g.fillOval((int)(hz.getXHex() - hz.getSize() / 2), (int)(hz.getYHex() - hz.getSize() / 2), (int)hz.getSize(), (int)hz.getSize());
			g.setColor(Color.black);
			g.setFont(new Font("Comics", Font.CENTER_BASELINE, tailleNum));
			g.drawString(String.valueOf(hz.getTypeTroc() + ":1"), (int)(hz.getXHex() - tailleNum), (int)(hz.getYHex() + tailleNum /4));
		}
		
	}

	public Hexagone getH() {
		return h;
	}

	public void setH(Hexagone ph) {
		this.h = ph;
	}

	public List<SommetView> getLsmtV() {
		return lsmtV;
	}

	public void setLsmtV(List<SommetView> plsmtV) {
		this.lsmtV = plsmtV;
	}

	public List<AreteView> getLaV() {
		return laV;
	}

	public void setLaV(List<AreteView> plaV) {
		this.laV = plaV;
	}
	
}
