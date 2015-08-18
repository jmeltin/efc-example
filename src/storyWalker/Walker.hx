package storyWalker;

import flambe.Component;
import flambe.Entity;
import flambe.asset.AssetPack;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.script.*;
import flambe.animation.Ease;
import flambe.swf.MoviePlayer;
import flambe.swf.MovieSprite;
import flambe.swf.Library;

import nape.geom.Vec2;
import efc.body.Body;

class Walker extends Component
{
	public var sprite (default, null) : FillSprite;

	private var _mspr :MovieSprite;

	public var isUp : Bool = false;

	public function new(pack :AssetPack) : Void
	{
		_pack = pack;
	}

	override public function onStart() : Void
	{
		owner.add(sprite = cast new FillSprite(0x00FF00, 70, 70)
			.setXY(400, 40)
			.centerAnchor()
			.disablePixelSnapping());
	}

	public function moveLeft(speed :Float) : Void
	{
		owner.get(Body).body.position.x -= speed;
	}

	public function moveRight(speed :Float) : Void
	{
		owner.get(Body).body.position.x += speed;
	}

	public function moveUp(speed :Float) : Void
	{
		owner.get(Body).body.velocity.y -= 30;
	}

	private var _pack    : AssetPack;
	private var _container :Entity;
}