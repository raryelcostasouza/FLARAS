/**
 * FLARAS - Flash Augmented Reality Authoring System
 * --------------------------------------------------------------------------------
 * Copyright (C) 2011-2012 Raryel, Hipolito, Claudio
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * --------------------------------------------------------------------------------
 * Developers:
 * Raryel Costa Souza - raryel.costa[at]gmail.com
 * Hipolito Douglas Franca Moreira - hipolitodouglas[at]gmail.com
 *
 * Advisor: Claudio Kirner - ckirner[at]gmail.com
 * http://www.ckirner.com/flaras
 * Developed at UNIFEI - Federal University of Itajuba (www.unifei.edu.br) - Minas Gerais - Brazil
 * Research scholarship by FAPEMIG - Fundação de Amparo à Pesquisa no Estado de Minas Gerais
 */

package flaras.view.scene
{
	import flaras.controller.*;
	import flaras.controller.constants.*;
	import flaras.model.*;
	import flaras.model.scene.*;
	import flaras.view.marker.*;
	import flash.events.*;
	import flash.filesystem.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.events.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.parsers.*;
	
	public class ViewVirtualObjectScene extends ViewFlarasScene
	{
		private var _virtualObjectScene:VirtualObjectScene;
		
		public function ViewVirtualObjectScene(virtualObjectScene:VirtualObjectScene, pCtrMain:CtrMain)
		{
			super(this, virtualObjectScene, pCtrMain);
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
				objDAE.addEventListener(FileLoadEvent.LOAD_COMPLETE, onComplete);
				objDAE.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				objDAE.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
				
				objDAE.load(FolderConstants.getFlarasAppCurrentFolder() + "/" + _virtualObjectScene.getPath3DObjectFile());
				_obj3D = objDAE;
			}
			else
			{
				objMax3DS = new Max3DS();
				objMax3DS.addEventListener(FileLoadEvent.LOAD_COMPLETE, onComplete);
				objMax3DS.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				objMax3DS.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
				
				objMax3DS.load(FolderConstants.getFlarasAppCurrentFolder() + "/" + _virtualObjectScene.getPath3DObjectFile(),
					null, FolderConstants.getFlarasAppCurrentFolder() + "/" + Util.getMax3DSTextureFolder(_virtualObjectScene.getPath3DObjectFile()));
				_obj3D = objMax3DS;
			}
			
			setObj3DProperties(_virtualObjectScene, _obj3D);
			
			MarkerNodeManager.addObj2MarkerNode(_obj3D, CtrMarker.REFERENCE_MARKER, null);
		}
		
		override public function unLoad():void
		{
			if (_obj3D)
			{
				super.unLoad();
				
				MarkerNodeManager.removeObjFromMarkerNode(_obj3D, CtrMarker.REFERENCE_MARKER);
				_obj3D = null;
			}
		}
		
		override public function destroy():void
		{
			unLoad();
			super.destroy();
			_virtualObjectScene = null;
		}
		
		private function onComplete(e:Event):void
		{
			e.target.removeEventListener(FileLoadEvent.LOAD_COMPLETE, onComplete);
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			e.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			setupMouseInteraction();
		}
		
		private function onIOError(e:Event):void
		{
			ErrorHandler.onIOError("ViewVirtualObjectScene", FolderConstants.getFlarasAppCurrentFolder() + "/" + _virtualObjectScene.getPath3DObjectFile());
		}
		
		private function onSecurityError(e:Event):void
		{
			ErrorHandler.onSecurityError("ViewVirtualObjectScene", FolderConstants.getFlarasAppCurrentFolder() + "/" + _virtualObjectScene.getPath3DObjectFile());
		}
	}
}