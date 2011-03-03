package pages.decor.enceinte {

	import pages.decor.DecorEvent;

	/**
	 * @author Aymeric
	 */
	 
	public class Speaker16 extends Enceinte {

		public function Speaker16() {
			
			this.addEventListener(DecorEvent.BAFFLE, _baffler);
		}
		
		private function _baffler(dEvt:DecorEvent):void {
			super.baffler(dEvt);
		}
	}
}
