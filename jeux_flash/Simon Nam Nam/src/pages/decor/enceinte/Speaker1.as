package pages.decor.enceinte {

	import pages.decor.DecorEvent;

	/**
	 * @author Aymeric
	 */
	 
	public class Speaker1 extends Enceinte {

		public function Speaker1() {
			
			this.addEventListener(DecorEvent.BAFFLE, _baffler);
		}
		
		private function _baffler(dEvt:DecorEvent):void {
			super.baffler(dEvt);
		}
	}
}
