package com.citruxengine.objects;

import box2D.collision.shapes.B2Shape;
import box2D.common.math.B2Mat22;
import box2D.common.math.B2Transform;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2FixtureDef;

import com.citruxengine.core.CitruxEngine;
import com.citruxengine.core.CitruxObject;
import com.citruxengine.physics.Box2D;
import com.citruxengine.view.ISpriteView;

class PhysicsObject extends CitruxObject, implements ISpriteView {

	public var x(getX, setX):Float;
	public var y(getY, setY):Float;
	public var parallax(getParallax, setParallax):Float;
	public var rotation(getRotation, setRotation):Float;
	public var group(getGroup, setGroup):Int;
	public var visible(getVisible, setVisible):Bool;
	public var view(getView, setView):Dynamic;
	public var animation(getAnimation, never):String;
	public var inverted(getInverted, never):Bool;
	public var offsetX(getOffsetX, setOffsetX):Float;
	public var offsetY(getOffsetY, setOffsetY):Float;
	public var registration(getRegistration, setRegistration):String;

	public var width(getWidth, setWidth):Float;
	public var height(getHeight, setHeight):Float;
	public var radius(getRadius, setRadius):Float;
	public var body(getBody, never):B2Body;

	public var gravity:Float;

	var _ce:CitruxEngine;
	var _box2D:Box2D;
	var _bodyDef:B2BodyDef;
	var _body:B2Body;
	var _shape:B2Shape;
	var _fixtureDef:B2FixtureDef;
	var _fixture:B2Fixture;
	var _inverted:Bool;
	var _parallax:Float;
	var _animation:String;
	var _visible :Bool;
	var _x:Float;
	var _y:Float;
	var _view:Dynamic;
	var _rotation :Float;
	var _width:Float;
	var _height:Float;
	var _radius:Float;
	var _group:Int;
	var _offsetX:Float;
	var _offsetY:Float;
	var _registration:String;

	public function new(name:String, params:Dynamic = null) {

		_ce = CitruxEngine.getInstance();

		super(name, params);
		
		gravity = 1.6;
	}

	override public function destroy():Void {

		//_body.destroy(); -> doesn't exist, why ??
		//_fixtureDef.destroy(); -> doesn't exist, why ??
		//_shape.destroy(); -> doesn't exist, why ??
		//_bodyDef.destroy(); -> doesn't exist, why ??

		super.destroy();
	}

	public function getX():Float {
		
		if (_body != null)
			return _body.getPosition().x * _box2D.scale;
		else
			return _x * _box2D.scale;
	}

	public function setX(value:Float):Float {

		_x = value / _box2D.scale;

		if(_body != null) {

			var pos:B2Vec2 = _body.getPosition();
			pos.x = _x;
			_body.setTransform(new B2Transform(pos, B2Mat22.fromAngle(_body.getAngle())));
		}

		return value;
	}

	public function getY():Float {
		
		if (_body != null)
			return _body.getPosition().y * _box2D.scale;
		else
			return _y * _box2D.scale;
	}

	public function setY(value:Float):Float {

		_y = value / _box2D.scale;

		if(_body != null) {

			var pos:B2Vec2 = _body.getPosition();
			pos.y = _y;
			_body.setTransform(new B2Transform(pos, B2Mat22.fromAngle(_body.getAngle())));
		}

		return value;
	}

	public function getParallax():Float {
		return _parallax;
	}

	public function setParallax(value:Float):Float {
		_parallax = value;
		return _parallax;
	}

	public function getRotation():Float {
		
		if (_body != null)
			return _body.getAngle() * 180 / Math.PI;
		else
			return _rotation * 180 / Math.PI;
	}

	public function setRotation(value:Float):Float {

		_rotation = value * Math.PI / 180;

		if (_body != null)
			_body.setTransform(new B2Transform(_body.getPosition(), B2Mat22.fromAngle(_rotation)));

		return _rotation;
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
		return _animation;
	}

	public function getInverted():Bool {
		return _inverted;
	}

	public function getOffsetX():Float {
		return _offsetX;
	}

	public function setOffsetX(value:Float):Float {
		return _offsetX = value;
	}

	public function getOffsetY():Float {
		return _offsetY;
	}

	public function setOffsetY(value:Float):Float {
		return _offsetY = value;
	}

	public function getRegistration():String {
		return _registration;
	}

	public function setRegistration(value:String):String {
		return _registration = value;
	}

	public function getWidth():Float {
		return _width * _box2D.scale;
	}

	public function setWidth(value:Float):Float {
		return _width = value / _box2D.scale;
	}

	public function getHeight():Float {
		return _height * _box2D.scale;
	}

	public function setHeight(value:Float):Float {
		return _height = value / _box2D.scale;
	}

	public function getRadius():Float {
		return _radius * _box2D.scale;
	}

	public function setRadius(value:Float):Float {
		return _radius = value / _box2D.scale;
	}

	public function getBody():B2Body {
		return _body;
	}
}