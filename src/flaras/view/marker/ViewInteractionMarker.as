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

package flaras.view.marker
{
	import flaras.*;
	import flaras.controller.*;
	import flaras.controller.constants.*;
	import flaras.controller.io.*;
	import flaras.controller.util.*;
	import flaras.model.marker.*;
	import flash.events.*;
	import flash.net.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.events.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.primitives.*;
	
	public class ViewInteractionMarker
	{
		private var _modelInteractionMarker:ModelInteractionMarker;
		
		private var aObj3DSphere:DisplayObject3D;
		private var aObj3DCoverInspector:DisplayObject3D;
		private var aObj3DCoverControlForward:DisplayObject3D;
		private var aObj3DCoverControlBackward:DisplayObject3D;
		
		private var _filePathCurrentIOOperation:String;
		
		public function ViewInteractionMarker(pModelInteractionMarker:ModelInteractionMarker)
		{			
			_modelInteractionMarker = pModelInteractionMarker;
			
			initDefaultCover();
			build3DSphere();
		}
		
		public function getWorldMatrixObj3DSphere():Matrix3D
		{
			return aObj3DSphere.world;
		}
		
		public function updateSize():void
		{
			MarkerNodeManager.removeObjFromMarkerNode(aObj3DSphere, CtrMarker.INTERACTION_MARKER);
			build3DSphere();		
		}
		
		public function updateDistance():void
		{
			aObj3DSphere.y = _modelInteractionMarker.getSphereDistance();
		}
		
		private function initDefaultCover():void
		{	
			aObj3DCoverInspector = buildTextureCover(SystemFilesPathsConstants.TEXTURE_PATH_INSPECTOR_MARKER);
			aObj3DCoverControlForward = buildTextureCover(SystemFilesPathsConstants.TEXTURE_PATH_CONTROL_FORWARD_MARKER);
			aObj3DCoverControlBackward = buildTextureCover(SystemFilesPathsConstants.TEXTURE_PATH_CONTROL_BACKWARD_MARKER);
			
			aObj3DCoverInspector.visible = true;
			aObj3DCoverControlForward.visible = false;
			aObj3DCoverControlBackward.visible = false;
			
			MarkerNodeManager.addObj2MarkerNode(aObj3DCoverInspector, CtrMarker.INTERACTION_MARKER, null);
			MarkerNodeManager.addObj2MarkerNode(aObj3DCoverControlForward, CtrMarker.INTERACTION_MARKER, null);
			MarkerNodeManager.addObj2MarkerNode(aObj3DCoverControlBackward, CtrMarker.INTERACTION_MARKER, null);
		}
		
		private function buildTextureCover(pFilePath:String):DisplayObject3D
		{
			var obj3D:DisplayObject3D;
			var bfm:BitmapFileMaterial;
			
			bfm = new BitmapFileMaterial(pFilePath);
			bfm.addEventListener(FileLoadEvent.LOAD_COMPLETE, onComplete);
			bfm.addEventListener(FileLoadEvent.LOAD_ERROR, 
			function ():void 
			{ 
				ErrorHandler.onIOError("ViewInteractionMarker", pFilePath);
			}
			);
			
			bfm.doubleSided = true;
			
			obj3D = new Plane(bfm , 80, 80);
			obj3D.rotationX = -180;
			obj3D.position = new Number3D(0, 0, 0);
			
			return obj3D;
		}
		
		private function build3DSphere():void
		{			
			aObj3DSphere = new Sphere(Color.yellow, _modelInteractionMarker.getSphereSize(), 10, 10);
			aObj3DSphere.position = new Number3D(0, _modelInteractionMarker.getSphereDistance(), 0);
		
			MarkerNodeManager.addObj2MarkerNode(aObj3DSphere, CtrMarker.INTERACTION_MARKER, null);
		}
		
		public function change2InspectorMarker():void
		{
			aObj3DCoverInspector.visible = true;
			aObj3DCoverControlBackward.visible = false;
			aObj3DCoverControlForward.visible = false;	
		}
		
		public function change2ControlMarkerBackward():void
		{
			aObj3DCoverInspector.visible = false;
			aObj3DCoverControlBackward.visible = true;
			aObj3DCoverControlForward.visible = false;
		}
		
		public function change2ControlMarkerForward():void
		{
			aObj3DCoverInspector.visible = false;
			aObj3DCoverControlBackward.visible = false;
			aObj3DCoverControlForward.visible = true;
		}
		
		public function mirror():void
		{
			aObj3DCoverInspector.scaleX *= -1;
			aObj3DCoverControlForward.scaleX *= -1;
			aObj3DCoverControlBackward.scaleX *= -1;
		}
		
		private function onComplete(e:Event):void
		{
			e.target.removeEventListener(FileLoadEvent.LOAD_COMPLETE, onComplete);
			e.target.removeEventListener(FileLoadEvent.LOAD_ERROR, onIOError);
		}
		
		private function onIOError(e:Event):void
		{
			ErrorHandler.onIOError("ViewInteractonMarker", _filePathCurrentIOOperation);
		}	
	}	
}