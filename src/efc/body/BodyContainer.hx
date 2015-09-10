package efc.body;

import flambe.System;
import flambe.Component;
import flambe.display.Sprite;
import flambe.display.ImageSprite;
import flambe.animation.Ease;
import flambe.util.Assert;
import flambe.math.FMath;

import nape.space.Space;
import nape.geom.Vec2;

import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionType;
import nape.callbacks.CbType;
import nape.callbacks.CbEvent;

class BodyContainer extends Component
{
	private var _NORMAL = new CbType();

	public function new() : Void
	{
		_space = new Space(new Vec2(0, 1300));
		_space.listeners.add(new InteractionListener(CbEvent.BEGIN,InteractionType.COLLISION, _NORMAL, _NORMAL, normal_normal));
	}

	override public function onStart() : Void
	{
		#if flash
			owner.add(new Debug(_space));
		#end
	}

	override public function onUpdate (dt :Float) : Void
	{
		_space.step(dt);
	}

	public function addBody(body :nape.phys.Body) : Void
	{
		body.space = _space;
		body.cbTypes.add(_NORMAL);
	}


	private function normal_normal(collision:InteractionCallback) :Void
	{
		var body1 = collision.int1.castBody;
		var body2 = collision.int2.castBody;
		var impulse = body1.totalImpulse(body2).y;

		if(body2.userData.component != null)
			body2.userData.component.handleBodyCallback(impulse);

		if(body1.userData.component != null)
			body1.userData.component.handleBodyCallback(impulse);
	}

	private var _space :Space;
}