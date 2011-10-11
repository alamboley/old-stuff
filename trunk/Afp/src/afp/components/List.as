package afp.components {

	import afp.services.vo.EventVO;

	import com.thanksmister.touchlist.controls.TouchList;
	import com.thanksmister.touchlist.events.ListItemEvent;
	import com.thanksmister.touchlist.renderers.TouchListItemRenderer;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Aymeric
	 */
	public class List extends Sprite {

		private var _elements:Vector.<EventVO>;

		private var _touchList:TouchList;

		public function List(elements:Vector.<EventVO>) {

			_elements = elements;

			addEventListener(Event.ADDED_TO_STAGE, _init);
		}

		private function _init(evt:Event):void {

			removeEventListener(Event.ADDED_TO_STAGE, _init);

			_touchList = new TouchList(200, 300);
			_touchList.addEventListener(ListItemEvent.ITEM_SELECTED, _handlelistItemSelected);
			addChild(_touchList);

			var item:TouchListItemRenderer;
			
			for each (var event:EventVO in _elements) {

				item = new TouchListItemRenderer();
				item.index = uint(event.id);
				item.data = event.nom;
				item.itemHeight = 20;

				_touchList.addListItem(item);
			}

		}

		private function _handlelistItemSelected(liEvt:ListItemEvent):void {

			trace("List item selected: " + liEvt.renderer.index);
		}
	}
}
