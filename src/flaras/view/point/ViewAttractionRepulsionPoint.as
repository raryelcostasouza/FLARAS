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
	import flaras.controller.util.*;
	import flaras.model.point.*;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.materials.*;
	import org.papervision3d.objects.primitives.*;
	
	public class ViewAttractionRepulsionPoint extends ViewPoint
	{	
		private var _obj3DSphereAttractionRepulsionTestArea:Sphere;
		
		public function ViewAttractionRepulsionPoint(pPoint:Point, pSphereVisible:Boolean, pCtrMain:CtrMain) 
		{
			super(pPoint, pCtrMain);
			
			_obj3DSphereAttractionRepulsionTestArea = new Sphere(new WireframeMaterial(0x000000), 50, 10, 10);
			_obj3DSphereAttractionRepulsionTestArea.position = pPoint.getPosition();
			_obj3DSphereAttractionRepulsionTestArea.rotationX = 90;
			
			if (pCtrMain.ctrGUI.getGUI())
			
			MarkerNodeManager.addObj2MarkerNode(_obj3DSphereAttractionRepulsionTestArea, CtrMarker.REFERENCE_MARKER, null);
		}	
		
		public function toggleDisplayTestAreaSphere():void
		{
			if (_obj3DSphereAttractionRepulsionTestArea.visible)
			{
				_obj3DSphereAttractionRepulsionTestArea.visible = false;
			}
			else
			{
				_obj3DSphereAttractionRepulsionTestArea.visible = true;
			}			
		}
		
		override public function setPosition(pPosition:Number3D):void
		{
			super.setPosition(pPosition);
			_obj3DSphereAttractionRepulsionTestArea.position = pPosition;
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			MarkerNodeManager.removeObjFromMarkerNode(_obj3DSphereAttractionRepulsionTestArea, CtrMarker.REFERENCE_MARKER);
			_obj3DSphereAttractionRepulsionTestArea = null;
		}
	}
}