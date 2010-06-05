package lo43.projet.utboheme.hexagoneview;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Rectangle;

import lo43.projet.utboheme.hexagone.Sommet;


@SuppressWarnings("serial")
public class SommetView extends Rectangle{
	
	private Sommet sommet;
	private Color color;
	
	public SommetView(Sommet ps, int ptaille){
		super();
		this.sommet = ps;
		this.setLocation(sommet.getXSom() - ptaille/2, sommet.getYSom() - ptaille/2);
		this.setSize(ptaille, ptaille);
		this.color = Color.orange;
	}
	
	public void paint(Graphics g){
		g.setColor(this.color);
		if(sommet.hasUV()) {
			g.setColor(Color.blue);
		}
		g.fillOval((int)this.getX(), (int)this.getY(), (int)this.getWidth(), (int)this.getHeight());
	}
	
	public void selected(boolean b) {
		this.color = (b) ? Color.red : Color.orange;
	}
	
	public Sommet getSommet() {
		return this.sommet;
	}
	
}
