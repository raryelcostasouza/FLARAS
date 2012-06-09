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

package flaras.marker
{
	import flaras.util.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.primitives.*;
	
	public class Marker 
	{
		public static const REFERENCE_MARKER:uint = 0;
		public static const INTERACTION_MARKER:uint = 1;
		
		//after removing the marker from the camera field the 3D Viewport keeps being shown
		private var _persistence:Boolean = false;
		
		public function Marker()
		{
			var aObj3DCover:DisplayObject3D;
			
			aObj3DCover = new Plane(Color.white, 80, 80);
			aObj3DCover.position = new Number3D(0, 0, 0);
			aObj3DCover.rotationX = -180;
			MarkerNodeManager.addObj2MarkerNode(aObj3DCover, REFERENCE_MARKER, null);
		}		
	
		public function get persistence():Boolean
		{
			return this._persistence;
		}
		
		public function togglePersistence():void
		{
			if (this._persistence)
			{
				this._persistence = false;
			}
			else
			{
				this._persistence = true;
			}
		}
	}	
}