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
	import flaras.view.marker.*;
	import flash.events.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.parsers.*;
	import org.papervision3d.objects.primitives.*;
	
	public class ViewPoint 
	{
		private var _obj3DSphereOfPoint:DisplayObject3D;
		private var _obj3DAuxSphere:DisplayObject3D;
		private var _obj3DAxis:DAE;
		
		public static const RADIUS_SPHERE_OF_POINT:uint = 10;
		
		public function ViewPoint(position:Number3D) 
		{
			_obj3DSphereOfPoint = new Sphere(Color.gray, RADIUS_SPHERE_OF_POINT, 10, 10);
			_obj3DSphereOfPoint.position = position;
			
			_obj3DAuxSphere = new Sphere(Color.blue, RADIUS_SPHERE_OF_POINT, 10, 10);
			_obj3DAuxSphere.position = position;
			_obj3DAuxSphere.visible = false;
			
			_obj3DAxis = new DAE();
			_obj3DAxis.load(SystemFilesPathsConstants.OBJ_PATH_AXIS);
			_obj3DAxis.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
			_obj3DAxis.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous)
			_obj3DAxis.scale = 10;
			_obj3DAxis.position = position;
			_obj3DAxis.visible = false;
			
			MarkerNodeManager.addObj2MarkerNode(_obj3DSphereOfPoint, CtrMarker.REFERENCE_MARKER , null);
			MarkerNodeManager.addObj2MarkerNode(_obj3DAuxSphere, CtrMarker.REFERENCE_MARKER, null);
			MarkerNodeManager.addObj2MarkerNode(_obj3DAxis, CtrMarker.REFERENCE_MARKER, null);
		}
		
		public function hidePointSphere():void
		{
			_obj3DSphereOfPoint.visible = false;
		}
		
		public function showPointSphere():void
		{
			_obj3DSphereOfPoint.visible = true;
		}
		
		public function hideAuxSphere():void
		{
			_obj3DAuxSphere.visible = false;
		}
		
		public function showAuxSphere():void
		{
			_obj3DAuxSphere.visible = true;
		}
		
		public function toggleVisibleAuxSphere():void
		{
			if (_obj3DAuxSphere.visible)
			{
				_obj3DAuxSphere.visible = false;
			}
			else
			{
				_obj3DAuxSphere.visible = true;
			}
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
			_obj3DAuxSphere.position = position;
			_obj3DAxis.position = position;
		}
		
		public function destroy():void
		{
			MarkerNodeManager.removeObjFromMarkerNode(_obj3DSphereOfPoint, CtrMarker.REFERENCE_MARKER);
			MarkerNodeManager.removeObjFromMarkerNode(_obj3DAuxSphere, CtrMarker.REFERENCE_MARKER);
			MarkerNodeManager.removeObjFromMarkerNode(_obj3DAxis, CtrMarker.REFERENCE_MARKER);
			
			_obj3DSphereOfPoint = null;
			_obj3DAuxSphere = null;
			_obj3DAxis = null;
		}
	}
}