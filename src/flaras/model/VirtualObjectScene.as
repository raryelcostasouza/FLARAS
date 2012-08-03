package flaras.model 
{
	import flaras.constants.FolderConstants;
	import flaras.entity.*;
	import flaras.io.Zipped3DFileImporter;
	import flash.filesystem.File;
	import org.papervision3d.core.math.*;
	
	public class VirtualObjectScene extends FlarasScene
	{
		private var _path3DObjectFile:String;
		
		public function VirtualObjectScene(parentPoint:Point, translation:Number3D, rotation:Number3D, scale:Number3D, path3DObjectFile:String) 
		{
			super(this, parentPoint, translation, rotation, scale);
			_path3DObjectFile = path3DObjectFile;
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