package flaras.view.scene 
{
	import flaras.constants.*;
	import flaras.errorHandler.*;
	import flaras.io.*;
	import flaras.marker.*;
	import flaras.model.*;
	import flaras.model.scene.*;
	import flash.events.*;
	import flash.filesystem.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.parsers.*;
	
	public class ViewVirtualObjectScene extends ViewFlarasScene
	{		
		private var _virtualObjectScene:VirtualObjectScene;
		
		public function ViewVirtualObjectScene(virtualObjectScene:VirtualObjectScene) 
		{
			super(this, virtualObjectScene);
			_virtualObjectScene = virtualObjectScene;
		}
		
		override public function showScene(playAudio:Boolean):void
		{
			if (_obj3D)
			{
				_obj3D.visible = true;
			}
			else
			{
				load();
			}
			super.showScene(playAudio);
		}
		
		override public function hideScene():void
		{
			super.hideScene();
			if (_obj3D)
			{
				_obj3D.visible = false;
			}
		}
		
		public function load():void
		{
			var objDAE:DAE;
			var objMax3DS:Max3DS;
			
			if (_virtualObjectScene.getPath3DObjectFile().toLowerCase().indexOf(".dae") != -1)
			{
				objDAE = new DAE(true, null, true);
				objDAE.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
				objDAE.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
				//objDAE.addEventListener(FileLoadEvent.LOAD_COMPLETE, onLoadComplete);
				
				objDAE.load(FolderConstants.getFlarasAppCurrentFolder() + "/" + _virtualObjectScene.getPath3DObjectFile());	
				_obj3D = objDAE;
			}
			else
			{
				objMax3DS = new Max3DS();
				objMax3DS.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
				objMax3DS.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
				
				objMax3DS.load(FolderConstants.getFlarasAppCurrentFolder() + "/" + _virtualObjectScene.getPath3DObjectFile());
				_obj3D = objMax3DS;
			}
			
			setObj3DProperties(_virtualObjectScene, _obj3D);
			
			MarkerNodeManager.addObj2MarkerNode(_obj3D, Marker.REFERENCE_MARKER, null);
		}
		
		override public function unLoad():void
		{
			if (_obj3D)
			{
				super.unLoad();
				_obj3D.removeEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
				_obj3D.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
				
				MarkerNodeManager.removeObjFromMarkerNode(_obj3D, Marker.REFERENCE_MARKER);
				_obj3D = null;
			}			
		}	
	}
}