package flaras.model
{
	import flaras.constants.*;
	import flaras.entity.*;
	import flaras.model.point.*;
	import org.papervision3d.core.math.*;
	
	public class TextureScene extends FlarasScene
	{
		private var _textureFilePath:String;
		private var _width:Number;
		private var _height:Number;
		
		public function TextureScene(parentPoint:Point, translation:Number3D, rotation:Number3D, scale:Number3D,textureFilePath:String, width:Number, height:Number)
		{
			super(this, parentPoint, translation, rotation, scale);
			_textureFilePath = textureFilePath;
			_width = width;
			_height = height;
		}
		
		public function getTextureFilePath():String { return _textureFilePath; }
		public function getWidth():Number { return _width; }
		public function getHeight():Number { return _height; }
		
		public function setTexturePath(textureFilePath:String):void 
		{
			_textureFilePath = textureFilePath;
		}
		
		public function setSize(width:Number, height:Number):void
		{
			_width = width;
			_height = height;
		}
		
		override public function getListOfFilesAndDirs():Vector.<String> 
		{
			var listOfFilesAndDirs:Vector.<String>;
			
			listOfFilesAndDirs = super.getListOfFilesAndDirs();
			listOfFilesAndDirs.push(FolderConstants.getFlarasAppCurrentFolder() + "/" + _textureFilePath);
			
			return listOfFilesAndDirs;
		}
		
		override public function getBaseSceneFilePath():String 
		{
			return FolderConstants.getFlarasAppCurrentFolder() + "/" + _textureFilePath;
		}
	}
}