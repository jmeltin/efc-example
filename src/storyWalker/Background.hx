package storyWalker;

import flambe.Entity;
import flambe.Component;
import flambe.asset.AssetPack;
import flambe.display.Sprite;
import flambe.swf.Library;
import flambe.swf.MoviePlayer;

import efc.body.MovieBody;

class Background extends Component {

	public function new(pack :AssetPack) : Void
	{
		_pack = pack;
		init();
	}

	override public function onStart() : Void
	{
		owner.addChild(_container);
	}

	public function setXY(x :Float, y :Float) :Background
	{
		_container.get(Sprite).setXY(x, y);
		return this;
	}

	private function init() : Void
	{
		_container = new Entity()
			.add(new Sprite())
			.add(_player = new MoviePlayer(new Library(_pack, "background")).loop("default"));
		_player.movie._.setAnchor(0,_player.movie._.getLayer("back").get(Sprite).getNaturalHeight());

		_player.movie._.getLayer("platform1").add(new MovieBody());
		_player.movie._.getLayer("platform2").add(new MovieBody());
		_player.movie._.getLayer("platform4").add(new MovieBody());
	}

	private var _container : Entity;
	private var _pack      : AssetPack;
	private var _player    : MoviePlayer;
	private var _position  : Float = 0;
}