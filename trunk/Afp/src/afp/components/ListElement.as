package afp.components {

	import afp.services.vo.EventVO;

	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author Aymeric
	 */
	public class ListElement extends Sprite {
		
		public var tf:TextField;

		public function ListElement(element:EventVO) {
			
			tf = new TextField();
			addChild(tf);
			tf.text = element.nom;
			tf.selectable = false;
		}
	}
}
