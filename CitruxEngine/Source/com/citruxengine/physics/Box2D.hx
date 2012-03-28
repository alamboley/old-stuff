package com.citruxengine.physics;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2World;

import com.citruxengine.core.CitruxObject;
import com.citruxengine.view.ISpriteView;

class Box2D extends CitruxObject, implements ISpriteView {

	public var world(getWorld, never):B2World;
	public var scale(getScale, never):Int;

	public var x(getX, never):Float;
	public var y(getY, never):Float;
	public var parallax(getParallax, never):Float;
	public var rotation(getRotation, never):Float;
	public var group(getGroup, setGroup):Int;
	public var visible(getVisible, setVisible):Bool;
	public var view(getView, setView):Dynamic;
	public var animation(getAnimation, never):String;
	public var inverted(getInverted, never):Bool;
	public var offsetX(getOffsetX, never):Float;
	public var offsetY(getOffsetY, never):Float;
	public var registration(getRegistration, never):String;

	var _visible:Bool;
	var _scale:Int;
	var _world:B2World;
	var _group:Int;
	var _view:Dynamic;

	public function new(name:String, params:Dynamic = null) {

		super(name, params);

		_visible = false;
		_scale = 30;
		_group = 1;

		_world = new B2World(new B2Vec2(0, 0), true);
	}

	override public function destroy():Void {

		//_world.destroy(); -> doesn't exist, why ??

		super.destroy();
	}

	public function getWorld():B2World {
		return _world;
	}

	public function getScale():Int {
		return _scale;
	}

	override public function update(timeDelta:Float):Void {

		super.update(timeDelta);

		_world.step(1 / 20, 8, 8);
	}

	public function getX():Float {
		return 0;
	}

	public function getY():Float {
		return 0;
	}

	public function getParallax():Float {
		return 1;
	}

	public function getRotation():Float {
		return 0;
	}

	public function getGroup():Int {
		return _group;
	}

	public function setGroup(value:Int):Int {
		return _group = value;
	}

	public function getVisible():Bool {
		return _visible;
	}

	public function setVisible(value:Bool):Bool {
		return _visible = value;
	}

	public function getView():Dynamic {
		return _view;
	}

	public function setView(value:Dynamic):Dynamic {
		return _view = value;
	}

	public function getAnimation():String {
		return "";
	}

	public function getInverted():Bool {
		return false;
	}

	public function getOffsetX():Float {
		return 0;
	}

	public function getOffsetY():Float {
		return 0;
	}

	public function getRegistration():String {
		return "topLeft";
	}
}