package lo43.projet.utboheme.hexagone;

public class Jeton {

	private int numero;
	
	public Jeton() {
		this.numero = 0;
	}
		
	public Jeton(int pnum) {
		this.numero = pnum;
	}

	public int getNumero() {
		return numero;
	}

	public void setNumero(int pnum) {
		this.numero = pnum;
	}	
}
