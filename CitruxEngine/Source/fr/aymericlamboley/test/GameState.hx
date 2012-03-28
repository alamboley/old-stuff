package fr.aymericlamboley.test;

import com.citruxengine.core.CitruxEngine;
import com.citruxengine.core.State;
import com.citruxengine.objects.PhysicsObject;
import com.citruxengine.physics.Box2D;

class GameState extends State {

	public function new() {

		super();
	}

	override public function initialize():Void {

		super.initialize();

		var box2d:Box2D = new Box2D("Box2D");
		box2d.visible = true;
		add(box2d);

		var citruxObject:PhysicsObject = new PhysicsObject("monCitruxObject", {_visible:false, x:2, y:20, width:100, height:100, parallax:20});
		add(citruxObject);

		trace(citruxObject.x + " " + citruxObject.visible);
	}
}