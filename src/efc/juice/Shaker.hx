package efc.juice;

import flambe.Component;
import flambe.display.Sprite;
import flambe.script.*;
import flambe.asset.AssetPack;
import flambe.util.Assert;

class Shaker extends Component
{
	public function new(pack :AssetPack) : Void
	{
		_pack = pack;
	}

	override public function onStart() : Void
	{
		_canShake = true;
		Assert.that(owner.get(Sprite)!=null, "Shaker's owner must contain a sprite :Shaker.hx");
	}

	/**********************************************
	* designed for an impulse between 0.0 and 1.0 *
	**********************************************/
	public function shake(impulse :Float) : Void
	{
		if(!_canShake || impulse < MIN_IMPULSE)
			return;

		if(impulse > 1)
			impulse = 1;

		_canShake = false;
		var shakeX = impulse * SHAKE_X_MAX;
		var shakeY = impulse * SHAKE_Y_MAX;

		_pack.getSound("sounds/explosion").play(impulse);

		owner.add(new Script()).get(Script).run(new Sequence([
			new Shake(shakeX, shakeY, SHAKE_DURATION),
			new CallFunction(function(){
				_canShake = true;
			})
		]));
	}

	private var _pack     :AssetPack;
	private var _canShake :Bool = false;

	private static inline var MIN_IMPULSE = 0.2;
	private static inline var SHAKE_X_MAX = 11;
	private static inline var SHAKE_Y_MAX = 7;
	private static inline var SHAKE_DURATION = 0.3333333;
}