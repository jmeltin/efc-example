package storyWalker;

import flambe.Entity;
import flambe.System;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;

import flambe.swf.Library;
import flambe.swf.MoviePlayer;

class Main
{
	private static function main ()
	{
		System.init();

		var manifest = Manifest.fromAssets("bootstrap");
		var loader = System.loadAssetPack(manifest);
		loader.get(onSuccess);
	}

	private static function onSuccess (pack :AssetPack)
	{
		var container :Entity;
		System.root.addChild(container = new Entity());
		System.root.add(new Game(pack, container).run());
	}
}