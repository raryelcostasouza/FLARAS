package flaras.model 
{
	import flaras.constants.FolderConstants;
	import flaras.entity.*;
	import flash.filesystem.File;
	import org.papervision3d.core.math.*;
	public class VideoScene extends FlarasScene
	{
		private var _videoFilePath:String;
		private var _repeatVideo:Boolean;
		private var _width:Number;
		private var _height:Number;
		
		public function VideoScene(parentPoint:Point, translation:Number3D, rotation:Number3D, scale:Number3D, videoFilePath:String, repeatVideo:Boolean, width:Number, height:Number) 
		{
			super(this, parentPoint, translation, rotation, scale);
			_videoFilePath = videoFilePath;
			_repeatVideo = repeatVideo;
			_width = width;
			_height = height;
		}
		
		public function getVideoFilePath():String { return _videoFilePath; }
		public function getRepeatVideo():Boolean { return _repeatVideo; }
		public function getWidth():Number { return _width; }
		public function getHeight():Number { return _height; }
		
		public function setVideoPath(videoFilePath:String):void 
		{
			_videoFilePath = videoFilePath;
		}
		
		public function setRepeatVideo(repeatVideo:Boolean):void
		{
			_repeatVideo = repeatVideo;
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
			listOfFilesAndDirs.push(FolderConstants.getFlarasAppCurrentFolder() + "/" + _videoFilePath);
			
			return listOfFilesAndDirs;
		}	
		
		override public function getBaseSceneFilePath():String 
		{
			return FolderConstants.getFlarasAppCurrentFolder() + "/" + _videoFilePath;
		}
	}
}