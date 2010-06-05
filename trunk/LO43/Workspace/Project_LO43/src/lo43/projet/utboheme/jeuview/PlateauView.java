package lo43.projet.utboheme.jeuview;

import java.awt.Canvas;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Point;
import java.util.ArrayList;
import java.util.List;

import lo43.projet.utboheme.hexagone.Hexagone;
import lo43.projet.utboheme.hexagoneview.AreteView;
import lo43.projet.utboheme.hexagoneview.HexagoneView;
import lo43.projet.utboheme.hexagoneview.SommetView;
import lo43.projet.utboheme.jeu.Plateau;

@SuppressWarnings("serial")
public class PlateauView extends Canvas{

	private Plateau plateau;
	private List<HexagoneView> lHexaV;
	
	public PlateauView(Plateau pp) {
		super();
		this.plateau = pp;
		this.lHexaV = new ArrayList<HexagoneView>();
		
		this.setLocation(new Point(0,0));
		this.setSize(new Dimension(plateau.getWidth(), plateau.getHeight()));
		for(Hexagone h : plateau.getHexagones()) {
			lHexaV.add(new HexagoneView(h));
		}
	}
	
	public void paint(Graphics g) {
		g.setColor(new Color(255, 255, 204));
		g.fillRoundRect(0, 0, this.getWidth(), this.getHeight(), 100, 100);
		for(HexagoneView hv : this.lHexaV) {
			hv.paint(g);
		}
	}
	
	public void update() {
		paint(this.getGraphics());
	}
	
	public void clicked(Point mousePosition) {
		for(HexagoneView hv : lHexaV) {
			for(SommetView s : hv.getLSommetV()) {
				s.selected(s.contains(mousePosition));
				//on recupere le sommet correspondant pour l'utiliser dans le jeu
				if (s.contains(mousePosition)) {
					plateau.constructionUV(s.getSommet());
				}
			}
			for(AreteView a : hv.getLAreteV()) {
				a.selected(a.contains(mousePosition));
				// on recupere l'arete correspondante pour l'utiliser dans le jeu
				if(a.contains(mousePosition)) {
					plateau.constructionCC(a.getArete());
				}
			}
		}
		this.update();
	}
	
	public Plateau getPlateau() {
		return plateau;
	}

	public void setP(Plateau p) {
		this.plateau = p;
	}

}
