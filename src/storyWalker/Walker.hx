package storyWalker;

import flambe.Entity;
import flambe.Component;
import flambe.asset.AssetPack;
import flambe.display.FillSprite;
import flambe.display.Sprite;
import flambe.script.*;
import flambe.animation.Ease;
import flambe.animation.AnimatedFloat;
import flambe.util.SignalConnection;

import efc.juice.Shaker;

import nape.geom.Vec2;
import efc.body.Body;

class Walker extends Component
{
	public var sprite (default, null) : FillSprite;


	public function new(pack :AssetPack) : Void
	{
		_pack = pack;
	}

	override public function onStart() : Void
	{
		_signalPosY = _posY.changed.connect(onYChanged);

		_body = owner.get(Body);
		_body.body.userData.component = this;
		owner
			.add(sprite = cast new FillSprite(0x00FF00, 70, 70)
				.setXY(400, 40)
				.centerAnchor()
				.disablePixelSnapping())
			.addChild(_eyes
				.add(new FillSprite(0x000000, 60, 4)
					.setXY(35, 10)
					.centerAnchor())
				.addChild(new Entity()
					.add(new FillSprite(0x000000, 20, 15)
						.setXY(10, 0)))
				.addChild(new Entity()
					.add(new FillSprite(0x000000, 20, 15)
						.setXY(40, 0))));
	}

	override public function onUpdate(dt :Float) : Void
	{
		_posY.update(dt);
		_eyes.get(Sprite).scaleX.update(dt);
		_eyes.get(Sprite).scaleY.update(dt);
	}

	override public function onRemoved() : Void
	{
		_signalPosY.dispose();
	}

	public function moveLeft(speed :Float) : Void
	{
		_body.body.position.x -= speed;
		sprite.scaleX._ = -1 * Math.abs(sprite.scaleX._);
	}

	public function moveRight(speed :Float) : Void
	{
		_body.body.position.x += speed;
		sprite.scaleX._ = Math.abs(sprite.scaleX._);
	}

	public function moveUp(speed :Float) : Void
	{
		if(!_canJump)
			return;

		_canJump = false;
		_posY._ =_body.body.position.y;
		owner.add(new Script()).get(Script).run(new Parallel([
			new AnimateBy(_posY, -200, 0.5, Ease.cubeOut),
			new AnimateBy(_eyes.get(Sprite).scaleX, 1.25, 0.5, Ease.cubeOut),
			new AnimateBy(_eyes.get(Sprite).scaleY, 1.25, 0.5, Ease.cubeOut),
		]));
	}

	@:keep public function handleBodyCallback(impulse :Float) : Void
	{
		_canJump = true;
		impulse /= 5000;
		owner.getFromParents(Shaker).shake(impulse);
		_eyes.get(Sprite).setScale(1);
	}

	private function onYChanged(to :Float, from :Float) :Void
	{
		_body.body.position.y = to;
	}

	private var _body     : Body;
	private var _canJump  : Bool = false;
	private var _pack     : AssetPack;
	private var _posY     : AnimatedFloat = new AnimatedFloat(0);
	private var _eyes     : Entity = new Entity();

	private var _signalPosY :SignalConnection;
	private var _signalScale :SignalConnection;
}