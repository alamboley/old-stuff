package afp.components {

	import afp.remoting.vo.EventVO;
	import com.thanksmister.touchlist.controls.TouchList;
	import com.thanksmister.touchlist.events.ListItemEvent;
	import com.thanksmister.touchlist.renderers.TouchListItemRenderer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;



	/**
	 * @author Aymeric
	 */
	public class PopUp extends Sprite {

		private var _elements:Vector.<EventVO>;

		private var _touchList:TouchList;
		private var _description:TextField;

		public function PopUp(elements:Vector.<EventVO>) {

			_elements = elements;
			_description = new TextField();

			addEventListener(Event.ADDED_TO_STAGE, _init);
		}

		private function _init(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, _init);

			_touchList = new TouchList(200, 300);
			_touchList.addEventListener(ListItemEvent.ITEM_SELECTED, _handlelistItemSelected);
			addChild(_touchList);

			var item:TouchListItemRenderer;
			
			for each (var eventVO:EventVO in _elements) {

				item = new TouchListItemRenderer();
				item.index = uint(eventVO.id);
				item.data = eventVO.nom;
				item.itemHeight = 80;

				_touchList.addListItem(item);
			}
			
			addChild(_description);
			_description.y = 320;
			_description.type = TextFieldType.INPUT;
			_description.background = true;
			_description.backgroundColor = 0x999999;
			_description.text = " gree";
			_description.width = 200;

		}

		private function _handlelistItemSelected(liEvt:ListItemEvent):void {

			trace("List item selected: " + liEvt.renderer.index);
		}
	}
}
