package defenseofaegir {
	import com.citrusengine.core.CitrusEngine;

	import flash.display.Sprite;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="1000", height="650")]
	
	/**
	 * @author Aymeric
	 */
	public class Main extends CitrusEngine {

		public function Main() {
			
			super();
			
			trace('Hello World');
			var rect:Sprite = new Sprite();
			addChild(rect);
			rect.graphics.beginFill(0xFF0000, 1);
		   	rect.graphics.drawRect(100, 100, 100, 100);
		   	rect.graphics.endFill();
		}
	}
}