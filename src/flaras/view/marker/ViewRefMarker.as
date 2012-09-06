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
	import flaras.controller.*;
	import flaras.controller.util.*;
	import flaras.model.marker.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.primitives.*;
	
	public class ViewRefMarker 
	{
		
		private var _obj3DRefBaseRectanglePlane:DisplayObject3D;
		private var _obj3DRefBasePoint:DisplayObject3D;
		
		public function ViewRefMarker()
		{			
			_obj3DRefBaseRectanglePlane = new Plane(Color.white, 80, 80);
			_obj3DRefBaseRectanglePlane.position = Number3D.ZERO;
			_obj3DRefBaseRectanglePlane.rotationX = -180;
			_obj3DRefBaseRectanglePlane.visible = false;
			MarkerNodeManager.addObj2MarkerNode(_obj3DRefBaseRectanglePlane, CtrMarker.REFERENCE_MARKER, null);
			
			_obj3DRefBasePoint = new Sphere(Color.white, 5, 10, 10);
			_obj3DRefBasePoint.position = Number3D.ZERO;
			_obj3DRefBasePoint.visible = false;
			MarkerNodeManager.addObj2MarkerNode(_obj3DRefBasePoint, CtrMarker.REFERENCE_MARKER, null);
		}
		
		public function updateView(pModelRefMarker:ModelRefMarker):void
		{
			if (pModelRefMarker.getBaseType() == CtrMarker.REF_BASE_POINT)
			{
				_obj3DRefBasePoint.visible = true;
				_obj3DRefBaseRectanglePlane.visible = false;
			}
			else
			{
				_obj3DRefBasePoint.visible = false;
				_obj3DRefBaseRectanglePlane.visible = true;
			}
		}
	}	
}