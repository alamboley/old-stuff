package lo43.projet.utboheme.hexagoneview;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Rectangle;

import lo43.projet.utboheme.hexagone.Arete;


@SuppressWarnings("serial")
public class AreteView extends Rectangle{
	
	private Arete a;
	private Color c;
	
	public AreteView(Arete pa, int ptaille) {
		super();
		this.a = pa;
		this.c = Color.orange;
		this.setLocation((int)(((a.getsDebut().getXSom() + a.getsFin().getXSom())/2) - ptaille/2), (int)(((a.getsDebut().getYSom() + a.getsFin().getYSom())/2) - ptaille/2));
		this.setSize(new Dimension(ptaille, ptaille));
	}

	public void paint(Graphics g){
		g.setColor(this.c);
		if(a.hasCC()) {
			g.setColor(Color.blue);
		}
		g.fillRect((int)this.getX(), (int)this.getY(), (int)this.getWidth(), (int)this.getHeight());
	}
	
	public void selected(boolean b) {
		this.c = (b) ? Color.red : Color.orange;
	}
	
	public Arete getA() {
		return a;
	}

	public void setA(Arete a) {
		this.a = a;
	}

}
