package storyWalker;

import flambe.Entity;
import flambe.System;
import flambe.Component;
import flambe.asset.AssetPack;

import efc.body.BodyContainer;
import efc.controller.Controller;

import flambe.input.KeyboardEvent;

import efc.body.Body;

class Game extends Component
{
	
	public function new(pack :AssetPack, container : Entity) : Void
	{
		_pack = pack;
		_container = container;
	}

	public function run() : Game
	{
		System.root.add(new BodyContainer());
		var background = new Entity().add(_back = new Background(_pack).setXY(0, System.stage.height));
		var walker = new Entity()
			.add(new Walker(_pack))
			.add(new Body());
		var cntrl = new Entity().add(new Controller(0.4, 1.5));

		_container.addChild(background);
		_container.addChild(walker);
		_container.addChild(cntrl);

		cntrl.get(Controller).fnLeft  = walker.get(Walker).moveLeft;
		cntrl.get(Controller).fnRight = walker.get(Walker).moveRight;
		cntrl.get(Controller).fnUp = walker.get(Walker).moveUp;

		return this;
	}

	private var _back      : Background;
	private var _container : Entity;
	private var _pack      : AssetPack;
}