package lo43.projet.utboheme.hexagoneview;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Rectangle;

import lo43.projet.utboheme.hexagone.Sommet;


@SuppressWarnings("serial")
public class SommetView extends Rectangle{
	
	private Sommet s;
	private Color c;
	
	public SommetView(Sommet ps, int ptaille){
		super();
		this.s = ps;
		this.setLocation(s.getXSom() - ptaille/2, s.getYSom() - ptaille/2);
		this.setSize(ptaille, ptaille);
		this.c = Color.orange;
	}
	
	public void paint(Graphics g){
		g.setColor(this.c);
		if(s.hasUV()) {
			g.setColor(Color.blue);
		}
		g.fillOval((int)this.getX(), (int)this.getY(), (int)this.getWidth(), (int)this.getHeight());
	}
	
	public void selected(boolean b) {
		this.c = (b) ? Color.red : Color.orange;
	}
	
}
