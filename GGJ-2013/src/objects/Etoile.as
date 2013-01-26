package objects {

	import citrus.objects.CitrusSprite;

	import com.greensock.TweenLite;

	/**
	 * @author Aymeric
	 */
	public class Etoile extends CitrusSprite {

		public function Etoile(name:String, params:Object = null) {
			super(name, params);
			
			alphaTween0();
		}

		private function alphaTween0():void {
			
			if (_view)
				TweenLite.to(_view, Math.random(), {alpha:0.3, onComplete:alphaTween1});
		}
		
		private function alphaTween1():void {
			
			if (_view)
				TweenLite.to(_view, Math.random(), {alpha:1, onComplete:alphaTween0});
		}
	}
}
