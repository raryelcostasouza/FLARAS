package flaras.model.scene 
{
	import flaras.constants.*;
	import flaras.controller.constants.*;
	import flaras.controller.io.*;
	import flaras.entity.*;
	import flaras.io.*;
	import flaras.model.point.*;
	import flash.filesystem.*;
	import org.papervision3d.core.math.*;
	
	public class VirtualObjectScene extends FlarasScene
	{
		private var _path3DObjectFile:String;
		
		public function VirtualObjectScene(parentPoint:Point, translation:Number3D, rotation:Number3D, scale:Number3D, path3DObjectFile:String) 
		{
			super(this, parentPoint, translation, rotation, scale);
			_path3DObjectFile = path3DObjectFile;
		}	
		
		override public function destroy():void 
		{
			super.destroy();
			_path3DObjectFile = null;
		}
		
		public function set3DObjPath(pathObj3D:String):void
		{
			_path3DObjectFile = pathObj3D;
		}
		
		public function getPath3DObjectFile():String { return _path3DObjectFile; }
		
		override public function getListOfFilesAndDirs():Vector.<String>
		{
			var listOfFilesAndDirs:Vector.<String>;
			
			listOfFilesAndDirs = super.getListOfFilesAndDirs();
			listOfFilesAndDirs.push(Zipped3DFileImporter.get3DFileExtractedFolder(new File(FolderConstants.getFlarasAppCurrentFolder() + "/" + _path3DObjectFile)).nativePath);
			
			return listOfFilesAndDirs;			
		}
		
		override public function getBaseSceneFilePath():String 
		{
			return Zipped3DFileImporter.get3DFileExtractedFolder(new File(FolderConstants.getFlarasAppCurrentFolder() + "/" + _path3DObjectFile)).nativePath;
		}
		
	}
}