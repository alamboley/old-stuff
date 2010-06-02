package lo43.projet.utboheme.hexagoneview;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Rectangle;

import lo43.projet.utboheme.hexagone.Jeton;

@SuppressWarnings("serial")
public class JetonView extends Rectangle{
	
	private Jeton j;
	private Color c;
	
	public JetonView(Jeton pj, int px, int py, int ptaille) {
		super();
		this.j = pj;
		this.setLocation(px - ptaille/2, py - ptaille/2);
		this.setSize(ptaille, ptaille);
		this.c = Color.darkGray;
	}
	
	public void paint(Graphics g){
		g.setColor(this.c);
		g.fillOval((int)this.getX(), (int)this.getY(), (int)this.getWidth(), (int)this.getHeight());
		
		if(this.j.getNumero() == 6 || this.j.getNumero() == 8) {
			g.setColor(Color.red);
		}else{
			g.setColor(Color.white);
		}
		
		g.setFont(new Font("Comics", Font.CENTER_BASELINE, (int)(this.getWidth()/1.5)));
		g.drawString(String.valueOf(j.getNumero()), (int)(this.getX() + this.getWidth()/5), (int)(this.getY() + this.getWidth()/1.5));
	}

}
