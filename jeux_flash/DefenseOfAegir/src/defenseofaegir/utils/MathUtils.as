package defenseofaegir.utils {
	
	/**
	 * @author Aymeric
	 */
	public class MathUtils {
		
		static public function angleDirection(posX:int, destX:int, posY:int, destY:int):Number {
			
			return rad2deg(Math.atan2((destY - posY), (destX - posX)));
		}
		
		static public function rad2deg(angle:Number):Number {
			
			return angle * 180 / Math.PI;
		}
	}
}
