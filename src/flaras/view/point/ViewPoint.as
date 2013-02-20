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

package flaras.view.point 
{
	import flaras.controller.*;
	import flaras.controller.constants.*;
	import flaras.controller.util.*;
	import flaras.model.point.*;
	import flaras.view.marker.*;
	import flash.events.*;
	import flash.filters.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.events.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.parsers.*;
	import org.papervision3d.objects.primitives.*;
	import org.papervision3d.view.layer.*;
	
	public class ViewPoint 
	{
		private var _obj3DSphereOfPoint:DisplayObject3D;
		private var _obj3DAxis:DAE;
		
		private var _ctrMain:CtrMain;
		protected var _point:Point;
		private var  _sphereOfPointLayer:ViewportLayer;
		
		public static const RADIUS_SPHERE_OF_POINT:uint = 10;
		
		public function ViewPoint(pPoint:Point, pCtrMain:CtrMain) 
		{
			_ctrMain = pCtrMain;
			_point = pPoint;
			
			_obj3DSphereOfPoint = new Sphere(Color.gray, RADIUS_SPHERE_OF_POINT, 10, 10);
			_obj3DSphereOfPoint.position = _point.getPosition();			
			
			_obj3DAxis = new DAE();
			_obj3DAxis.load(SystemFilesPathsConstants.OBJ_PATH_AXIS);
			_obj3DAxis.addEventListener(FileLoadEvent.LOAD_COMPLETE, onComplete);
			_obj3DAxis.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_obj3DAxis.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError)
			_obj3DAxis.scale = 10;
			_obj3DAxis.position = _point.getPosition();
			_obj3DAxis.visible = false;
			
			MarkerNodeManager.addObj2MarkerNode(_obj3DSphereOfPoint, CtrMarker.REFERENCE_MARKER , null);
			MarkerNodeManager.addObj2MarkerNode(_obj3DAxis, CtrMarker.REFERENCE_MARKER, null);
			
			_sphereOfPointLayer = _ctrMain.fmmapp.getViewPort().containerSprite.getChildLayer(_obj3DSphereOfPoint, true, true);
			_sphereOfPointLayer.addEventListener(MouseEvent.CLICK, onMouseClick);
			_sphereOfPointLayer.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_sphereOfPointLayer.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		public function hidePointSphere():void
		{
			_obj3DSphereOfPoint.visible = false;
		}
		
		public function showPointSphere():void
		{
			_obj3DSphereOfPoint.visible = true;
		}
				
		public function hideAxis():void
		{
			_obj3DAxis.visible = false;
		}
		
		public function showAxis():void
		{
			_obj3DAxis.visible = true;
		}		
		
		public function isAxisVisible():Boolean
		{
			return _obj3DAxis.visible;
		}
		
		public function setPosition(position:Number3D):void
		{
			_obj3DSphereOfPoint.position = position;
			_obj3DAxis.position = position;
		}
		
		public function destroy():void
		{
			MarkerNodeManager.removeObjFromMarkerNode(_obj3DSphereOfPoint, CtrMarker.REFERENCE_MARKER);
			MarkerNodeManager.removeObjFromMarkerNode(_obj3DAxis, CtrMarker.REFERENCE_MARKER);
		
			_sphereOfPointLayer.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_sphereOfPointLayer.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_sphereOfPointLayer.removeEventListener(MouseEvent.CLICK, onMouseClick);
			
			_obj3DSphereOfPoint = null;
			_obj3DAxis = null;
		}
		
		private function onComplete(e:Event):void
		{
			e.target.removeEventListener(FileLoadEvent.LOAD_COMPLETE, onComplete);
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			e.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function onIOError(e:Event):void
		{
			ErrorHandler.onIOError("ViewPoint", SystemFilesPathsConstants.OBJ_PATH_AXIS);
		}
		
		private function onSecurityError(e:Event):void
		{
			ErrorHandler.onSecurityError("ViewPoint", SystemFilesPathsConstants.OBJ_PATH_AXIS);
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			_ctrMain.ctrInteraction.mouseClickPoint(_point);
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			e.currentTarget.filters = [new GlowFilter(0xcccc00, 1, 20, 20, 5)];
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			e.currentTarget.filters = [];
		}
	}
}