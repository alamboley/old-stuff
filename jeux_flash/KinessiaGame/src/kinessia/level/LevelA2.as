package kinessia.level {

	import com.citrusengine.objects.platformer.Platform;

	/**
	 * @author Aymeric
	 */
	public class LevelA2 extends ALevel {

		public function LevelA2() {
			super();
		}
		
		override public function initialize():void {
			
			super.initialize();
			
			var plateform:Platform = new Platform("Platform", {x:250, y:300, width:20, height:200});
			add(plateform);
		}
	}
}
