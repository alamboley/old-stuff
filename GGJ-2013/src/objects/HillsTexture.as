package objects {


	import nape.phys.Body;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	import flash.geom.Matrix;

	/**
	 * @author Aymeric
	 */
	public class HillsTexture extends Sprite {
		
		private var _sliceWidth:uint;
		private var _sliceHeight:uint;
		
		private var _images:Vector.<Image>;
		
		private var _flagAdded:Boolean = false;
		
	 
		private var _tronconTexture:Texture;
		
		 
		private var _crateTexture:Texture;
		
		private var _defaultTexture:Texture;		

		public function HillsTexture() {
		}
		
		public function init(sliceWidth:uint, sliceHeight:uint):void {
			
			_sliceWidth = sliceWidth;
			_sliceHeight = sliceHeight;
			
			_tronconTexture = AtlasSimple.getAtlas().getTexture("troncon");
			_crateTexture = AtlasSimple.getAtlas().getTexture("troncon");
			
			_defaultTexture = AtlasSimple.getAtlas().getTexture("troncon");
			
			//_groundTexture = Texture.fromBitmapData(new BitmapData(_sliceWidth, _sliceHeight, false, 0xffaa33));
			
			_images = new Vector.<Image>();
			
			addEventListener(Event.ADDED, _added);
		}

		private function _added(evt:Event):void {
			
			_flagAdded = true;
			
			removeEventListener(Event.ADDED_TO_STAGE, _added);
		}
		
		public function update():void {
			
			// we don't want to move the parent like StarlingArt does!
			if (_flagAdded)
				this.parent.x = this.parent.y = 0;
		}
		
		public function createSlice(rider:Body, nextYPoint:uint, currentYPoint:uint, back:Boolean, texture:String):void {
			
			if (texture) {
				
				if (texture == "troncon")
					_defaultTexture = _tronconTexture;
				else if (texture == "crate")
					_defaultTexture = _crateTexture;
			}
			
			var image:Image = new Image(_defaultTexture);			
			addChild(image);
			
			if (back)
				_images.unshift(image);
			else
				_images.push(image);
			
			var matrix:Matrix = image.transformationMatrix;
            matrix.translate(rider.position.x, rider.position.y);
            matrix.a = 1.04;
			
			if (back)
				matrix.b = (currentYPoint - nextYPoint) / _sliceWidth;
			else
            	matrix.b = (nextYPoint - currentYPoint) / _sliceWidth;
				
            image.transformationMatrix.copyFrom(matrix); 
		}
		
		public function deleteHill(index:uint):void {
			
			removeChild(_images[index], true);
			_images.splice(index, 1);
		}
	}
}
